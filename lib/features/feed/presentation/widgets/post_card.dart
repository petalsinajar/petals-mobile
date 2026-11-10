import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/time_ago.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/core/widgets/media_video.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// A post in a feed: who, where, the photos, the caption, likes and comments.
class PostCard extends StatelessWidget {
  const PostCard({
    required this.post,
    required this.onLike,
    required this.onComments,
    this.onOpenEvent,
    super.key,
  });

  final FeedPost post;
  final VoidCallback onLike;
  final VoidCallback onComments;

  /// Tapping "at (event)". Omit to show the event without a link.
  final VoidCallback? onOpenEvent;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppSpacing.screenPadding,
            child: _Header(post: post, onOpenEvent: onOpenEvent),
          ),
          if (post.media.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            GestureDetector(
              // Double-tap likes, never un-likes, as people expect.
              onDoubleTap: post.likedByMe ? null : onLike,
              child: _MediaCarousel(media: post.media),
            ),
          ],
          Padding(
            padding: AppSpacing.screenPadding,
            child: _Actions(
              post: post,
              onLike: onLike,
              onComments: onComments,
            ),
          ),
          if (post.caption.isNotEmpty)
            Padding(
              padding: AppSpacing.screenPadding,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${post.author.name}  ',
                      style: text.titleSmall,
                    ),
                    TextSpan(text: post.caption),
                  ],
                ),
                style: text.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.post, required this.onOpenEvent});

  final FeedPost post;
  final VoidCallback? onOpenEvent;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    final author = post.author;
    final event = post.event;
    return Row(
      children: [
        Avatar(
          name: author.name,
          imageUrl: author.avatarUrl,
          isVendor: author.isVendor,
          size: AvatarSize.sm,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      author.name,
                      style: text.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (author.isVerified) ...[
                    const SizedBox(width: AppSpacing.xxs),
                    Icon(
                      Icons.verified_rounded,
                      size: AppSizes.iconSm,
                      color: colors.primary,
                      semanticLabel: 'Verified',
                    ),
                  ],
                ],
              ),
              if (event != null)
                GestureDetector(
                  onTap: onOpenEvent,
                  child: Text(
                    'at ${event.title}',
                    style: text.bodySmall?.copyWith(
                      color: onOpenEvent == null
                          ? colors.onSurfaceVariant
                          : colors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
        Text(
          TimeAgo.format(post.createdAt),
          style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _MediaCarousel extends StatefulWidget {
  const _MediaCarousel({required this.media});

  final List<PostMedia> media;

  @override
  State<_MediaCarousel> createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<_MediaCarousel> {
  final _pages = PageController();

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.media;
    // The first photo sets the frame; later ones are cropped to fit.
    final ratio = media.first.aspectRatio;
    if (media.length == 1) {
      return AspectRatio(aspectRatio: ratio, child: _Slide(media.single));
    }
    return Column(
      children: [
        AspectRatio(
          aspectRatio: ratio,
          child: PageView(
            controller: _pages,
            children: [
              for (final m in media) _Slide(m),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SmoothPageIndicator(
          controller: _pages,
          count: media.length,
          effect: ScrollingDotsEffect(
            dotWidth: 6,
            dotHeight: 6,
            activeDotColor: context.colors.primary,
            dotColor: context.colors.outlineVariant,
          ),
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.post,
    required this.onLike,
    required this.onComments,
  });

  final FeedPost post;
  final VoidCallback onLike;
  final VoidCallback onComments;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final label = context.textTheme.labelLarge;
    return Row(
      children: [
        IconButton(
          tooltip: post.likedByMe ? 'Unlike' : 'Like',
          onPressed: onLike,
          icon: Icon(
            post.likedByMe
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            color: post.likedByMe ? colors.error : null,
          ),
        ),
        Text('${post.likeCount}', style: label),
        const SizedBox(width: AppSpacing.sm),
        IconButton(
          tooltip: 'Comments',
          onPressed: onComments,
          icon: const Icon(Icons.mode_comment_outlined),
        ),
        Text('${post.commentCount}', style: label),
      ],
    );
  }
}

/// One photo or video in a post. Videos autoplay muted in the feed.
class _Slide extends StatelessWidget {
  const _Slide(this.m);

  final PostMedia m;

  @override
  Widget build(BuildContext context) {
    final media = m.media;
    if (m.isVideo && media != null) {
      return MediaVideo(media: media, autoplay: true, aspectRatio: m.aspectRatio);
    }
    return MediaImage(url: m.url, media: media, blurhash: m.blurhash);
  }
}
