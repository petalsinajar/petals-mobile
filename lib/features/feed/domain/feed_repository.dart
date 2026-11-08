import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';

/// The two feeds on the home tab.
enum FeedKind {
  /// Public posts ranked by engagement. Works signed out.
  forYou,

  /// Posts from people, vendors and events the viewer follows. Signed in.
  following,
}

abstract interface class FeedRepository {
  Future<Paginated<FeedPost>> feed(FeedKind kind, {String? cursor});

  /// Likes [postId]; returns the server's like count. Signed in only.
  Future<int> like(String postId);

  /// Removes the viewer's like; returns the server's like count.
  Future<int> unlike(String postId);

  /// Top-level comments, oldest first.
  Future<Paginated<PostComment>> comments(String postId, {String? cursor});

  /// Adds a comment as the signed-in user.
  Future<PostComment> addComment(String postId, String body);
}
