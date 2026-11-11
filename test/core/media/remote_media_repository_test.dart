import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/remote_media_repository.dart';

import '../../helpers/fake_http_adapter.dart';

/// The upload contract against JSON shaped like `UploadController` and
/// `Media::toPayload`, and plain HTTP to (pre-signed) storage.
void main() {
  late FakeHttpAdapter api;
  late FakeHttpAdapter storage;
  late RemoteMediaRepository repo;
  late File file;
  var storageFailures = 0;

  setUp(() {
    storageFailures = 0;
    file = File('${Directory.systemTemp.createTempSync().path}/a.jpg')
      ..writeAsBytesSync(List.filled(12, 7));
    api = FakeHttpAdapter((o) async {
      final data = o.data is Map
          ? o.data as Map<String, dynamic>
          : const <String, dynamic>{};
      return switch ((o.method, o.path)) {
        ('POST', '/uploads') when data['bytes'] == 999 => jsonBody(422, {
          'message': 'The file is too big (at most 15 MB).',
          'errors': {
            'bytes': ['The file is too big (at most 15 MB).'],
          },
        }),
        ('POST', '/uploads') => jsonBody(201, {
          'media_id': 'm1',
          'kind': data['kind'],
          'status': 'pending',
          'upload': {
            'method': 'PUT',
            'url': 'https://storage.test/m1?sig=abc',
            'headers': {'Content-Type': 'image/jpeg'},
            'expires_at': '2026-11-10T10:10:00+00:00',
          },
        }),
        ('POST', '/uploads/m1/complete') => jsonBody(200, {
          'id': 'm1',
          'kind': 'image',
          'status': 'processing',
          'urls': null,
        }),
        ('GET', '/media/m1') => jsonBody(200, {
          'id': 'm1',
          'kind': 'image',
          'status': 'ready',
          'width': 1440,
          'height': 1080,
          'blurhash': 'LKO2',
          'urls': {
            'thumb': 'https://cdn.test/m1/thumb.webp',
            'feed': 'https://cdn.test/m1/feed.webp',
            'full': 'https://cdn.test/m1/full.webp',
          },
          'attached': false,
        }),
        _ => jsonBody(404, {'message': 'Not found'}),
      };
    });
    storage = FakeHttpAdapter((o) async {
      if (storageFailures > 0) {
        storageFailures--;
        return jsonBody(503, {'message': 'busy'});
      }
      return ResponseBody.fromString(
        '',
        200,
        headers: {
          'etag': ['"etag-${o.uri.queryParameters['partNumber'] ?? '1'}"'],
        },
      );
    });
    repo = RemoteMediaRepository(
      Dio(BaseOptions(baseUrl: 'https://api.test/v1'))..httpClientAdapter = api,
      storage: Dio()..httpClientAdapter = storage,
      retryDelays: const [Duration.zero, Duration.zero, Duration.zero],
    );
  });

  PreparedFile prepared({int? bytes}) => PreparedFile(
    path: file.path,
    kind: MediaKind.image,
    mime: 'image/jpeg',
    bytes: bytes ?? 12,
  );

  test('request → PUT straight to storage → complete → ready', () async {
    final ticket = await repo.request(
      prepared(),
      purpose: MediaPurpose.eventCover,
      vendorId: 'v1',
    );
    expect(api.requests.single.data, {
      'kind': 'image',
      'purpose': 'event_cover',
      'mime': 'image/jpeg',
      'bytes': 12,
      'vendor_id': 'v1',
    });

    var progress = 0.0;
    await repo.transfer(
      prepared(),
      ticket.plan,
      onProgress: (sent, total) => progress = sent / total,
    );
    final put = storage.requests.single;
    expect(put.method, 'PUT');
    expect(put.uri.toString(), 'https://storage.test/m1?sig=abc');
    expect(put.headers['Content-Type'], 'image/jpeg');
    expect(
      put.headers.containsKey('Authorization'),
      isFalse,
      reason: 'pre-signed: no API token to storage',
    );
    expect(progress, 1);

    final completed = await repo.complete('m1');
    expect(completed.status, MediaStatus.processing);
    final ready = await repo.get('m1');
    expect(ready.isReady, isTrue);
    expect(ready.imageUrlFor(1080), endsWith('feed.webp'));
  });

  test('a busy storage is retried with backoff', () async {
    storageFailures = 2;
    final ticket = await repo.request(prepared(), purpose: MediaPurpose.post);
    await repo.transfer(prepared(), ticket.plan);
    expect(storage.requests, hasLength(3));
  });

  test(
    'multipart: each part PUT with its slice, ETags kept, done parts skipped',
    () async {
      const plan = UploadPlan(
        method: 'PUT',
        parts: [
          UploadPart(
            number: 1,
            url: 'https://storage.test/m1?partNumber=1',
            bytes: 5,
          ),
          UploadPart(
            number: 2,
            url: 'https://storage.test/m1?partNumber=2',
            bytes: 5,
          ),
          UploadPart(
            number: 3,
            url: 'https://storage.test/m1?partNumber=3',
            bytes: 2,
          ),
        ],
      );

      final parts = await repo.transfer(
        prepared(),
        plan,
        done: const [(number: 1, etag: '"etag-1"')],
      );

      expect(
        storage.requests.map((r) => r.uri.queryParameters['partNumber']),
        [
          '2',
          '3',
        ],
        reason: 'part 1 finished in an earlier run',
      );
      expect(parts.map((p) => p.etag), ['"etag-1"', '"etag-2"', '"etag-3"']);
      expect(storage.bodyBytes, [5, 2], reason: 'each part is its own slice');
    },
  );

  test('a file the server refuses says why', () async {
    await expectLater(
      repo.request(prepared(bytes: 999), purpose: MediaPurpose.post),
      throwsA(
        isA<MediaRejected>().having(
          (e) => e.message,
          'message',
          contains('too big'),
        ),
      ),
    );
  });
}
