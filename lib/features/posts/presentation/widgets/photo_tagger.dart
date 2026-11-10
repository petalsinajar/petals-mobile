import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/presentation/widgets/tag_search_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// The picked photos, swipeable. Tap a spot to tag what's there; tap a
/// tag to remove it.
class PhotoTagger extends StatefulWidget {
  const PhotoTagger({
    required this.photos,
    required this.tags,
    required this.onTag,
    required this.onUntag,
    this.enabled = true,
    super.key,
  });

  final List<DraftPhoto> photos;
  final List<DraftTag> tags;
  final ValueChanged<DraftTag> onTag;
  final ValueChanged<DraftTag> onUntag;
  final bool enabled;

  @override
  State<PhotoTagger> createState() => _PhotoTaggerState();
}

class _PhotoTaggerState extends State<PhotoTagger> {
  final _pages = PageController();

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  Future<void> _tagAt(int index, Offset local, Size size) async {
    if (!widget.enabled) return;
    unawaited(Haptics.light());
    final target = await showTagSearch(context);
    if (target == null) return;
    widget.onTag(
      DraftTag(
        mediaIndex: index,
        x: (local.dx / size.width).clamp(0, 1),
        y: (local.dy / size.height).clamp(0, 1),
        target: target,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.photos.length;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 4 / 5,
          child: PageView.builder(
            controller: _pages,
            itemCount: count,
            itemBuilder: (context, i) => LayoutBuilder(
              builder: (context, box) {
                final size = box.biggest;
                return GestureDetector(
                  onTapUp: (d) => _tagAt(i, d.localPosition, size),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Semantics(
                        image: true,
                        label: 'Photo ${i + 1} of $count. Tap to tag a rental.',
                        child: Image.file(
                          File(widget.photos[i].path),
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => ColoredBox(
                            color: context.colors.surfaceContainerHighest,
                          ),
                        ),
                      ),
                      for (final tag in widget.tags)
                        if (tag.mediaIndex == i)
                          _PinChip(
                            tag: tag,
                            size: size,
                            onRemove: widget.enabled
                                ? () => widget.onUntag(tag)
                                : null,
                          ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        if (count > 1)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: SmoothPageIndicator(
              controller: _pages,
              count: count,
              effect: WormEffect(
                dotWidth: 6,
                dotHeight: 6,
                activeDotColor: context.colors.primary,
                dotColor: context.colors.outlineVariant,
              ),
            ),
          ),
      ],
    );
  }
}

/// A tag's label, centred on its spot (kept inside the photo).
class _PinChip extends StatelessWidget {
  const _PinChip({
    required this.tag,
    required this.size,
    required this.onRemove,
  });

  static const _maxWidth = 160.0;
  static const _height = 32.0;

  final DraftTag tag;
  final Size size;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final left = (tag.x * size.width - _maxWidth / 2).clamp(
      0.0,
      (size.width - _maxWidth).clamp(0.0, double.infinity),
    );
    final top = (tag.y * size.height - _height / 2).clamp(
      0.0,
      size.height - _height,
    );
    return Positioned(
      left: left,
      top: top,
      width: _maxWidth,
      child: Center(
        child: Semantics(
          button: true,
          label: 'Tagged ${tag.target.label}. Tap to remove.',
          excludeSemantics: true,
          child: GestureDetector(
            onTap: onRemove,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.inverseSurface.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tag.target.type == TagTargetType.vendor
                          ? Icons.storefront_rounded
                          : Icons.sell_rounded,
                      size: AppSizes.iconSm,
                      color: context.colors.onInverseSurface,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Flexible(
                      child: Text(
                        tag.target.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.onInverseSurface,
                        ),
                      ),
                    ),
                    if (onRemove != null) ...[
                      const SizedBox(width: AppSpacing.xxs),
                      Icon(
                        Icons.close_rounded,
                        size: 14,
                        color: context.colors.onInverseSurface,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ).animate(),
      ),
    );
  }
}

extension on Widget {
  /// A quick pop-in for new tags.
  Widget animate() => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.6, end: 1),
    duration: AppMotion.medium,
    curve: AppMotion.spring,
    builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
    child: this,
  );
}
