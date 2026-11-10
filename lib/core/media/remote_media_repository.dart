import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_media_repository.g.dart';

typedef _Json = Map<String, dynamic>;

/// [MediaRepository] over the API ([_api]) and plain HTTP to storage
/// ([_storage]: no base URL, no auth header — the URLs are pre-signed).
class RemoteMediaRepository implements MediaRepository {
  RemoteMediaRepository(this._api, {Dio? storage, this.retryDelays = _delays})
    : _storage = storage ?? Dio();

  final Dio _api;
  final Dio _storage;

  /// Waits between attempts on network errors; one attempt per entry, plus
  /// the first.
  final List<Duration> retryDelays;

  static const _delays = [
    Duration(seconds: 1),
    Duration(seconds: 3),
    Duration(seconds: 9),
  ];

  bool _isNetwork(DioException e) => switch (e.type) {
    DioExceptionType.connectionError ||
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => true,
    // Storage hiccups (5xx) are worth another go too.
    DioExceptionType.badResponse => (e.response?.statusCode ?? 0) >= 500,
    _ => false,
  };

  /// Runs [send], retrying network errors with growing waits.
  Future<T> _retrying<T>(Future<T> Function() send) async {
    for (var attempt = 0; ; attempt++) {
      try {
        return await send();
      } on DioException catch (e) {
        if (!_isNetwork(e) || attempt >= retryDelays.length) rethrow;
        await Future<void>.delayed(retryDelays[attempt]);
      }
    }
  }

  Future<_Json> _apiCall(Future<Response<_Json>> Function() request) async {
    try {
      return (await _retrying(request)).data ?? const {};
    } on DioException catch (e) {
      final error = ApiException.fromDioException(e);
      if (error.type == ApiErrorType.validation) {
        throw MediaRejected(
          error.fieldErrors.values.expand((m) => m).firstOrNull ??
              error.message,
        );
      }
      throw MediaUploadException(
        error.message,
        retryable: _isNetwork(e),
      );
    }
  }

  @override
  Future<UploadTicket> request(
    PreparedFile file, {
    required MediaPurpose purpose,
    String? vendorId,
  }) async {
    final body = await _apiCall(
      () => _api.post<_Json>(
        '/uploads',
        data: {
          'kind': file.kind.name,
          'purpose': purpose.wire,
          'mime': file.mime,
          'bytes': file.bytes,
          'duration_ms': ?file.durationMs,
          'vendor_id': ?vendorId,
        },
      ),
    );
    final upload = body['upload'] as _Json;
    return UploadTicket(
      mediaId: body['media_id'] as String,
      plan: UploadPlan(
        method: upload['method'] as String? ?? 'PUT',
        url: upload['url'] as String?,
        headers: {
          for (final MapEntry(:key, :value)
              in ((upload['headers'] as Map?) ?? const {}).entries)
            key as String: '$value',
        },
        field: upload['field'] as String?,
        parts: [
          for (final p in (upload['parts'] as List? ?? const []).cast<_Json>())
            UploadPart(
              number: p['part_number'] as int,
              url: p['url'] as String,
              bytes: p['bytes'] as int,
            ),
        ],
      ),
    );
  }

  @override
  Future<List<CompletedPart>> transfer(
    PreparedFile file,
    UploadPlan plan, {
    UploadProgress? onProgress,
    List<CompletedPart> done = const [],
    void Function(CompletedPart part)? onPartDone,
  }) async {
    try {
      if (plan.isMultipart) {
        return await _multipart(file, plan, onProgress, done, onPartDone);
      }
      await _retrying(
        () => plan.isForm
            ? _form(file, plan, onProgress)
            : _single(file, plan, onProgress),
      );
      return const [];
    } on DioException catch (e) {
      throw MediaUploadException(
        _isNetwork(e)
            ? 'The upload was interrupted. It will try again.'
            : 'The upload was refused (${e.response?.statusCode}).',
        retryable: _isNetwork(e),
      );
    }
  }

  Future<void> _single(
    PreparedFile file,
    UploadPlan plan,
    UploadProgress? onProgress,
  ) => _storage.put<void>(
    plan.url!,
    // A fresh stream per attempt: a stream can only be read once.
    data: File(file.path).openRead(),
    options: Options(
      headers: {...plan.headers, Headers.contentLengthHeader: file.bytes},
    ),
    onSendProgress: onProgress,
  );

  Future<void> _form(
    PreparedFile file,
    UploadPlan plan,
    UploadProgress? onProgress,
  ) async => _storage.post<void>(
    plan.url!,
    data: FormData.fromMap({
      plan.field ?? 'file': await MultipartFile.fromFile(
        file.path,
        contentType: DioMediaType.parse(file.mime),
      ),
    }),
    options: Options(headers: plan.headers),
    onSendProgress: onProgress,
  );

  /// Sends each part not yet in [done]; a failed part is retried on its own,
  /// and a later run can resume from what finished.
  Future<List<CompletedPart>> _multipart(
    PreparedFile file,
    UploadPlan plan,
    UploadProgress? onProgress,
    List<CompletedPart> done,
    void Function(CompletedPart part)? onPartDone,
  ) async {
    final finished = {for (final p in done) p.number: p};
    final total = plan.parts.fold(0, (sum, p) => sum + p.bytes);
    var offset = 0;
    var sentBefore = plan.parts
        .where((p) => finished.containsKey(p.number))
        .fold(0, (sum, p) => sum + p.bytes);

    for (final part in plan.parts) {
      final start = offset;
      offset += part.bytes;
      if (finished.containsKey(part.number)) continue;

      final base = sentBefore;
      final response = await _retrying(
        () => _storage.put<void>(
          part.url,
          data: File(file.path).openRead(start, start + part.bytes),
          options: Options(
            headers: {Headers.contentLengthHeader: part.bytes},
          ),
          onSendProgress: (sent, _) =>
              onProgress?.call(math.min(base + sent, total), total),
        ),
      );
      final etag = response.headers.value('etag');
      if (etag == null) {
        throw const MediaUploadException('Storage gave no ETag for a part.');
      }
      final completed = (number: part.number, etag: etag);
      finished[part.number] = completed;
      onPartDone?.call(completed);
      sentBefore += part.bytes;
    }
    return [...finished.values]..sort((a, b) => a.number - b.number);
  }

  @override
  Future<Media> complete(
    String mediaId, {
    List<CompletedPart> parts = const [],
  }) async => Media.fromApi(
    await _apiCall(
      () => _api.post<_Json>(
        '/uploads/$mediaId/complete',
        data: {
          if (parts.isNotEmpty)
            'parts': [
              for (final p in parts) {'part_number': p.number, 'etag': p.etag},
            ],
        },
      ),
    ),
  );

  @override
  Future<Media> get(String mediaId) async =>
      Media.fromApi(await _apiCall(() => _api.get<_Json>('/media/$mediaId')));
}

@Riverpod(keepAlive: true)
MediaRepository mediaRepository(Ref ref) =>
    RemoteMediaRepository(ref.watch(dioProvider));
