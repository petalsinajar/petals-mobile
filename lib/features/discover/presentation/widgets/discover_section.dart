import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// "Vendors near you" with an optional action on the right.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.subtitle,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(title, style: context.textTheme.titleLarge),
                ),
                if (subtitle case final String s)
                  Text(
                    s,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// One Discover section. Skeleton on first load, an inline retry when it
/// fails, and nothing at all when it has nothing to show — so sections load
/// and fail on their own without taking the page down.
class DiscoverSection<T> extends StatelessWidget {
  const DiscoverSection({
    required this.value,
    required this.title,
    required this.isEmpty,
    required this.builder,
    required this.skeleton,
    required this.onRetry,
    this.subtitle,
    this.trailing,
    super.key,
  });

  final AsyncValue<T> value;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool Function(T data) isEmpty;
  final Widget Function(T data) builder;
  final Widget skeleton;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final header = SectionHeader(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
    return value.when(
      data: (data) => isEmpty(data)
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [header, builder(data)],
            ),
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          AppSkeleton(child: skeleton),
        ],
      ),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          Padding(
            padding: AppSpacing.screenPadding,
            child: InlineError(error: error, onRetry: onRetry),
          ),
        ],
      ),
    );
  }
}

/// A horizontal strip of cards [height] tall.
class HorizontalStrip extends StatelessWidget {
  const HorizontalStrip({
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    super.key,
  });

  final double height;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.screenPadding,
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
        itemBuilder: itemBuilder,
      ),
    );
  }
}

/// [count] skeleton cards [width] × [height] in a strip.
class SkeletonStrip extends StatelessWidget {
  const SkeletonStrip({
    required this.width,
    required this.height,
    this.count = 4,
    super.key,
  });

  final double width;
  final double height;
  final int count;

  @override
  Widget build(BuildContext context) {
    return HorizontalStrip(
      height: height,
      itemCount: count,
      itemBuilder: (_, _) => SizedBox(
        width: width,
        child: const Bone(borderRadius: AppRadii.cardAll),
      ),
    );
  }
}
