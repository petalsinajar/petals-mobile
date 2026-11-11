import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_limits.dart';

PreparedFile _file(
  MediaKind kind, {
  String? mime,
  int bytes = 1024,
  int? durationMs,
}) => PreparedFile(
  path: 'f',
  kind: kind,
  mime: mime ?? (kind == MediaKind.video ? 'video/mp4' : 'image/jpeg'),
  bytes: bytes,
  durationMs: durationMs,
);

void main() {
  group('limits, checked before uploading', () {
    const mb = 1024 * 1024;

    test('photos up to 15 MB in the server’s formats are fine', () {
      expect(
        MediaLimits.problem(_file(MediaKind.image, bytes: 15 * mb)),
        isNull,
      );
      expect(
        MediaLimits.problem(_file(MediaKind.image, mime: 'image/heic')),
        isNull,
      );
    });

    test('too-big photos and odd formats get a friendly reason', () {
      expect(
        MediaLimits.problem(_file(MediaKind.image, bytes: 16 * mb)),
        contains('up to 15 MB'),
      );
      expect(
        MediaLimits.problem(_file(MediaKind.image, mime: 'image/gif')),
        contains('isn’t supported'),
      );
    });

    test('videos: 200 MB and 3 minutes at most', () {
      expect(
        MediaLimits.problem(
          _file(MediaKind.video, bytes: 150 * mb, durationMs: 170000),
        ),
        isNull,
      );
      expect(
        MediaLimits.problem(_file(MediaKind.video, bytes: 201 * mb)),
        contains('up to 200 MB'),
      );
      expect(
        MediaLimits.problem(_file(MediaKind.video, durationMs: 181000)),
        contains('3 minutes'),
      );
    });

    test('the type is read from the extension', () {
      expect(
        MediaLimits.mimeFor('a/IMG_1.HEIC', MediaKind.image),
        'image/heic',
      );
      expect(
        MediaLimits.mimeFor('a/clip.mov', MediaKind.video),
        'video/quicktime',
      );
    });

    test('compression targets: 1440 px, quality 80', () {
      expect(MediaLimits.imageMaxEdge, 1440);
      expect(MediaLimits.imageQuality, 80);
    });
  });

  group('Media from the API', () {
    final image = Media.fromApi(const {
      'id': 'm1',
      'kind': 'image',
      'status': 'ready',
      'width': 2048,
      'height': 1536,
      'blurhash': 'LKO2',
      'urls': {
        'thumb': 'https://cdn.test/m1/thumb.webp',
        'feed': 'https://cdn.test/m1/feed.webp',
        'full': 'https://cdn.test/m1/full.webp',
      },
      'duration_ms': null,
    });

    test('picks the smallest size that is sharp enough', () {
      expect(image.imageUrlFor(120), endsWith('thumb.webp'));
      expect(image.imageUrlFor(320), endsWith('thumb.webp'));
      expect(image.imageUrlFor(900), endsWith('feed.webp'));
      expect(image.imageUrlFor(1800), endsWith('full.webp'));
      expect(image.imageUrlFor(4000), endsWith('full.webp'));
      expect(image.aspectRatio, closeTo(4 / 3, 0.001));
    });

    test('a video has a stream and a poster', () {
      final video = Media.fromApi(const {
        'id': 'v1',
        'kind': 'video',
        'status': 'ready',
        'urls': {
          'hls': 'https://stream.test/v1.m3u8',
          'poster': 'https://stream.test/v1.jpg',
        },
        'duration_ms': 12000,
      });
      expect(video.isVideo, isTrue);
      expect(video.hlsUrl, endsWith('.m3u8'));
      expect(video.stillUrl, endsWith('.jpg'));
      expect(video.imageUrlFor(300), endsWith('.jpg'));
    });

    test('still processing: no URLs yet', () {
      final processing = Media.fromApi(const {
        'id': 'v2',
        'kind': 'video',
        'status': 'processing',
        'urls': null,
      });
      expect(processing.isReady, isFalse);
      expect(processing.stillUrl, isNull);
    });

    test('the older { url } shape still reads, as a ready image', () {
      final legacy = Media.fromApi(const {
        'url': 'https://petalsinajar.com/storage/a.jpg',
        'type': 'image',
        'w': 800,
        'h': 600,
      });
      expect(legacy.isReady, isTrue);
      expect(
        legacy.imageUrlFor(2000),
        'https://petalsinajar.com/storage/a.jpg',
      );
      expect(legacy.width, 800);
    });
  });
}
