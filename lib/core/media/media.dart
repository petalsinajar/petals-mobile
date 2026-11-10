import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';

enum MediaKind { image, video }

/// The server's processing state. Only [ready] media has URLs.
enum MediaStatus { pending, uploaded, processing, ready, failed, rejected }

/// A photo or video as the API describes it (`Media::toPayload`).
///
/// Images come in `thumb` (320 px), `feed` (1080 px) and `full` (2048 px);
/// videos as `hls` (a stream) and `poster` (a still).
@freezed
abstract class Media with _$Media {
  const factory Media({
    required String id,
    required MediaKind kind,
    required MediaStatus status,
    @Default(<String, String>{}) Map<String, String> urls,
    int? width,
    int? height,
    String? blurhash,
    int? durationMs,
  }) = _Media;

  const Media._();

  /// From the API. Also reads the older `{ url, type, w, h }` shape, which
  /// was a ready image (or video) at a single size.
  factory Media.fromApi(Map<String, dynamic> j) {
    final legacyUrl = j['url'];
    if (legacyUrl is String && j['urls'] == null) {
      final isVideo = j['type'] == 'video';
      return Media(
        id: j['id'] as String? ?? legacyUrl,
        kind: isVideo ? MediaKind.video : MediaKind.image,
        status: MediaStatus.ready,
        urls: isVideo
            ? {'hls': legacyUrl}
            : {'thumb': legacyUrl, 'feed': legacyUrl, 'full': legacyUrl},
        width: j['w'] as int?,
        height: j['h'] as int?,
        blurhash: j['blurhash'] as String?,
        durationMs: j['duration_ms'] as int?,
      );
    }
    return Media(
      id: j['id'] as String,
      kind: j['kind'] == 'video' ? MediaKind.video : MediaKind.image,
      status: MediaStatus.values.firstWhere(
        (s) => s.name == j['status'],
        orElse: () => MediaStatus.pending,
      ),
      urls: {
        for (final MapEntry(:key, :value)
            in ((j['urls'] as Map?) ?? const {}).entries)
          if (value is String) key as String: value,
      },
      width: j['width'] as int?,
      height: j['height'] as int?,
      blurhash: j['blurhash'] as String?,
      durationMs: j['duration_ms'] as int?,
    );
  }

  bool get isVideo => kind == MediaKind.video;
  bool get isReady => status == MediaStatus.ready;
  bool get hasFailed =>
      status == MediaStatus.failed || status == MediaStatus.rejected;

  /// Pixel sizes of the image variants, smallest first.
  static const variantWidths = {'thumb': 320, 'feed': 1080, 'full': 2048};

  /// The smallest image variant at least [pixels] wide (falls back to the
  /// largest there is). For videos, the poster.
  String? imageUrlFor(double pixels) {
    if (isVideo) return urls['poster'];
    for (final MapEntry(:key, :value) in variantWidths.entries) {
      if (pixels <= value && urls[key] != null) return urls[key];
    }
    return urls['full'] ?? urls['feed'] ?? urls['thumb'];
  }

  /// A still to show: the feed image, or the video's poster.
  String? get stillUrl => isVideo ? urls['poster'] : urls['feed'];

  String? get hlsUrl => urls['hls'];

  /// Width / height, or null when unknown.
  double? get aspectRatio {
    final w = width;
    final h = height;
    if (w == null || h == null || w <= 0 || h <= 0) return null;
    return w / h;
  }
}
