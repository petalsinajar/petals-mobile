import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/media_uploader.dart';

/// Stands in for the whole upload: records what was asked and returns a
/// ready media named after the file (`media-logo.jpg` for `logo.jpg`).
class FakeMediaUploader implements MediaUploader {
  final uploads = <({String path, MediaPurpose purpose, String? vendorId})>[];

  /// Set to make the next upload fail like a refused file.
  String? failWith;

  @override
  Future<Media> upload(
    String path, {
    required MediaPurpose purpose,
    MediaKind kind = MediaKind.image,
    String? vendorId,
    StageListener? onStage,
  }) async {
    if (failWith case final String message) {
      failWith = null;
      throw MediaUploadException(message);
    }
    uploads.add((path: path, purpose: purpose, vendorId: vendorId));
    final name = path.split('/').last;
    return Media(
      id: 'media-$name',
      kind: kind,
      status: MediaStatus.ready,
      urls: {
        'thumb': 'https://cdn.test/$name',
        'feed': 'https://cdn.test/$name',
      },
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
