import 'package:petalsinajar/features/posts/domain/post_draft.dart';

abstract interface class PostsRepository {
  /// Uploads one photo from the phone.
  Future<UploadedImage> upload(String path);

  /// Publishes [post]; returns the new post's id.
  Future<String> create(NewPost post);

  /// Events the viewer hosts or is going to (upcoming and recent).
  Future<List<PostableEvent>> postableEvents();

  /// Items and vendors to tag, by name.
  Future<List<TagTarget>> searchTargets(TagTargetType type, String query);
}
