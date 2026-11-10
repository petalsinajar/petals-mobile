import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/detail_args.dart';
import 'package:petalsinajar/features/discover/presentation/detail_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';

/// A Discover post with shop-the-look: tap the photo to show its pins, tap
/// a pin for the item and "Rent this".
class LookScreen extends ConsumerStatefulWidget {
  const LookScreen({required this.postId, this.args, super.key});

  final String postId;
  final DetailArgs<LookPost>? args;

  @override
  ConsumerState<LookScreen> createState() => _LookScreenState();
}

class _LookScreenState extends ConsumerState<LookScreen> {
  var _showPins = true;

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(lookDetailProvider(widget.postId));
    final look = value.value ?? widget.args?.initial;

    return Scaffold(
      appBar: AppBar(),
      body: look == null
          ? value.hasError
                ? ErrorState(
                    error: value.error!,
                    onRetry: () =>
                        ref.invalidate(lookDetailProvider(widget.postId)),
                  )
                : const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                for (final (i, media) in look.media.indexed)
                  if (!media.isVideo)
                    _PinnedPhoto(
                      media: media,
                      heroTag: i == 0 ? widget.args?.heroTag : null,
                      showPins: _showPins,
                      onToggle: () => setState(() => _showPins = !_showPins),
                    ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.screen),
                  child: _Caption(look: look),
                ),
              ],
            ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.look});

  final LookPost look;

  @override
  Widget build(BuildContext context) {
    final type = look.eventType;
    final tagged = look.media.any((m) => m.tags.isNotEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Avatar(
              name: look.authorName,
              imageUrl: look.authorAvatarUrl,
              isVendor: look.authorIsVendor,
              size: AvatarSize.sm,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(look.authorName, style: context.textTheme.titleSmall),
            ),
            if (type != null)
              Chip(
                label: Text(eventTypeLabel(type)),
                backgroundColor: context.palette.accentFor(type).container,
              ),
          ],
        ),
        if (look.caption.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(look.caption, style: context.textTheme.bodyLarge),
        ],
        if (tagged) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap the photo to show or hide what’s tagged.',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

/// A photo with its tag pins laid over it.
class _PinnedPhoto extends StatelessWidget {
  const _PinnedPhoto({
    required this.media,
    required this.heroTag,
    required this.showPins,
    required this.onToggle,
  });

  final LookMedia media;
  final String? heroTag;
  final bool showPins;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final photo = media.photo;
    final ratio = switch ((photo.width, photo.height)) {
      (final int w, final int h) when w > 0 && h > 0 => (w / h).clamp(
        4 / 5,
        1.91,
      ),
      _ => 4 / 5,
    };
    Widget image = MediaImage(
      url: photo.url,
      media: photo.media,
      blurhash: photo.blurhash,
    );
    if (heroTag case final String tag) image = Hero(tag: tag, child: image);

    // Only pins we can open: items, and vendors.
    final pins = media.tags
        .where((t) => t.targetType == 'vendor' || t.item != null)
        .toList();

    return AspectRatio(
      aspectRatio: ratio,
      child: LayoutBuilder(
        builder: (context, box) => Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: pins.isEmpty ? null : onToggle,
              child: image,
            ),
            for (final pin in pins)
              Positioned(
                left: (pin.x * box.maxWidth - AppSizes.minTouchTarget / 2)
                    .clamp(0, box.maxWidth - AppSizes.minTouchTarget),
                top: (pin.y * box.maxHeight - AppSizes.minTouchTarget / 2)
                    .clamp(0, box.maxHeight - AppSizes.minTouchTarget),
                child: AnimatedScale(
                  scale: showPins ? 1 : 0,
                  duration: AppMotion.medium,
                  curve: AppMotion.spring,
                  child: _Pin(tag: pin, visible: showPins),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Pin extends StatelessWidget {
  const _Pin({required this.tag, required this.visible});

  final LookTag tag;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final label = tag.item?.title ?? 'Tagged vendor';
    return Semantics(
      button: true,
      label: 'Shop $label',
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: AppSizes.minTouchTarget,
        child: IconButton(
          onPressed: visible ? () => _open(context) : null,
          style: IconButton.styleFrom(
            backgroundColor: context.colors.surface.withValues(alpha: 0.9),
          ),
          icon: Icon(
            tag.targetType == 'vendor'
                ? Icons.storefront_rounded
                : Icons.sell_rounded,
            size: AppSizes.iconSm,
            color: context.colors.primary,
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context) {
    unawaited(Haptics.light());
    final item = tag.item;
    if (item == null) {
      context.openVendor(tag.targetId);
      return;
    }
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (sheet) => _TaggedItemSheet(
          item: item,
          onRent: () {
            Navigator.of(sheet).pop();
            context.openItem(item);
          },
        ),
      ),
    );
  }
}

/// The tapped pin's item, with "Rent this".
class _TaggedItemSheet extends StatelessWidget {
  const _TaggedItemSheet({required this.item, required this.onRent});

  final ItemCard item;
  final VoidCallback onRent;

  @override
  Widget build(BuildContext context) {
    final photo = item.photo;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          0,
          AppSpacing.screen,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: 72,
                  child: photo == null
                      ? ColoredBox(
                          color: context.colors.surfaceContainerHighest,
                          child: const Icon(Icons.chair_rounded),
                        )
                      : MediaImage(
                          url: photo.url,
                          blurhash: photo.blurhash,
                          borderRadius: AppRadii.mdAll,
                        ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: context.textTheme.titleMedium),
                      Text(
                        fromPrice(item),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Rent this',
              icon: Icons.shopping_bag_rounded,
              expand: true,
              onPressed: onRent,
            ),
          ],
        ),
      ),
    );
  }
}
