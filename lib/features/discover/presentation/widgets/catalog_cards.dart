import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_colors.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/core/widgets/press_scale.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';

/// A rounded, tappable card with a screen-reader label.
class _TapCard extends StatelessWidget {
  const _TapCard({
    required this.label,
    required this.onTap,
    required this.child,
  });

  final String label;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: PressScale(
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
          child: InkWell(onTap: onTap, child: child),
        ),
      ),
    );
  }
}

/// A photo, or a tinted box with an icon when there's none.
class _Photo extends StatelessWidget {
  const _Photo({required this.photo, required this.fallback});

  final Photo? photo;
  final IconData fallback;

  @override
  Widget build(BuildContext context) => switch (photo) {
    final Photo p => MediaImage(
      url: p.url,
      media: p.media,
      blurhash: p.blurhash,
    ),
    null => ColoredBox(
      color: context.colors.surfaceContainerHighest,
      child: Icon(fallback, color: context.colors.onSurfaceVariant),
    ),
  };
}

/// A small pill on top of a photo, e.g. the event type.
class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.background, this.color});

  final String label;
  final Color background;
  final Color? color;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(AppRadii.pill),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(color: color),
      ),
    ),
  );
}

/// A trending look: cover photo, event type and how many vendors are tagged.
class LookCard extends StatelessWidget {
  const LookCard({
    required this.look,
    required this.heroTag,
    required this.onTap,
    super.key,
  });

  static const width = 168.0;
  static const height = 228.0;

  final LookPost look;
  final String heroTag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final type = look.eventType;
    final accent = type == null ? null : context.palette.accentFor(type);
    final vendors = look.vendorCount;
    final vendorText = vendors == 1 ? '1 vendor' : '$vendors vendors';
    final scrim = context.colors.scrim;
    return SizedBox(
      width: width,
      child: _TapCard(
        label: [
          if (type != null) '${eventTypeLabel(type)} look',
          'by ${look.authorName}',
          if (vendors > 0) '$vendorText tagged',
        ].join(', '),
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: heroTag,
              child: _Photo(
                photo: look.cover,
                fallback: Icons.photo_rounded,
              ),
            ),
            // Keeps the labels readable over any photo.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    scrim.withValues(alpha: 0),
                    scrim.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
            if (accent != null && type != null)
              Positioned(
                top: AppSpacing.sm,
                left: AppSpacing.sm,
                child: _Pill(
                  label: eventTypeLabel(type),
                  background: accent.color,
                  color: accent.onColor,
                ),
              ),
            Positioned(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    look.authorName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  if (vendors > 0)
                    Row(
                      children: [
                        const Icon(
                          Icons.sell_rounded,
                          size: AppSizes.iconSm,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '$vendorText tagged',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// An icon tile for a category.
class CategoryTile extends StatelessWidget {
  const CategoryTile({required this.category, required this.onTap, super.key});

  final CatalogCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _TapCard(
      label: 'Browse ${category.name}',
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              categoryIcon(category.icon),
              size: AppSizes.iconLg,
              color: context.colors.primary,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// "Kids' party for 30": fixed price, guest range and an Add button.
class PackageCardView extends StatelessWidget {
  const PackageCardView({
    required this.package,
    required this.onTap,
    required this.onAdd,
    super.key,
  });

  static const width = 260.0;
  static const height = 250.0;

  final PackageCard package;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final price = MoneyFormat.format(package.priceMinor, package.currency);
    final guests = guestRange(package);
    final vendor = package.vendor?.name;
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Positioned.fill(
            child: _TapCard(
              label: [
                package.title,
                price,
                ?guests,
                if (vendor != null) 'by $vendor',
              ].join(', '),
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _Photo(
                      photo: package.photo,
                      fallback: Icons.inventory_2_rounded,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      // Room for the Add button.
                      AppSizes.minTouchTarget + AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleSmall,
                        ),
                        Text(
                          [?guests, ?vendor].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          price,
                          style: text.titleMedium?.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: IconButton.filled(
              tooltip: 'Add ${package.title} to an event',
              onPressed: onAdd,
              icon: const Icon(Icons.add_shopping_cart_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

/// A popular item in the 2-column grid: photo, title, price, vendor.
class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.item,
    required this.heroTag,
    required this.onTap,
    super.key,
  });

  /// Height of the text under the square photo, before text scaling.
  static const captionHeight = 76.0;

  final ItemCard item;
  final String heroTag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final vendor = item.vendor?.name;
    return _TapCard(
      label: [
        item.title,
        fromPrice(item),
        if (vendor != null) 'by $vendor',
      ].join(', '),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: heroTag,
              child: _Photo(photo: item.photo, fallback: Icons.chair_rounded),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleSmall,
                  ),
                  Text(
                    fromPrice(item),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodyMedium?.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                  if (vendor != null)
                    Text(
                      vendor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
