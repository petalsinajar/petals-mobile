import 'package:petalsinajar/features/posts/domain/post_draft.dart';

abstract interface class PostsRepository {
  /// Publishes [post]; returns the new post's id.
  Future<String> create(NewPost post);

  /// Deletes a post with its photos and videos. Only its poster, or an
  /// owner or manager of the business it was posted as.
  Future<void> delete(String postId);

  /// Events the viewer hosts or is going to (upcoming and recent).
  Future<List<PostableEvent>> postableEvents();

  /// Items and vendors to tag, by name.
  Future<List<TagTarget>> searchTargets(TagTargetType type, String query);
}
