import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' show CancelToken;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_compressor.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/media_uploader.dart';
import 'package:petalsinajar/core/media/remote_media_repository.dart';
import 'package:petalsinajar/core/media/upload_queue.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Storage and the upload API in memory. Can drop the network for the next
/// few transfers.
class _Repo implements MediaRepository {
  /// Set: transfers wait here (mid-send) until cancelled.
  Completer<void>? holdTransfers;
  final cancelled = <String>[];
  final completed = <String>[];
  int dropNext = 0;
  int next = 0;
  final requested = <String>[];

  @override
  Future<UploadTicket> request(
    PreparedFile file, {
    required MediaPurpose purpose,
    String? vendorId,
  }) async {
    requested.add(file.path);
    return UploadTicket(
      mediaId: 'm${++next}',
      plan: const UploadPlan(method: 'PUT', url: 'https://storage.test'),
    );
  }

  @override
  Future<List<CompletedPart>> transfer(
    PreparedFile file,
    UploadPlan plan, {
    UploadProgress? onProgress,
    List<CompletedPart> done = const [],
    void Function(CompletedPart part)? onPartDone,
    CancelToken? cancel,
  }) async {
    if (holdTransfers case final hold?) {
      await Future.any([hold.future, ?cancel?.whenCancel]);
      if (cancel?.isCancelled ?? false) {
        cancelled.add(file.path);
        throw const MediaUploadException('Cancelled');
      }
    }
    if (dropNext > 0) {
      dropNext--;
      throw const MediaUploadException('Offline', retryable: true);
    }
    onProgress?.call(1, 1);
    return const [];
  }

  @override
  Future<Media> complete(
    String mediaId, {
    List<CompletedPart> parts = const [],
  }) async {
    completed.add(mediaId);
    return get(mediaId);
  }

  @override
  Future<Media> get(String mediaId) async => Media(
    id: mediaId,
    kind: MediaKind.image,
    status: MediaStatus.ready,
    urls: {'feed': 'https://cdn.test/$mediaId.webp'},
  );
}

class _Compressor implements MediaCompressor {
  @override
  Future<PreparedFile> image(String path) async => PreparedFile(
    path: path,
    kind: MediaKind.image,
    mime: 'image/jpeg',
    bytes: 1000,
  );

  @override
  Future<PreparedFile> video(String path) => throw UnimplementedError();
}

