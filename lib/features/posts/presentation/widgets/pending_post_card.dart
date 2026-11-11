import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/media/upload_queue.dart';
import 'package:petalsinajar/features/posts/presentation/pending_posts.dart';
import 'package:petalsinajar/features/posts/presentation/widgets/draft_preview.dart';

/// The viewer's posts still uploading, newest first, for the top of the
/// feed. Empty when there are none.
class PendingPostsList extends ConsumerWidget {
  const PendingPostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(pendingPostsProvider);
    if (pending.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [for (final p in pending) PendingPostCard(post: p)],
    );
  }
}

/// "Uploading 2 photos…" with a progress ring and a cancel button; retry or
/// discard on failure.
class PendingPostCard extends ConsumerWidget {
  const PendingPostCard({required this.post, super.key});

  static const _thumb = 56.0;

  final PendingPost post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(uploadQueueProvider);
    final progress = pendingProgress(post, jobs);
    final notifier = ref.read(pendingPostsProvider.notifier);
    final failed = post.stage == PendingStage.failed;
    final offline = !(ref.watch(onlineProvider).value ?? true);
    final count = post.previews.length;
    final videos = post.previews.where((p) => p.isVideo).length;
    final what = switch ((count, videos)) {
      (1, 1) => 'video',
      (1, _) => 'photo',
      (_, 0) => '$count photos',
      _ => '$count files',
    };
    final status = switch (post.stage) {
      PendingStage.failed => post.error ?? 'Upload failed.',
      PendingStage.publishing => 'Posting…',
      PendingStage.uploading when offline =>
        'Waiting for a connection to upload your $what',
      PendingStage.uploading when progress >= 0.9 =>
        'Getting your $what ready…',
      PendingStage.uploading => 'Uploading your $what…',
    };
    final text = context.textTheme;

    return Semantics(
      container: true,
      label: failed ? 'Post failed: $status' : 'Post uploading, $status',
      child: Card(
        margin: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.sm,
          AppSpacing.screen,
          AppSpacing.sm,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              SizedBox.square(
                dimension: _thumb,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: AppRadii.smAll,
                      child: Opacity(
                        opacity: 0.6,
                        child: DraftPreview(photo: post.previews.first),
                      ),
                    ),
                    Center(
                      child: failed
                          ? Icon(
                              Icons.error_outline_rounded,
                              color: context.colors.error,
                            )
                          : SizedBox.square(
                              dimension: AppSizes.iconLg,
                              child: CircularProgressIndicator(
                                key: const Key('pending-progress'),
                                value: post.stage == PendingStage.publishing
                                    ? null
                                    : progress.clamp(0.02, 1.0),
                                strokeWidth: 3,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption.isEmpty ? 'Your post' : post.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleSmall,
                    ),
                    Text(
                      status,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall?.copyWith(
                        color: failed
                            ? context.colors.error
                            : context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (failed) ...[
                IconButton(
                  tooltip: 'Try again',
                  onPressed: () => notifier.retry(post.id),
                  icon: const Icon(Icons.refresh_rounded),
                ),
                IconButton(
                  tooltip: 'Discard post',
                  onPressed: () => notifier.discard(post.id),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ] else
                IconButton(
                  tooltip: 'Cancel post',
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Cancel this post?'),
                        content: const Text(
                          'It stops uploading and won’t be shared.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Keep uploading'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Cancel post'),
                          ),
                        ],
                      ),
                    );
                    if (ok ?? false) await notifier.discard(post.id);
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
