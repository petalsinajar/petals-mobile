import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/time_ago.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';

/// Posts shared to the event, newest first.
///
/// Uses a compact card of its own until the posts feature's `PostCard`
/// (likes, comments, shop-the-look) can be reused here.
class EventFeedSection extends ConsumerWidget {
  const EventFeedSection({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = eventFeedProvider(eventId);
    final feed = ref.watch(provider);
    return feed.when(
      loading: () => const AppSkeleton(
        child: Column(children: [SkeletonPostCard(), SkeletonPostCard()]),
      ),
      error: (e, _) =>
          InlineError(error: e, onRetry: () => ref.invalidate(provider)),
      data: (page) => page.isEmpty
          ? const _EmptyFeed()
          : Column(
              children: [
                for (final (i, post) in page.items.indexed)
                  _EventPostTile(post: post).entrance(i),
                if (page.hasMore)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                    child: AppButton(
                      label: 'Load more',
                      variant: AppButtonVariant.ghost,
                      onPressed: () => ref.read(provider.notifier).loadMore(),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    final muted = context.colors.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: AppSizes.iconLg,
            color: muted,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('No posts yet', style: context.textTheme.titleSmall),
          Text(
            'Photos from guests and vendors will appear here.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(color: muted),
          ),
        ],
      ),
    );
  }
}

class _EventPostTile extends StatelessWidget {
  const _EventPostTile({required this.post});

  final EventPost post;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final muted = context.colors.onSurfaceVariant;
    final photo = post.media.firstOrNull;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                name: post.author.name,
                imageUrl: post.author.avatar?.url,
                blurhash: post.author.avatar?.blurhash,
                isVendor: post.author.isVendor,
                size: AvatarSize.sm,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(post.author.name, style: text.titleSmall)),
              Text(
                TimeAgo.format(post.createdAt),
                style: text.bodySmall?.copyWith(color: muted),
              ),
            ],
          ),
          if (photo != null) ...[
            const SizedBox(height: AppSpacing.sm),
            MediaImage(
              url: photo.url,
              blurhash: photo.blurhash,
              aspectRatio: (photo.width ?? 4) / (photo.height ?? 5),
              borderRadius: AppRadii.cardAll,
            ),
          ],
          if (post.caption.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(post.caption, style: text.bodyMedium),
          ],
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.favorite_border_rounded,
                size: AppSizes.iconSm,
                color: muted,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text('${post.likeCount}', style: text.labelMedium),
              const SizedBox(width: AppSpacing.lg),
              Icon(
                Icons.mode_comment_outlined,
                size: AppSizes.iconSm,
                color: muted,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text('${post.commentCount}', style: text.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
