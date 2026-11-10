import 'package:petalsinajar/core/media/media.dart';

/// A file ready to upload: compressed, with what the server needs to know.
class PreparedFile {
  const PreparedFile({
    required this.path,
    required this.kind,
    required this.mime,
    required this.bytes,
    this.width,
    this.height,
    this.durationMs,
  });

  factory PreparedFile.fromJson(Map<String, dynamic> j) => PreparedFile(
    path: j['path'] as String,
    kind: j['kind'] == 'video' ? MediaKind.video : MediaKind.image,
    mime: j['mime'] as String,
    bytes: j['bytes'] as int,
    width: j['width'] as int?,
    height: j['height'] as int?,
    durationMs: j['duration_ms'] as int?,
  );

  final String path;
  final MediaKind kind;
  final String mime;
  final int bytes;
  final int? width;
  final int? height;
  final int? durationMs;

  Map<String, dynamic> toJson() => {
    'path': path,
    'kind': kind.name,
    'mime': mime,
    'bytes': bytes,
    'width': width,
    'height': height,
    'duration_ms': durationMs,
  };
}

/// What `POST /v1/uploads` accepts (config/eventapp.php → media). Checked on
/// the phone too, so nobody waits for an upload the server will refuse.
abstract final class MediaLimits {
  static const Set<String> imageMimes = {
    'image/jpeg',
    'image/png',
    'image/heic',
    'image/webp',
  };
  static const Set<String> videoMimes = {'video/mp4', 'video/quicktime'};
  static const int imageMaxBytes = 15 * 1024 * 1024;
  static const int videoMaxBytes = 200 * 1024 * 1024;
  static const videoMaxDuration = Duration(minutes: 3);

  /// Longest edge photos are shrunk to before upload.
  static const imageMaxEdge = 1440;
  static const imageQuality = 80;

  /// Photos and videos per post.
  static const postMaxMedia = 10;

  /// Why [file] can't be uploaded, in words for people; null when fine.
  static String? problem(PreparedFile file) {
    final mb = (file.bytes / (1024 * 1024)).toStringAsFixed(0);
    return switch (file.kind) {
      MediaKind.image when !imageMimes.contains(file.mime) =>
        'That photo format isn’t supported. Use JPEG, PNG, HEIC or WebP.',
      MediaKind.image when file.bytes > imageMaxBytes =>
        'That photo is too big ($mb MB). Photos can be up to 15 MB.',
      MediaKind.video when !videoMimes.contains(file.mime) =>
        'That video format isn’t supported. Use MP4 or MOV.',
      MediaKind.video when file.bytes > videoMaxBytes =>
        'That video is too big ($mb MB), even after shrinking. Videos can be '
            'up to 200 MB — try a shorter clip.',
      MediaKind.video
          when (file.durationMs ?? 0) > videoMaxDuration.inMilliseconds =>
        'That video is too long. Videos can be up to 3 minutes.',
      _ => null,
    };
  }

  /// The type for [path] by its extension, for files the picker returns.
  static String mimeFor(String path, MediaKind kind) {
    final ext = path.split('.').last.toLowerCase();
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'heic' || 'heif' => 'image/heic',
      'webp' => 'image/webp',
      'mov' => 'video/quicktime',
      'mp4' || 'm4v' => 'video/mp4',
      _ => kind == MediaKind.video ? 'video/mp4' : 'image/jpeg',
    };
  }
}

/// A file was refused before upload (too big, too long, wrong type), or the
/// server refused or failed to process it. [message] is for people.
class MediaUploadException implements Exception {
  const MediaUploadException(this.message, {this.retryable = false});

  final String message;

  /// Network trouble rather than a problem with the file.
  final bool retryable;

  @override
  String toString() => 'MediaUploadException: $message';
}
