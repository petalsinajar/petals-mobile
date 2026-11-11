import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:petalsinajar/features/feed/domain/feed_repository.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';
import 'package:petalsinajar/features/feed/presentation/feed_controllers.dart';
import 'package:petalsinajar/features/feed/presentation/widgets/comments_sheet.dart';
import 'package:petalsinajar/features/feed/presentation/widgets/post_card.dart';
import 'package:petalsinajar/features/posts/presentation/widgets/pending_post_card.dart';

/// The home tab: "For you" (public, works signed out) and "Following".
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Petalsinajar'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'For you'),
              Tab(text: 'Following'),
            ],
          ),
        ),
        body: const Column(
          children: [
            // Posts still uploading, whatever the feed below is doing.
            PendingPostsList(),
            Expanded(
              child: TabBarView(
                children: [
                  _FeedTab(kind: FeedKind.forYou),
                  _FeedTab(kind: FeedKind.following),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedTab extends ConsumerWidget {
  const _FeedTab({required this.kind});

  final FeedKind kind;

  /// Start fetching the next page this many posts before the end.
  static const _prefetch = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedIn = ref.watch(viewerIdProvider) != null;
    void signIn() => context.push(Routes.signInFrom(Routes.feed));

    if (kind == FeedKind.following && !signedIn) {
      return EmptyState(
        title: 'See who you follow',
        message:
            'Sign in to get posts from the hosts, guests and vendors you '
            'follow, and from your events.',
        icon: Icons.people_alt_rounded,
        actionLabel: 'Sign in',
        onAction: signIn,
      );
    }

    final provider = feedPostsProvider(kind);
    final notifier = ref.read(provider.notifier);

    Future<void> like(FeedPost post) async {
      if (!signedIn) return signIn();
      unawaited(Haptics.light());
      try {
        await notifier.toggleLike(post.id);
      } on Object catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ErrorState.describe(e).$2)),
        );
      }
    }

    void openComments(FeedPost post) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => CommentsSheet(
        postId: post.id,
        canComment: signedIn,
        onAdded: () => notifier.commentAdded(post.id),
        onSignIn: () {
          Navigator.of(context).pop();
          signIn();
        },
      ),
    );

    Future<void> delete(FeedPost post) async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete this post?'),
          content: const Text(
            'It’s removed for everyone, with its photos and videos. This '
            'can’t be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Keep'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
      if (!(ok ?? false) || !context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      try {
        await notifier.delete(post.id);
        messenger.showSnackBar(const SnackBar(content: Text('Post deleted')));
      } on Object catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text(ErrorState.describe(e).$2)),
        );
      }
    }

    // Events need an account to open; send signed-out people to sign in
    // and on to the event.
    void openEvent(PostEventRef event) => signedIn
        ? context.push(Routes.event(event.id))
        : context.push(Routes.signInFrom(Routes.event(event.id)));

    return AsyncValueView(
      value: ref.watch(provider),
      onRetry: () => ref.invalidate(provider),
      // A list, not a Column: two cards are taller than most screens.
      loading: AppSkeleton(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [SkeletonPostCard(), SkeletonPostCard()],
        ),
      ),
      isEmpty: (page) => page.isEmpty,
      empty: EmptyState(
        title: kind == FeedKind.forYou
            ? 'Nothing here yet'
            : 'Your feed is quiet',
        message: kind == FeedKind.forYou
            ? 'Be the first to share photos from an event.'
            : 'Join events and follow vendors to fill it up.',
        icon: Icons.photo_library_outlined,
      ),
      data: (page) => RefreshIndicator(
        onRefresh: notifier.refresh,
        child: ListView.builder(
          // Always scrollable, so pull-to-refresh works on a short list.
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: page.items.length + (page.hasMore ? 1 : 0),
          itemBuilder: (context, i) {
            if (i >= page.items.length - _prefetch && page.hasMore) {
              // Fire-and-forget; the controller ignores repeats.
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => notifier.loadMore(),
              );
            }
            if (i == page.items.length) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final post = page.items[i];
            return PostCard(
              key: ValueKey(post.id),
              post: post,
              onLike: () => like(post),
              onComments: () => openComments(post),
              onOpenEvent: post.event == null
                  ? null
                  : () => openEvent(post.event!),
              onDelete: post.canDelete ? () => delete(post) : null,
            );
          },
        ),
      ),
    );
  }
}