void main() {
  late Directory dir;
  late _Repo repo;
  late StreamController<bool> online;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('queue');
    repo = _Repo();
    online = StreamController<bool>.broadcast();
    addTearDown(online.close);
  });

  Future<ProviderContainer> container({
    Map<String, Object> prefs = const {},
    bool instantRetries = false,
  }) async {
    SharedPreferences.setMockInitialValues(prefs);
    final shared = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(shared),
        uploadDirectoryProvider.overrideWith((ref) async => dir),
        onlineProvider.overrideWith((ref) => online.stream),
        if (instantRetries)
          uploadBackoffProvider.overrideWithValue((_) => Duration.zero),
        mediaRepositoryProvider.overrideWithValue(repo),
        mediaUploaderProvider.overrideWithValue(
          MediaUploader(
            repo,
            _Compressor(),
            pollEvery: Duration.zero,
            maxPollEvery: Duration.zero,
          ),
        ),
      ],
    );
    addTearDown(c.dispose);
    c.listen(uploadQueueProvider, (_, _) {});
    return c;
  }

  String picked(String name) =>
      (File('${dir.path}/$name')..writeAsBytesSync([1, 2, 3])).path;

  Future<void> settle() async {
    for (var i = 0; i < 20; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  test('queued files upload one by one and end up ready', () async {
    final c = await container();
    online.add(true);

    await c.read(uploadQueueProvider.notifier).enqueue(
      'post-1',
      [
        (path: picked('a.jpg'), kind: MediaKind.image),
        (path: picked('b.jpg'), kind: MediaKind.image),
      ],
      purpose: MediaPurpose.post,
    );
    await settle();

    final jobs = c.read(uploadQueueProvider);
    expect(jobs.map((j) => j.phase), [UploadPhase.ready, UploadPhase.ready]);
    expect(jobs.map((j) => j.mediaId), ['m1', 'm2']);
    expect(repo.requested, hasLength(2));
    expect(
      jobs.every((j) => j.path.startsWith(dir.path)),
      isTrue,
      reason: 'copied into the app’s own folder',
    );
  });

  test('the queue survives a restart, and resumes where it was', () async {
    final first = await container();
    // Offline: nothing starts.
    online.add(false);
    await first.read(uploadQueueProvider.notifier).enqueue(
      'post-1',
      [(path: picked('a.jpg'), kind: MediaKind.image)],
      purpose: MediaPurpose.post,
    );
    await settle();
    expect(first.read(uploadQueueProvider).single.phase, UploadPhase.queued);
    final saved = first
        .read(sharedPreferencesProvider)
        .getString(UploadQueue.storageKey)!;
    final restored = (jsonDecode(saved) as List).cast<Map<String, dynamic>>();
    expect(restored.single['group'], 'post-1');

    // "Restart": a new container from the same saved queue, now online.
    final second = await container(prefs: {UploadQueue.storageKey: saved});
    online.add(true);
    await settle();
    expect(second.read(uploadQueueProvider).single.phase, UploadPhase.ready);
  });

  test('a job cut off mid-send restarts that step after a restart', () {
    final job = UploadJob.fromJson(const {
      'id': 'j1',
      'group': 'g',
      'path': '/x.jpg',
      'kind': 'image',
      'purpose': 'post',
      'phase': 'sending',
      'media_id': null,
      'attempts': 0,
    });
    expect(job.phase, UploadPhase.queued);
  });

  test('network failures wait and retry with backoff, then succeed', () async {
    final c = await container();
    online.add(true);
    repo.dropNext = 1;

    await c.read(uploadQueueProvider.notifier).enqueue(
      'post-1',
      [(path: picked('a.jpg'), kind: MediaKind.image)],
      purpose: MediaPurpose.post,
    );
    await settle();

    var job = c.read(uploadQueueProvider).single;
    expect(job.phase, UploadPhase.queued);
    expect(job.attempts, 1);
    expect(job.retryAt, isNotNull);
    expect(UploadQueue.backoff(1), const Duration(seconds: 2));
    expect(UploadQueue.backoff(3), const Duration(seconds: 8));
    expect(UploadQueue.backoff(20), const Duration(minutes: 5));

    c.read(uploadQueueProvider.notifier).retry(job.id);
    await settle();
    job = c.read(uploadQueueProvider).single;
    expect(job.phase, UploadPhase.ready);
  });

  test('too many network failures and it is marked failed', () async {
    final c = await container(instantRetries: true);
    online.add(true);
    repo.dropNext = 100;
    await c.read(uploadQueueProvider.notifier).enqueue(
      'post-1',
      [(path: picked('a.jpg'), kind: MediaKind.image)],
      purpose: MediaPurpose.post,
    );
    // The wake-up timer retries each time until the attempts run out.
    for (var i = 0; i < 20; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }

    final job = c.read(uploadQueueProvider).single;
    expect(job.isFailed, isTrue);
    expect(job.attempts, UploadQueue.maxAttempts);
    expect(job.error, 'Offline');
  });

  test('removing a group deletes its files', () async {
    final c = await container();
    online.add(true);
    final queue = c.read(uploadQueueProvider.notifier);
    final [job] = await queue.enqueue(
      'post-1',
      [(path: picked('a.jpg'), kind: MediaKind.image)],
      purpose: MediaPurpose.post,
    );
    await settle();
    await queue.removeGroup('post-1');
    expect(c.read(uploadQueueProvider), isEmpty);
    expect(File(job.path).existsSync(), isFalse);
  });

  test(
    'removing a group stops a file mid-send; nothing more is done',
    () async {
      final c = await container();
      repo.holdTransfers = Completer<void>();
      online.add(true);
      final queue = c.read(uploadQueueProvider.notifier);

      await queue.enqueue(
        'post-1',
        [(path: picked('a.jpg'), kind: MediaKind.image)],
        purpose: MediaPurpose.post,
      );
      await settle();
      expect(c.read(uploadQueueProvider).single.phase, UploadPhase.sending);

      await queue.removeGroup('post-1');
      await settle();

      expect(repo.cancelled, hasLength(1));
      expect(repo.completed, isEmpty, reason: 'never told the server');
      expect(c.read(uploadQueueProvider), isEmpty);
    },
  );
}
