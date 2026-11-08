import 'package:petalsinajar/core/mock/seed_loader.dart';

/// Raw API calls for the feed. Both sources return the backend's JSON; lists
/// are `{ data, next_cursor }`.
abstract interface class FeedSource {
  /// `GET /v1/feed/discover?cursor=` → posts. Works signed out.
  Future<Json> discover({String? cursor});

  /// `GET /v1/feed/following?cursor=` → posts. Signed in.
  Future<Json> following({String? cursor});

  /// `PUT /v1/posts/{id}/reaction` → `{ likes, my_reaction }`.
  Future<Json> react(String postId);

  /// `DELETE /v1/posts/{id}/reaction` → `{ likes, my_reaction: null }`.
  Future<Json> unreact(String postId);

  /// `GET /v1/posts/{id}/comments?cursor=` → comments, oldest first.
  Future<Json> comments(String postId, {String? cursor});

  /// `POST /v1/posts/{id}/comments` `{ body }` → comment.
  Future<Json> addComment(String postId, String body);
}
