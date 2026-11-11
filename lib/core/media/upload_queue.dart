import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' show CancelToken;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/media_uploader.dart';
import 'package:petalsinajar/core/media/remote_media_repository.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'upload_queue.g.dart';

enum UploadPhase { queued, preparing, sending, processing, ready, failed }

/// One file in the queue. Everything here is persisted, so an upload picks
/// up where it was after the app restarts.
@immutable
class UploadJob {
  const UploadJob({
    required this.id,
    required this.group,
    required this.path,
    required this.kind,
    required this.purpose,
    this.vendorId,
    this.phase = UploadPhase.queued,
    this.progress = 0,
    this.prepared,
    this.mediaId,
    this.attempts = 0,
    this.retryAt,
    this.error,
  });

  factory UploadJob.fromJson(Map<String, dynamic> j) => UploadJob(
    id: j['id'] as String,
    group: j['group'] as String,
    path: j['path'] as String,
    kind: MediaKind.values.byName(j['kind'] as String),
    purpose: MediaPurpose.values.byName(j['purpose'] as String),
    vendorId: j['vendor_id'] as String?,
    // A job cut off mid-send restarts that step; finished steps stay done.
    phase: switch (UploadPhase.values.byName(j['phase'] as String)) {
      UploadPhase.preparing || UploadPhase.sending => UploadPhase.queued,
      final p => p,
    },
    prepared: switch (j['prepared']) {
      final Map<String, dynamic> p => PreparedFile.fromJson(p),
      _ => null,
    },
    mediaId: j['media_id'] as String?,
    attempts: j['attempts'] as int? ?? 0,
    error: j['error'] as String?,
  );

  final String id;

  /// What it belongs to (e.g. a pending post); finished together.
  final String group;

  /// The file, copied into the app's own folder so it outlives the picker.
  final String path;
  final MediaKind kind;
  final MediaPurpose purpose;
  final String? vendorId;
  final UploadPhase phase;

  /// 0..1 while sending.
  final double progress;
  final PreparedFile? prepared;

  /// Set once the server knows the upload; from then on only processing
  /// is left.
  final String? mediaId;
  final int attempts;

  /// When to try again after a network failure.
  final DateTime? retryAt;

  /// Why it failed for good, in words for people.
  final String? error;

  bool get isDone => phase == UploadPhase.ready;
  bool get isFailed => phase == UploadPhase.failed;

  UploadJob copyWith({
    UploadPhase? phase,
    double? progress,
    PreparedFile? prepared,
    String? mediaId,
    int? attempts,
    DateTime? retryAt,
    bool clearRetry = false,
    String? error,
    bool clearError = false,
  }) => UploadJob(
    id: id,
    group: group,
    path: path,
    kind: kind,
    purpose: purpose,
    vendorId: vendorId,
    phase: phase ?? this.phase,
    progress: progress ?? this.progress,
    prepared: prepared ?? this.prepared,
    mediaId: mediaId ?? this.mediaId,
    attempts: attempts ?? this.attempts,
    retryAt: clearRetry ? null : (retryAt ?? this.retryAt),
    error: clearError ? null : (error ?? this.error),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'group': group,
    'path': path,
    'kind': kind.name,
    'purpose': purpose.name,
    'vendor_id': vendorId,
    'phase': phase.name,
    'prepared': prepared?.toJson(),
    'media_id': mediaId,
    'attempts': attempts,
    'error': error,
  };
}

/// Where queued files are kept; replaceable in tests.
@Riverpod(keepAlive: true)
Future<Directory> uploadDirectory(Ref ref) async {
  final dir = Directory(
    '${(await getApplicationSupportDirectory()).path}/uploads',
  );
  return dir.create(recursive: true);
}

