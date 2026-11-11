import 'package:image_picker/image_picker.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_source.g.dart';

const _videoExtensions = {'mp4', 'mov', 'm4v', '3gp', 'webm', 'mkv'};

bool isVideoPath(String path) =>
    _videoExtensions.contains(path.split('.').last.toLowerCase());

/// The phone's gallery and camera, behind a seam tests can replace.
/// Picks are the originals: the shared uploader compresses them.
class PhotoSource {
  const PhotoSource();

  /// Photos and videos from the gallery, up to [limit].
  Future<List<DraftPhoto>> gallery({required int limit}) async {
    if (limit <= 0) return const [];
    final files = limit == 1
        ? [?await ImagePicker().pickMedia()]
        : await ImagePicker().pickMultipleMedia(limit: limit);
    return [
      for (final f in files.take(limit))
        DraftPhoto(path: f.path, isVideo: isVideoPath(f.path)),
    ];
  }

  Future<DraftPhoto?> camera() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    return file == null ? null : DraftPhoto(path: file.path);
  }

  /// Up to the server's three minutes.
  Future<DraftPhoto?> recordVideo() async {
    final file = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 3),
    );
    return file == null ? null : DraftPhoto(path: file.path, isVideo: true);
  }
}

@Riverpod(keepAlive: true)
PhotoSource photoSource(Ref ref) => const PhotoSource();
