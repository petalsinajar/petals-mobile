import 'package:image_picker/image_picker.dart';

/// Picks a photo from the gallery; replaceable in tests.
typedef BusinessPhotoPicker = Future<String?> Function({required bool logo});

/// Logos are shown small, so they're kept small; covers are wide.
Future<String?> pickBusinessPhoto({required bool logo}) async {
  final file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: logo ? 800 : 1600,
    imageQuality: 85,
  );
  return file?.path;
}

/// Picks an item photo from the camera or gallery; replaceable in tests.
typedef ItemPhotoPicker = Future<String?> Function({required bool camera});

/// Product shots: big enough to zoom, small enough to upload on 3G.
Future<String?> pickItemPhoto({required bool camera}) async {
  final file = await ImagePicker().pickImage(
    source: camera ? ImageSource.camera : ImageSource.gallery,
    maxWidth: 1600,
    imageQuality: 85,
  );
  return file?.path;
}
