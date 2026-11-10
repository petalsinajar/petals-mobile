// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The viewer's upcoming events (empty signed out). Kept alive: the
/// Discover controller reads it to find the next venue.

@ProviderFor(myUpcomingEvents)
final myUpcomingEventsProvider = MyUpcomingEventsProvider._();

/// The viewer's upcoming events (empty signed out). Kept alive: the
/// Discover controller reads it to find the next venue.

final class MyUpcomingEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingEvent>>,
          List<UpcomingEvent>,
          FutureOr<List<UpcomingEvent>>
        >
    with
        $FutureModifier<List<UpcomingEvent>>,
        $FutureProvider<List<UpcomingEvent>> {
  /// The viewer's upcoming events (empty signed out). Kept alive: the
  /// Discover controller reads it to find the next venue.
  MyUpcomingEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myUpcomingEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myUpcomingEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<UpcomingEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UpcomingEvent>> create(Ref ref) {
    return myUpcomingEvents(ref);
  }
}

String _$myUpcomingEventsHash() => r'49533eb12a794f85f67e1c6ce2d3098687071d30';

@ProviderFor(DiscoverController)
final discoverControllerProvider = DiscoverControllerProvider._();

final class DiscoverControllerProvider
    extends $NotifierProvider<DiscoverController, DiscoverFilter> {
  DiscoverControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverControllerHash();

  @$internal
  @override
  DiscoverController create() => DiscoverController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoverFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoverFilter>(value),
    );
  }
}

String _$discoverControllerHash() =>
    r'c3bc96d7b43fac5355e304f599536c05ae67b6f8';

abstract class _$DiscoverController extends $Notifier<DiscoverFilter> {
  DiscoverFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DiscoverFilter, DiscoverFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiscoverFilter, DiscoverFilter>,
              DiscoverFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// "For your event": the next event the viewer hosts (of the chosen type)
/// and what it still needs. Null when there's nothing to suggest.

@ProviderFor(forYourEvent)
final forYourEventProvider = ForYourEventProvider._();

/// "For your event": the next event the viewer hosts (of the chosen type)
/// and what it still needs. Null when there's nothing to suggest.

final class ForYourEventProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventPlanGap?>,
          EventPlanGap?,
          FutureOr<EventPlanGap?>
        >
    with $FutureModifier<EventPlanGap?>, $FutureProvider<EventPlanGap?> {
  /// "For your event": the next event the viewer hosts (of the chosen type)
  /// and what it still needs. Null when there's nothing to suggest.
  ForYourEventProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forYourEventProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forYourEventHash();

  @$internal
  @override
  $FutureProviderElement<EventPlanGap?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventPlanGap?> create(Ref ref) {
    return forYourEvent(ref);
  }
}

String _$forYourEventHash() => r'7a2c39788d1e4a7a9db578c3e50b7eae40ab298d';

@ProviderFor(trendingLooks)
final trendingLooksProvider = TrendingLooksProvider._();

final class TrendingLooksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LookPost>>,
          List<LookPost>,
          FutureOr<List<LookPost>>
        >
    with $FutureModifier<List<LookPost>>, $FutureProvider<List<LookPost>> {
  TrendingLooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendingLooksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendingLooksHash();

  @$internal
  @override
  $FutureProviderElement<List<LookPost>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LookPost>> create(Ref ref) {
    return trendingLooks(ref);
  }
}

String _$trendingLooksHash() => r'643ce4b295495aeac3978a37c34410c70ff65e9e';

@ProviderFor(discoverCategories)
final discoverCategoriesProvider = DiscoverCategoriesProvider._();

final class DiscoverCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CatalogCategory>>,
          List<CatalogCategory>,
          FutureOr<List<CatalogCategory>>
        >
    with
        $FutureModifier<List<CatalogCategory>>,
        $FutureProvider<List<CatalogCategory>> {
  DiscoverCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<CatalogCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CatalogCategory>> create(Ref ref) {
    return discoverCategories(ref);
  }
}

String _$discoverCategoriesHash() =>
    r'ec3d96cb8633d742106179175b0c281a7ba88ea6';

/// Vendors serving the place, with optimistic follow.

@ProviderFor(NearbyVendors)
final nearbyVendorsProvider = NearbyVendorsProvider._();

/// Vendors serving the place, with optimistic follow.
final class NearbyVendorsProvider
    extends $AsyncNotifierProvider<NearbyVendors, List<VendorCard>> {
  /// Vendors serving the place, with optimistic follow.
  NearbyVendorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyVendorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyVendorsHash();

  @$internal
  @override
  NearbyVendors create() => NearbyVendors();
}

String _$nearbyVendorsHash() => r'0261bafa96a35f015137242e43e8def7151261ee';

/// Vendors serving the place, with optimistic follow.

abstract class _$NearbyVendors extends $AsyncNotifier<List<VendorCard>> {
  FutureOr<List<VendorCard>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<VendorCard>>, List<VendorCard>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<VendorCard>>, List<VendorCard>>,
              AsyncValue<List<VendorCard>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(nearbyPackages)
final nearbyPackagesProvider = NearbyPackagesProvider._();

final class NearbyPackagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PackageCard>>,
          List<PackageCard>,
          FutureOr<List<PackageCard>>
        >
    with
        $FutureModifier<List<PackageCard>>,
        $FutureProvider<List<PackageCard>> {
  NearbyPackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyPackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyPackagesHash();

  @$internal
  @override
  $FutureProviderElement<List<PackageCard>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PackageCard>> create(Ref ref) {
    return nearbyPackages(ref);
  }
}

String _$nearbyPackagesHash() => r'7db57488b523e45cbbf6ee82a29e410c1dd930ba';

/// Popular items near the place (everywhere without one), with infinite
/// scroll.

@ProviderFor(PopularItems)
final popularItemsProvider = PopularItemsProvider._();

/// Popular items near the place (everywhere without one), with infinite
/// scroll.
final class PopularItemsProvider
    extends $AsyncNotifierProvider<PopularItems, Paginated<ItemCard>> {
  /// Popular items near the place (everywhere without one), with infinite
  /// scroll.
  PopularItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularItemsHash();

  @$internal
  @override
  PopularItems create() => PopularItems();
}

String _$popularItemsHash() => r'e9bcd2aa511c3e3f968ac8e91660694a79d27978';

/// Popular items near the place (everywhere without one), with infinite
/// scroll.

abstract class _$PopularItems extends $AsyncNotifier<Paginated<ItemCard>> {
  FutureOr<Paginated<ItemCard>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Paginated<ItemCard>>, Paginated<ItemCard>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Paginated<ItemCard>>, Paginated<ItemCard>>,
              AsyncValue<Paginated<ItemCard>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// True once every area-dependent section has loaded and come back empty,
/// so the page can say so once instead of showing nothing. Categories
/// don't count: they're the same everywhere.

@ProviderFor(discoverPageEmpty)
final discoverPageEmptyProvider = DiscoverPageEmptyProvider._();

/// True once every area-dependent section has loaded and come back empty,
/// so the page can say so once instead of showing nothing. Categories
/// don't count: they're the same everywhere.

final class DiscoverPageEmptyProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True once every area-dependent section has loaded and come back empty,
  /// so the page can say so once instead of showing nothing. Categories
  /// don't count: they're the same everywhere.
  DiscoverPageEmptyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverPageEmptyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverPageEmptyHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return discoverPageEmpty(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$discoverPageEmptyHash() => r'fb05a0ad663b005ff6b822142dba5303899c3bcc';
