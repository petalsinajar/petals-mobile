import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Shimmering skeleton in the app's warm tones.
///
/// Two ways to use it:
/// * wrap a real widget built from placeholder data — Skeletonizer turns its
///   texts, images and icons into bones;
/// * compose `Bone`s, as the presets below do.
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({required this.child, this.enabled = true, super.key});

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Skeletonizer(
      enabled: enabled,
      effect: context.reduceMotion
          ? SolidColorEffect(color: palette.skeletonBase)
          : ShimmerEffect(
              baseColor: palette.skeletonBase,
              highlightColor: palette.skeletonHighlight,
              duration: AppMotion.shimmer,
            ),
      child: child,
    );
  }
}

/// Avatar + two lines.
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.screen,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Bone.circle(size: AppSizes.avatarMd),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(words: 3),
                SizedBox(height: AppSpacing.xs),
                Bone.text(words: 6, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Header, 4:5 photo and caption — the shape of a feed post.
class SkeletonPostCard extends StatelessWidget {
  const SkeletonPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonListTile(),
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Bone(borderRadius: AppRadii.cardAll),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.md,
              AppSpacing.screen,
              0,
            ),
            child: Bone.multiText(),
          ),
        ],
      ),
    );
  }
}

/// A non-scrolling list of skeleton rows, for loading states.
class SkeletonList extends StatelessWidget {
  const SkeletonList({
    this.itemCount = 6,
    this.item = const SkeletonListTile(),
    super.key,
  });

  final int itemCount;
  final Widget item;

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: ListView.builder(
        // Never scrolls, so it can also sit inside another scroll view.
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, _) => item,
      ),
    );
  }
}
