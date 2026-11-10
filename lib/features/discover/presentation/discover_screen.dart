import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/discover_header.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/discover_sections.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/for_your_event_section.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/place_picker.dart';

/// The Discover tab: get inspired (trending looks) and find vendors, items
/// and packages that serve the viewer's area. One scroll; every section
/// loads and fails on its own.
class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  /// Start fetching more items this close to the bottom.
  static const _loadMoreWithin = 600.0;

  Future<void> _refresh(WidgetRef ref) async {
    ref
      ..invalidate(myUpcomingEventsProvider)
      ..invalidate(forYourEventProvider)
      ..invalidate(trendingLooksProvider)
      ..invalidate(discoverCategoriesProvider)
      ..invalidate(nearbyVendorsProvider)
      ..invalidate(nearbyPackagesProvider)
      ..invalidate(popularItemsProvider);
    // Wait for the sections people look at first; the rest fill in.
    await Future.wait<void>([
      ref.read(trendingLooksProvider.future).then((_) {}, onError: (_) {}),
      ref.read(popularItemsProvider.future).then((_) {}, onError: (_) {}),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(
      discoverControllerProvider.select((f) => f.status),
    );
    final nothingHere = ref.watch(discoverPageEmptyProvider);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n.metrics.axis == Axis.vertical &&
              n.metrics.extentAfter < _loadMoreWithin) {
            unawaited(ref.read(popularItemsProvider.notifier).loadMore());
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () => _refresh(ref),
          edgeOffset: kToolbarHeight + AppSpacing.lg,
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: true,
                toolbarHeight: kToolbarHeight + AppSpacing.sm,
                titleSpacing: AppSpacing.screen,
                title: DiscoverSearchBar(),
              ),
              const SliverToBoxAdapter(child: DiscoverFilters()),
              if (status == PlaceStatus.needsChoice)
                const SliverToBoxAdapter(child: LocationPrompt()),
              if (nothingHere)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _NothingHere(),
                )
              else ...[
                const SliverToBoxAdapter(child: ForYourEventSection()),
                const SliverToBoxAdapter(child: TrendingLooksSection()),
                const SliverToBoxAdapter(child: CategoriesSection()),
                const SliverToBoxAdapter(child: VendorsNearSection()),
                const SliverToBoxAdapter(child: PackagesSection()),
                const PopularItemsSliver(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xxl),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NothingHere extends ConsumerWidget {
  const _NothingHere();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(discoverControllerProvider);
    final area = switch (filter.place) {
      final DiscoverPlace p => p.label == 'you' ? 'your area' : p.label,
      null => 'your area',
    };
    final hasType = filter.eventType != null;
    return EmptyState(
      title: 'Nothing near $area yet',
      message: hasType
          ? 'No vendors here for this kind of event yet. Try All, or '
                'another area.'
          : 'Vendors are still joining here. Try a nearby area — new '
                'ones arrive every week.',
      actionLabel: hasType ? 'Show all events' : 'Change area',
      onAction: hasType
          ? () =>
                ref.read(discoverControllerProvider.notifier).setEventType(null)
          : () => showPlacePicker(context),
    );
  }
}
