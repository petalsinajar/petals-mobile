import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:petalsinajar/features/discover/presentation/detail_args.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/add_to_event.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/catalog_cards.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/discover_section.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/vendor_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrendingLooksSection extends ConsumerWidget {
  const TrendingLooksSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DiscoverSection(
      value: ref.watch(trendingLooksProvider),
      title: 'Trending looks',
      subtitle: 'Tap a look to shop what you see',
      isEmpty: (looks) => looks.isEmpty,
      onRetry: () => ref.invalidate(trendingLooksProvider),
      skeleton: const SkeletonStrip(
        width: LookCard.width,
        height: LookCard.height,
      ),
      builder: (looks) => HorizontalStrip(
        height: LookCard.height,
        itemCount: looks.length,
        itemBuilder: (context, i) {
          final look = looks[i];
          final tag = 'trending-look-${look.id}';
          return LookCard(
            look: look,
            heroTag: tag,
            onTap: () => context.openLook(look, heroTag: tag),
          ).entrance(i);
        },
      ),
    );
  }
}

class CategoriesSection extends ConsumerWidget {
  const CategoriesSection({super.key});

  static const _tileExtent = 96.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grid = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: _tileExtent,
      mainAxisExtent: MediaQuery.textScalerOf(context).scale(_tileExtent),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
    );
    return DiscoverSection(
      value: ref.watch(discoverCategoriesProvider),
      title: 'Categories',
      isEmpty: (categories) => categories.isEmpty,
      onRetry: () => ref.invalidate(discoverCategoriesProvider),
      skeleton: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: AppSpacing.screenPadding,
        gridDelegate: grid,
        itemCount: 8,
        itemBuilder: (_, _) => const Bone(borderRadius: AppRadii.cardAll),
      ),
      builder: (categories) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: AppSpacing.screenPadding,
        gridDelegate: grid,
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final category = categories[i];
          return CategoryTile(
            category: category,
            onTap: () => context.push(
              Routes.searchCategory(category.id, category.name),
            ),
          ).entrance(i);
        },
      ),
    );
  }
}

class VendorsNearSection extends ConsumerWidget {
  const VendorsNearSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(discoverControllerProvider).place;

    Future<void> follow(String vendorId) async {
      if (ref.read(viewerIdProvider) == null) {
        unawaited(context.push(Routes.signInFrom(Routes.discover)));
        return;
      }
      unawaited(Haptics.light());
      final messenger = ScaffoldMessenger.of(context);
      try {
        await ref.read(nearbyVendorsProvider.notifier).toggleFollow(vendorId);
      } on Object {
        messenger.showSnackBar(
          const SnackBar(content: Text("Couldn't update follow. Try again.")),
        );
      }
    }

    return DiscoverSection(
      value: ref.watch(nearbyVendorsProvider),
      title: 'Vendors near you',
      subtitle: place == null ? null : 'Delivering to ${place.label}',
      isEmpty: (vendors) => vendors.isEmpty,
      onRetry: () => ref.invalidate(nearbyVendorsProvider),
      skeleton: const SkeletonStrip(
        width: VendorCardView.width,
        height: VendorCardView.height,
      ),
      builder: (vendors) => HorizontalStrip(
        height: VendorCardView.height,
        itemCount: vendors.length,
        itemBuilder: (context, i) {
          final vendor = vendors[i];
          final tag = 'near-vendor-${vendor.id}';
          return VendorCardView(
            vendor: vendor,
            heroTag: tag,
            onTap: () =>
                context.openVendor(vendor.id, initial: vendor, heroTag: tag),
            onFollow: () => follow(vendor.id),
          ).entrance(i);
        },
      ),
    );
  }
}

class PackagesSection extends ConsumerWidget {
  const PackagesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DiscoverSection(
      value: ref.watch(nearbyPackagesProvider),
      title: 'Packages',
      subtitle: 'Everything for one price',
      isEmpty: (packages) => packages.isEmpty,
      onRetry: () => ref.invalidate(nearbyPackagesProvider),
      skeleton: const SkeletonStrip(
        width: PackageCardView.width,
        height: PackageCardView.height,
      ),
      builder: (packages) => HorizontalStrip(
        height: PackageCardView.height,
        itemCount: packages.length,
        itemBuilder: (context, i) {
          final package = packages[i];
          final vendor = package.vendor;
          return PackageCardView(
            package: package,
            onTap: vendor == null ? () {} : () => context.openVendor(vendor.id),
            onAdd: () => addPackageToEvent(context, ref, package),
          ).entrance(i);
        },
      ),
    );
  }
}

/// "Popular items": a 2-column grid that loads more as it scrolls. Lives
/// in the page's sliver list, so it's a sliver itself.
class PopularItemsSliver extends ConsumerWidget {
  const PopularItemsSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(popularItemsProvider);
    final header = SliverToBoxAdapter(
      child: SectionHeader(
        title: 'Popular items',
        subtitle: switch (ref.watch(discoverControllerProvider).eventType) {
          final type? => 'For ${eventTypePlural(type).toLowerCase()}',
          null => null,
        },
      ),
    );

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final tileWidth =
            (constraints.crossAxisExtent -
                AppSpacing.screen * 2 -
                AppSpacing.md) /
            2;
        final grid = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.lg,
          crossAxisSpacing: AppSpacing.md,
          mainAxisExtent:
              tileWidth +
              MediaQuery.textScalerOf(context).scale(ItemTile.captionHeight),
        );

        Widget body;
        // Pull-to-refresh keeps the grid; a new filter shows skeletons.
        if (value.hasValue && !value.isReloading) {
          final page = value.requireValue;
          if (page.isEmpty) return const SliverToBoxAdapter();
          body = SliverGrid.builder(
            gridDelegate: grid,
            itemCount: page.items.length,
            itemBuilder: (context, i) {
              final item = page.items[i];
              final tag = 'popular-item-${item.id}';
              return ItemTile(
                item: item,
                heroTag: tag,
                onTap: () => context.openItem(item, heroTag: tag),
              ).entrance(i % 6);
            },
          );
        } else if (value.hasError && !value.isLoading) {
          body = SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: InlineError(
                error: value.error!,
                onRetry: () => ref.invalidate(popularItemsProvider),
              ),
            ),
          );
        } else {
          body = SliverGrid.builder(
            gridDelegate: grid,
            itemCount: 4,
            itemBuilder: (_, _) => const AppSkeleton(
              child: Bone(borderRadius: AppRadii.cardAll),
            ),
          );
        }

        return SliverMainAxisGroup(
          slivers: [
            header,
            SliverPadding(padding: AppSpacing.screenPadding, sliver: body),
            if (value.value?.hasMore ?? false)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        );
      },
    );
  }
}
