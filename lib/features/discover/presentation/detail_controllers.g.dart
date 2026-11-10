// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemDetail)
final itemDetailProvider = ItemDetailFamily._();

final class ItemDetailProvider
    extends
        $FunctionalProvider<AsyncValue<ItemCard>, ItemCard, FutureOr<ItemCard>>
    with $FutureModifier<ItemCard>, $FutureProvider<ItemCard> {
  ItemDetailProvider._({
    required ItemDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'itemDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$itemDetailHash();

  @override
  String toString() {
    return r'itemDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ItemCard> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ItemCard> create(Ref ref) {
    final argument = this.argument as String;
    return itemDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$itemDetailHash() => r'34912c80617977624eabc909bf3d0df975e1face';

final class ItemDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ItemCard>, String> {
  ItemDetailFamily._()
    : super(
        retry: null,
        name: r'itemDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ItemDetailProvider call(String itemId) =>
      ItemDetailProvider._(argument: itemId, from: this);

  @override
  String toString() => r'itemDetailProvider';
}

@ProviderFor(lookDetail)
final lookDetailProvider = LookDetailFamily._();

final class LookDetailProvider
    extends
        $FunctionalProvider<AsyncValue<LookPost>, LookPost, FutureOr<LookPost>>
    with $FutureModifier<LookPost>, $FutureProvider<LookPost> {
  LookDetailProvider._({
    required LookDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'lookDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lookDetailHash();

  @override
  String toString() {
    return r'lookDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LookPost> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LookPost> create(Ref ref) {
    final argument = this.argument as String;
    return lookDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LookDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lookDetailHash() => r'09863bf9107bbcb2236df49a543d6379bff7b1d5';

final class LookDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LookPost>, String> {
  LookDetailFamily._()
    : super(
        retry: null,
        name: r'lookDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LookDetailProvider call(String postId) =>
      LookDetailProvider._(argument: postId, from: this);

  @override
  String toString() => r'lookDetailProvider';
}

@ProviderFor(vendorPackages)
final vendorPackagesProvider = VendorPackagesFamily._();

final class VendorPackagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PackageCard>>,
          List<PackageCard>,
          FutureOr<List<PackageCard>>
        >
    with
        $FutureModifier<List<PackageCard>>,
        $FutureProvider<List<PackageCard>> {
  VendorPackagesProvider._({
    required VendorPackagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorPackagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorPackagesHash();

  @override
  String toString() {
    return r'vendorPackagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PackageCard>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PackageCard>> create(Ref ref) {
    final argument = this.argument as String;
    return vendorPackages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VendorPackagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorPackagesHash() => r'4b3cb1196fc9c2cb54ee0f213ea6f4f483d3483e';

final class VendorPackagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<PackageCard>>, String> {
  VendorPackagesFamily._()
    : super(
        retry: null,
        name: r'vendorPackagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorPackagesProvider call(String vendorId) =>
      VendorPackagesProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'vendorPackagesProvider';
}

@ProviderFor(vendorItems)
final vendorItemsProvider = VendorItemsFamily._();

final class VendorItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Paginated<ItemCard>>,
          Paginated<ItemCard>,
          FutureOr<Paginated<ItemCard>>
        >
    with
        $FutureModifier<Paginated<ItemCard>>,
        $FutureProvider<Paginated<ItemCard>> {
  VendorItemsProvider._({
    required VendorItemsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorItemsHash();

  @override
  String toString() {
    return r'vendorItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Paginated<ItemCard>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Paginated<ItemCard>> create(Ref ref) {
    final argument = this.argument as String;
    return vendorItems(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VendorItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorItemsHash() => r'92d52d43d68c992d7e5a9976abd6dd803946406b';

final class VendorItemsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Paginated<ItemCard>>, String> {
  VendorItemsFamily._()
    : super(
        retry: null,
        name: r'vendorItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorItemsProvider call(String vendorId) =>
      VendorItemsProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'vendorItemsProvider';
}

/// A vendor's profile, with optimistic follow.

@ProviderFor(VendorDetail)
final vendorDetailProvider = VendorDetailFamily._();

/// A vendor's profile, with optimistic follow.
final class VendorDetailProvider
    extends $AsyncNotifierProvider<VendorDetail, VendorCard> {
  /// A vendor's profile, with optimistic follow.
  VendorDetailProvider._({
    required VendorDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorDetailHash();

  @override
  String toString() {
    return r'vendorDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VendorDetail create() => VendorDetail();

  @override
  bool operator ==(Object other) {
    return other is VendorDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorDetailHash() => r'6ad2a1728771e88eb01778d592db1712c3b302b1';

/// A vendor's profile, with optimistic follow.

final class VendorDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          VendorDetail,
          AsyncValue<VendorCard>,
          VendorCard,
          FutureOr<VendorCard>,
          String
        > {
  VendorDetailFamily._()
    : super(
        retry: null,
        name: r'vendorDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A vendor's profile, with optimistic follow.

  VendorDetailProvider call(String vendorId) =>
      VendorDetailProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'vendorDetailProvider';
}

/// A vendor's profile, with optimistic follow.

abstract class _$VendorDetail extends $AsyncNotifier<VendorCard> {
  late final _$args = ref.$arg as String;
  String get vendorId => _$args;

  FutureOr<VendorCard> build(String vendorId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<VendorCard>, VendorCard>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VendorCard>, VendorCard>,
              AsyncValue<VendorCard>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(searchItems)
final searchItemsProvider = SearchItemsFamily._();

final class SearchItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Paginated<ItemCard>>,
          Paginated<ItemCard>,
          FutureOr<Paginated<ItemCard>>
        >
    with
        $FutureModifier<Paginated<ItemCard>>,
        $FutureProvider<Paginated<ItemCard>> {
  SearchItemsProvider._({
    required SearchItemsFamily super.from,
    required (String, String?) super.argument,
  }) : super(
         retry: null,
         name: r'searchItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchItemsHash();

  @override
  String toString() {
    return r'searchItemsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Paginated<ItemCard>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Paginated<ItemCard>> create(Ref ref) {
    final argument = this.argument as (String, String?);
    return searchItems(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchItemsHash() => r'614ce3e36d3545e2273f1f539be01328869caf67';

final class SearchItemsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Paginated<ItemCard>>,
          (String, String?)
        > {
  SearchItemsFamily._()
    : super(
        retry: null,
        name: r'searchItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchItemsProvider call(String query, String? categoryId) =>
      SearchItemsProvider._(argument: (query, categoryId), from: this);

  @override
  String toString() => r'searchItemsProvider';
}

/// By name; within a category, the ones serving the Discover area.

@ProviderFor(searchVendors)
final searchVendorsProvider = SearchVendorsFamily._();

/// By name; within a category, the ones serving the Discover area.

final class SearchVendorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VendorCard>>,
          List<VendorCard>,
          FutureOr<List<VendorCard>>
        >
    with $FutureModifier<List<VendorCard>>, $FutureProvider<List<VendorCard>> {
  /// By name; within a category, the ones serving the Discover area.
  SearchVendorsProvider._({
    required SearchVendorsFamily super.from,
    required (String, String?) super.argument,
  }) : super(
         retry: null,
         name: r'searchVendorsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchVendorsHash();

  @override
  String toString() {
    return r'searchVendorsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<VendorCard>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VendorCard>> create(Ref ref) {
    final argument = this.argument as (String, String?);
    return searchVendors(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchVendorsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchVendorsHash() => r'5128e9385b5b3a5b7b606d7fb8950abe0108fa62';

/// By name; within a category, the ones serving the Discover area.

final class SearchVendorsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<VendorCard>>,
          (String, String?)
        > {
  SearchVendorsFamily._()
    : super(
        retry: null,
        name: r'searchVendorsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// By name; within a category, the ones serving the Discover area.

  SearchVendorsProvider call(String query, String? categoryId) =>
      SearchVendorsProvider._(argument: (query, categoryId), from: this);

  @override
  String toString() => r'searchVendorsProvider';
}

@ProviderFor(searchEvents)
final searchEventsProvider = SearchEventsFamily._();

final class SearchEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingEvent>>,
          List<UpcomingEvent>,
          FutureOr<List<UpcomingEvent>>
        >
    with
        $FutureModifier<List<UpcomingEvent>>,
        $FutureProvider<List<UpcomingEvent>> {
  SearchEventsProvider._({
    required SearchEventsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchEventsHash();

  @override
  String toString() {
    return r'searchEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UpcomingEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UpcomingEvent>> create(Ref ref) {
    final argument = this.argument as String;
    return searchEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchEventsHash() => r'752b795adbf1003ca85237f8b859a82ce8caea32';

final class SearchEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UpcomingEvent>>, String> {
  SearchEventsFamily._()
    : super(
        retry: null,
        name: r'searchEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchEventsProvider call(String query) =>
      SearchEventsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchEventsProvider';
}

/// The last few searches, newest first, kept on the phone.

@ProviderFor(RecentSearches)
final recentSearchesProvider = RecentSearchesProvider._();

/// The last few searches, newest first, kept on the phone.
final class RecentSearchesProvider
    extends $NotifierProvider<RecentSearches, List<String>> {
  /// The last few searches, newest first, kept on the phone.
  RecentSearchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentSearchesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentSearchesHash();

  @$internal
  @override
  RecentSearches create() => RecentSearches();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$recentSearchesHash() => r'080a7094ad80aea23a5fc9b7d75d3aac2ace3bd3';

/// The last few searches, newest first, kept on the phone.

abstract class _$RecentSearches extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
