import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/feed/data/feed_repository_impl.dart';
import 'package:petalsinajar/features/feed/domain/feed_repository.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_controllers.g.dart';

/// One of the home feeds, with infinite scroll, refresh and optimistic likes.
@riverpod
class FeedPosts extends _$FeedPosts {
  var _loadingMore = false;

  @override
  Future<Paginated<FeedPost>> build(FeedKind kind) {
    // Likes are personal, and Following needs an account: start over
    // whenever someone signs in or out.
    ref.watch(viewerIdProvider);
    return ref.watch(feedRepositoryProvider).feed(kind);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || _loadingMore) return;
    _loadingMore = true;
    try {
      final next = await ref
          .read(feedRepositoryProvider)
          .feed(kind, cursor: current.nextCursor);
      if (ref.mounted) state = AsyncData(current.append(next));
    } finally {
      _loadingMore = false;
    }
  }

  /// Reloads from the first page, keeping the old posts on screen meanwhile.
  Future<void> refresh() async {
    final fresh = await ref.read(feedRepositoryProvider).feed(kind);
    if (ref.mounted) state = AsyncData(fresh);
  }

  void _update(String postId, FeedPost Function(FeedPost) change) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.map((p) => p.id == postId ? change(p) : p),
    );
  }

  /// Flips the like at once, then settles the count with the server's.
  /// Rolls back and rethrows if the server refuses.
  Future<void> toggleLike(String postId) async {
    final before = state.value?.items.where((p) => p.id == postId).firstOrNull;
    if (before == null) return;

    _update(postId, (p) => p.toggledLike());
    final repo = ref.read(feedRepositoryProvider);
    try {
      final likes = before.likedByMe
          ? await repo.unlike(postId)
          : await repo.like(postId);
      if (ref.mounted) _update(postId, (p) => p.copyWith(likeCount: likes));
    } on Object {
      if (ref.mounted) _update(postId, (_) => before);
      rethrow;
    }
  }

  /// After a comment is posted from the sheet.
  void commentAdded(String postId) =>
      _update(postId, (p) => p.copyWith(commentCount: p.commentCount + 1));
}

/// A post's comments, with "load more" and adding one.
@riverpod
class PostComments extends _$PostComments {
  var _loadingMore = false;

  @override
  Future<Paginated<PostComment>> build(String postId) =>
      ref.watch(feedRepositoryProvider).comments(postId);

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || _loadingMore) return;
    _loadingMore = true;
    try {
      final next = await ref
          .read(feedRepositoryProvider)
          .comments(postId, cursor: current.nextCursor);
      if (ref.mounted) state = AsyncData(current.append(next));
    } finally {
      _loadingMore = false;
    }
  }

  /// Posts [body] and appends it. Throws (e.g. validation) without changes.
  Future<void> add(String body) async {
    final comment = await ref
        .read(feedRepositoryProvider)
        .addComment(postId, body);
    final current = state.value ?? const Paginated<PostComment>.empty();
    if (ref.mounted) {
      state = AsyncData(
        Paginated(
          items: [...current.items, comment],
          nextCursor: current.nextCursor,
        ),
      );
    }
  }
}
