// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Categories to choose from when starting a business.

@ProviderFor(businessCategories)
final businessCategoriesProvider = BusinessCategoriesProvider._();

/// Categories to choose from when starting a business.

final class BusinessCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BusinessCategory>>,
          List<BusinessCategory>,
          FutureOr<List<BusinessCategory>>
        >
    with
        $FutureModifier<List<BusinessCategory>>,
        $FutureProvider<List<BusinessCategory>> {
  /// Categories to choose from when starting a business.
  BusinessCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<BusinessCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BusinessCategory>> create(Ref ref) {
    return businessCategories(ref);
  }
}

String _$businessCategoriesHash() =>
    r'd92685aa99556db9b5060c623806bc0b9d90fe37';

@ProviderFor(VendorRequests)
final vendorRequestsProvider = VendorRequestsFamily._();

final class VendorRequestsProvider
    extends $AsyncNotifierProvider<VendorRequests, VendorRequestsView> {
  VendorRequestsProvider._({
    required VendorRequestsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorRequestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorRequestsHash();

  @override
  String toString() {
    return r'vendorRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VendorRequests create() => VendorRequests();

  @override
  bool operator ==(Object other) {
    return other is VendorRequestsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorRequestsHash() => r'cf39d2510bae1ccb3f494531f37f05b60251f215';

final class VendorRequestsFamily extends $Family
    with
        $ClassFamilyOverride<
          VendorRequests,
          AsyncValue<VendorRequestsView>,
          VendorRequestsView,
          FutureOr<VendorRequestsView>,
          String
        > {
  VendorRequestsFamily._()
    : super(
        retry: null,
        name: r'vendorRequestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorRequestsProvider call(String vendorId) =>
      VendorRequestsProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'vendorRequestsProvider';
}

abstract class _$VendorRequests extends $AsyncNotifier<VendorRequestsView> {
  late final _$args = ref.$arg as String;
  String get vendorId => _$args;

  FutureOr<VendorRequestsView> build(String vendorId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<VendorRequestsView>, VendorRequestsView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VendorRequestsView>, VendorRequestsView>,
              AsyncValue<VendorRequestsView>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(VendorToday)
final vendorTodayProvider = VendorTodayFamily._();

final class VendorTodayProvider
    extends $AsyncNotifierProvider<VendorToday, TodayView> {
  VendorTodayProvider._({
    required VendorTodayFamily super.from,
    required (String, DateTime) super.argument,
  }) : super(
         retry: null,
         name: r'vendorTodayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorTodayHash();

  @override
  String toString() {
    return r'vendorTodayProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  VendorToday create() => VendorToday();

  @override
  bool operator ==(Object other) {
    return other is VendorTodayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorTodayHash() => r'03a1f86fc1ed327e89b562204f1a68c59d5fed29';

final class VendorTodayFamily extends $Family
    with
        $ClassFamilyOverride<
          VendorToday,
          AsyncValue<TodayView>,
          TodayView,
          FutureOr<TodayView>,
          (String, DateTime)
        > {
  VendorTodayFamily._()
    : super(
        retry: null,
        name: r'vendorTodayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorTodayProvider call(String vendorId, DateTime day) =>
      VendorTodayProvider._(argument: (vendorId, day), from: this);

  @override
  String toString() => r'vendorTodayProvider';
}

abstract class _$VendorToday extends $AsyncNotifier<TodayView> {
  late final _$args = ref.$arg as (String, DateTime);
  String get vendorId => _$args.$1;
  DateTime get day => _$args.$2;

  FutureOr<TodayView> build(String vendorId, DateTime day);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TodayView>, TodayView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TodayView>, TodayView>,
              AsyncValue<TodayView>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

@ProviderFor(VendorCalendar)
final vendorCalendarProvider = VendorCalendarFamily._();

final class VendorCalendarProvider
    extends $AsyncNotifierProvider<VendorCalendar, CalendarMonth> {
  VendorCalendarProvider._({
    required VendorCalendarFamily super.from,
    required (String, DateTime) super.argument,
  }) : super(
         retry: null,
         name: r'vendorCalendarProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorCalendarHash();

  @override
  String toString() {
    return r'vendorCalendarProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  VendorCalendar create() => VendorCalendar();

  @override
  bool operator ==(Object other) {
    return other is VendorCalendarProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorCalendarHash() => r'a53e6d76f5f4a51f91293eaf4565ae0683d0a92e';

final class VendorCalendarFamily extends $Family
    with
        $ClassFamilyOverride<
          VendorCalendar,
          AsyncValue<CalendarMonth>,
          CalendarMonth,
          FutureOr<CalendarMonth>,
          (String, DateTime)
        > {
  VendorCalendarFamily._()
    : super(
        retry: null,
        name: r'vendorCalendarProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorCalendarProvider call(String vendorId, DateTime month) =>
      VendorCalendarProvider._(argument: (vendorId, month), from: this);

  @override
  String toString() => r'vendorCalendarProvider';
}

abstract class _$VendorCalendar extends $AsyncNotifier<CalendarMonth> {
  late final _$args = ref.$arg as (String, DateTime);
  String get vendorId => _$args.$1;
  DateTime get month => _$args.$2;

  FutureOr<CalendarMonth> build(String vendorId, DateTime month);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CalendarMonth>, CalendarMonth>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CalendarMonth>, CalendarMonth>,
              AsyncValue<CalendarMonth>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// The Inventory tab's list. Only photos are changed here; everything else
/// is edited on the web dashboard.

@ProviderFor(VendorInventory)
final vendorInventoryProvider = VendorInventoryFamily._();

/// The Inventory tab's list. Only photos are changed here; everything else
/// is edited on the web dashboard.
final class VendorInventoryProvider
    extends $AsyncNotifierProvider<VendorInventory, List<VendorItem>> {
  /// The Inventory tab's list. Only photos are changed here; everything else
  /// is edited on the web dashboard.
  VendorInventoryProvider._({
    required VendorInventoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorInventoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorInventoryHash();

  @override
  String toString() {
    return r'vendorInventoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VendorInventory create() => VendorInventory();

  @override
  bool operator ==(Object other) {
    return other is VendorInventoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorInventoryHash() => r'5cb25c2fa141392a300ec363b60a5cb7f5dd281a';

/// The Inventory tab's list. Only photos are changed here; everything else
/// is edited on the web dashboard.

final class VendorInventoryFamily extends $Family
    with
        $ClassFamilyOverride<
          VendorInventory,
          AsyncValue<List<VendorItem>>,
          List<VendorItem>,
          FutureOr<List<VendorItem>>,
          String
        > {
  VendorInventoryFamily._()
    : super(
        retry: null,
        name: r'vendorInventoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The Inventory tab's list. Only photos are changed here; everything else
  /// is edited on the web dashboard.

  VendorInventoryProvider call(String vendorId) =>
      VendorInventoryProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'vendorInventoryProvider';
}

/// The Inventory tab's list. Only photos are changed here; everything else
/// is edited on the web dashboard.

abstract class _$VendorInventory extends $AsyncNotifier<List<VendorItem>> {
  late final _$args = ref.$arg as String;
  String get vendorId => _$args;

  FutureOr<List<VendorItem>> build(String vendorId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<VendorItem>>, List<VendorItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<VendorItem>>, List<VendorItem>>,
              AsyncValue<List<VendorItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// The Business tab: the profile, with saving and a quick logo change.

@ProviderFor(Business)
final businessProvider = BusinessFamily._();

/// The Business tab: the profile, with saving and a quick logo change.
final class BusinessProvider
    extends $AsyncNotifierProvider<Business, BusinessProfile> {
  /// The Business tab: the profile, with saving and a quick logo change.
  BusinessProvider._({
    required BusinessFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'businessProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$businessHash();

  @override
  String toString() {
    return r'businessProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Business create() => Business();

  @override
  bool operator ==(Object other) {
    return other is BusinessProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$businessHash() => r'3a853b48582da41c504a264fb9c08e11f81a50f4';

/// The Business tab: the profile, with saving and a quick logo change.

final class BusinessFamily extends $Family
    with
        $ClassFamilyOverride<
          Business,
          AsyncValue<BusinessProfile>,
          BusinessProfile,
          FutureOr<BusinessProfile>,
          String
        > {
  BusinessFamily._()
    : super(
        retry: null,
        name: r'businessProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The Business tab: the profile, with saving and a quick logo change.

  BusinessProvider call(String vendorId) =>
      BusinessProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'businessProvider';
}

/// The Business tab: the profile, with saving and a quick logo change.

abstract class _$Business extends $AsyncNotifier<BusinessProfile> {
  late final _$args = ref.$arg as String;
  String get vendorId => _$args;

  FutureOr<BusinessProfile> build(String vendorId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BusinessProfile>, BusinessProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BusinessProfile>, BusinessProfile>,
              AsyncValue<BusinessProfile>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