/// Whether the phone is online, as a stream; replaceable in tests.
@Riverpod(keepAlive: true)
Stream<bool> online(Ref ref) async* {
  final connectivity = Connectivity();
  bool isOnline(List<ConnectivityResult> r) =>
      r.any((c) => c != ConnectivityResult.none);
  yield isOnline(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(isOnline);
}

/// How long to wait before retry number `attempt`; replaceable in tests.
@Riverpod(keepAlive: true)
Duration Function(int attempt) uploadBackoff(Ref ref) => UploadQueue.backoff;

/// Uploads that carry on in the background, survive restarts, pause while
/// offline and retry network failures with growing waits. One at a time,
/// oldest first, so a slow phone isn't swamped.
@Riverpod(keepAlive: true)
class UploadQueue extends _$UploadQueue {
  static const storageKey = 'media.upload_queue';

  /// Tries before a network-failing job is marked failed.
  static const maxAttempts = 6;

  var _running = false;
  var _online = true;
  Timer? _wake;

  @override
  List<UploadJob> build() {
    ref
      ..listen(onlineProvider, (_, next) {
        final online = next.value ?? true;
        final cameBack = online && !_online;
        _online = online;
        if (cameBack) unawaited(_pump());
      }, fireImmediately: true)
      ..onDispose(() => _wake?.cancel());

    final raw = ref.read(sharedPreferencesProvider).getString(storageKey);
    final jobs = <UploadJob>[];
    if (raw != null) {
      try {
        for (final j
            in (jsonDecode(raw) as List).cast<Map<String, dynamic>>()) {
          jobs.add(UploadJob.fromJson(j));
        }
      } on Object {
        // A corrupt queue isn't worth crashing for; start empty.
      }
    }
    if (jobs.isNotEmpty) scheduleMicrotask(_pump);
    return jobs;
  }

  Future<void> _save() => ref
      .read(sharedPreferencesProvider)
      .setString(storageKey, jsonEncode([for (final j in state) j.toJson()]));

  void _put(UploadJob job, {bool persist = true}) {
    state = [for (final j in state) j.id == job.id ? job : j];
    if (persist) unawaited(_save());
  }

  List<UploadJob> jobsIn(String group) => [
    for (final j in state)
      if (j.group == group) j,
  ];

  /// Copies `files` into the queue's folder and starts uploading them for
  /// [group]. Returns the jobs, in order.
  Future<List<UploadJob>> enqueue(
    String group,
    List<({String path, MediaKind kind})> files, {
    required MediaPurpose purpose,
    String? vendorId,
  }) async {
    final dir = await ref.read(uploadDirectoryProvider.future);
    final jobs = <UploadJob>[];
    for (final f in files) {
      final id = const Uuid().v4();
      final ext = f.path.contains('.') ? f.path.split('.').last : 'bin';
      final copy = await File(f.path).copy('${dir.path}/$id.$ext');
      jobs.add(
        UploadJob(
          id: id,
          group: group,
          path: copy.path,
          kind: f.kind,
          purpose: purpose,
          vendorId: vendorId,
        ),
      );
    }
    state = [...state, ...jobs];
    await _save();
    unawaited(_pump());
    return jobs;
  }

  /// Tries a failed job again from where it stopped.
  void retry(String jobId) {
    final job = state.where((j) => j.id == jobId).firstOrNull;
    if (job == null) return;
    _put(
      job.copyWith(
        phase: UploadPhase.queued,
        attempts: 0,
        clearRetry: true,
        clearError: true,
      ),
    );
    unawaited(_pump());
  }

  /// Forgets [group]'s jobs and deletes their files.
  Future<void> removeGroup(String group) async {
    final gone = jobsIn(group);
    for (final j in gone) {
      _cancels.remove(j.id)?.cancel('Discarded');
    }
    state = [
      for (final j in state)
        if (j.group != group) j,
    ];
    await _save();
    for (final j in gone) {
      for (final path in {j.path, ?j.prepared?.path}) {
        try {
          await File(path).delete();
        } on Object {
          // Already gone.
        }
      }
    }
  }

  UploadJob? _next() {
    final now = DateTime.now();
    return state
        .where(
          (j) =>
              (j.phase == UploadPhase.queued ||
                  j.phase == UploadPhase.processing) &&
              (j.retryAt == null || !j.retryAt!.isAfter(now)),
        )
        .firstOrNull;
  }

  /// Works through the queue, one job at a time, while online.
  Future<void> _pump() async {
    if (_running) return;
    _running = true;
    try {
      while (ref.mounted && _online) {
        final job = _next();
        if (job == null) break;
        await _run(job);
      }
    } finally {
      _running = false;
      if (ref.mounted) _scheduleWake();
    }
  }

  /// Comes back for the soonest job waiting to retry.
  void _scheduleWake() {
    _wake?.cancel();
    final waits = [
      for (final j in state)
        if (j.phase == UploadPhase.queued && j.retryAt != null) j.retryAt!,
    ];
    if (waits.isEmpty) return;
    final soonest = waits.reduce((a, b) => a.isBefore(b) ? a : b);
    final delay = soonest.difference(DateTime.now());
    _wake = Timer(delay.isNegative ? Duration.zero : delay, _pump);
  }

  /// 2 s, 4 s, 8 s … up to 5 minutes.
  @visibleForTesting
  static Duration backoff(int attempt) =>
      Duration(seconds: math.min(300, 2 * math.pow(2, attempt - 1).toInt()));

  /// Stops a job's file mid-send when its group is removed.
  final _cancels = <String, CancelToken>{};

  /// False once the job was removed (its post discarded): stop working on it.
  bool _alive(UploadJob job) => ref.mounted && state.any((j) => j.id == job.id);

  Future<void> _run(UploadJob start) async {
    final uploader = ref.read(mediaUploaderProvider);
    final repo = ref.read(mediaRepositoryProvider);
    var job = start.copyWith(clearRetry: true);
    final cancel = _cancels[job.id] = CancelToken();
    try {
      if (job.mediaId == null) {
        _put(job = job.copyWith(phase: UploadPhase.preparing, progress: 0));
        final prepared =
            job.prepared ?? await uploader.prepare(job.path, job.kind);
        _put(job = job.copyWith(prepared: prepared));

        if (!_alive(job)) return;
        final ticket = await repo.request(
          prepared,
          purpose: job.purpose,
          vendorId: job.vendorId,
        );
        if (!_alive(job)) return;
        _put(job = job.copyWith(phase: UploadPhase.sending));
        var shown = 0.0;
        final parts = await repo.transfer(
          prepared,
          ticket.plan,
          onProgress: (sent, total) {
            final p = total == 0 ? 0.0 : sent / total;
            // Every 2%: smooth enough, without rebuilding on each packet.
            if (p - shown >= 0.02 || p >= 1) {
              shown = p;
              _put(job = job.copyWith(progress: p), persist: false);
            }
          },
          cancel: cancel,
        );
        if (!_alive(job)) return;
        await repo.complete(ticket.mediaId, parts: parts);
        _put(
          job = job.copyWith(
            mediaId: ticket.mediaId,
            phase: UploadPhase.processing,
            progress: 1,
          ),
        );
      }
      if (!_alive(job)) return;
      final ready = await uploader.waitUntilReady(await repo.get(job.mediaId!));
      _put(job.copyWith(phase: UploadPhase.ready, mediaId: ready.id));
    } on MediaUploadException catch (e) {
      if (!_alive(job)) return;
      _fail(job, e.message, retryable: e.retryable);
    } on Object catch (e) {
      if (!_alive(job)) return;
      // Socket errors and the like: assume the network.
      _fail(job, 'Upload interrupted.', retryable: e is IOException);
    } finally {
      _cancels.remove(job.id);
    }
  }

  void _fail(UploadJob job, String message, {required bool retryable}) {
    final attempts = job.attempts + 1;
    if (retryable && attempts < maxAttempts) {
      _put(
        job.copyWith(
          // Before the server knew it, start over; after, keep waiting on it.
          phase: job.mediaId == null
              ? UploadPhase.queued
              : UploadPhase.processing,
          attempts: attempts,
          retryAt: DateTime.now().add(
            ref.read(uploadBackoffProvider)(attempts),
          ),
        ),
      );
      return;
    }
    _put(
      job.copyWith(
        phase: UploadPhase.failed,
        attempts: attempts,
        error: message,
      ),
    );
  }
}
