import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_source.g.dart';

/// The phone's gallery and camera, behind a seam tests can replace.
class PhotoSource {
  const PhotoSource();

  /// Big enough for a full-screen photo, small enough to upload on 3G.
  static const _maxWidth = 1600.0;
  static const _quality = 85;

  Future<List<String>> gallery({required int limit}) async {
    if (limit <= 0) return const [];
    final files = limit == 1
        ? [
            ?await ImagePicker().pickImage(
              source: ImageSource.gallery,
              maxWidth: _maxWidth,
              imageQuality: _quality,
            ),
          ]
        : await ImagePicker().pickMultiImage(
            maxWidth: _maxWidth,
            imageQuality: _quality,
            limit: limit,
          );
    return [for (final f in files.take(limit)) f.path];
  }

  Future<String?> camera() async => (await ImagePicker().pickImage(
    source: ImageSource.camera,
    maxWidth: _maxWidth,
    imageQuality: _quality,
  ))?.path;
}

@Riverpod(keepAlive: true)
PhotoSource photoSource(Ref ref) => const PhotoSource();
