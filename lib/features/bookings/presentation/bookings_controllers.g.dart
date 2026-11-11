// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "My bookings", newest first, with load more.

@ProviderFor(MyBookings)
final myBookingsProvider = MyBookingsProvider._();

/// "My bookings", newest first, with load more.
final class MyBookingsProvider
    extends $AsyncNotifierProvider<MyBookings, Paginated<CustomerBooking>> {
  /// "My bookings", newest first, with load more.
  MyBookingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myBookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myBookingsHash();

  @$internal
  @override
  MyBookings create() => MyBookings();
}

String _$myBookingsHash() => r'f177b8ed178cc9e9f6d1263dde63d3a3e687cb10';

/// "My bookings", newest first, with load more.

abstract class _$MyBookings extends $AsyncNotifier<Paginated<CustomerBooking>> {
  FutureOr<Paginated<CustomerBooking>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Paginated<CustomerBooking>>,
              Paginated<CustomerBooking>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Paginated<CustomerBooking>>,
                Paginated<CustomerBooking>
              >,
              AsyncValue<Paginated<CustomerBooking>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// One booking with its timeline.

@ProviderFor(BookingDetail)
final bookingDetailProvider = BookingDetailFamily._();

/// One booking with its timeline.
final class BookingDetailProvider
    extends $AsyncNotifierProvider<BookingDetail, CustomerBooking> {
  /// One booking with its timeline.
  BookingDetailProvider._({
    required BookingDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookingDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingDetailHash();

  @override
  String toString() {
    return r'bookingDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BookingDetail create() => BookingDetail();

  @override
  bool operator ==(Object other) {
    return other is BookingDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingDetailHash() => r'2fc0f6f0de6730754d260771b059eedc94b11f13';

/// One booking with its timeline.

final class BookingDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          BookingDetail,
          AsyncValue<CustomerBooking>,
          CustomerBooking,
          FutureOr<CustomerBooking>,
          String
        > {
  BookingDetailFamily._()
    : super(
        retry: null,
        name: r'bookingDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One booking with its timeline.

  BookingDetailProvider call(String bookingId) =>
      BookingDetailProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'bookingDetailProvider';
}

/// One booking with its timeline.

abstract class _$BookingDetail extends $AsyncNotifier<CustomerBooking> {
  late final _$args = ref.$arg as String;
  String get bookingId => _$args;

  FutureOr<CustomerBooking> build(String bookingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CustomerBooking>, CustomerBooking>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomerBooking>, CustomerBooking>,
              AsyncValue<CustomerBooking>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Sends booking requests and keeps "My bookings" current.
///
/// Kept alive: the request sheet only reads it, so an auto-disposed one
/// would be gone by the time the server answers.

@ProviderFor(BookingRequester)
final bookingRequesterProvider = BookingRequesterProvider._();

/// Sends booking requests and keeps "My bookings" current.
///
/// Kept alive: the request sheet only reads it, so an auto-disposed one
/// would be gone by the time the server answers.
final class BookingRequesterProvider
    extends $NotifierProvider<BookingRequester, void> {
  /// Sends booking requests and keeps "My bookings" current.
  ///
  /// Kept alive: the request sheet only reads it, so an auto-disposed one
  /// would be gone by the time the server answers.
  BookingRequesterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingRequesterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingRequesterHash();

  @$internal
  @override
  BookingRequester create() => BookingRequester();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$bookingRequesterHash() => r'31a0da4b65dd6ff64b430484517a0bdfb2b6783c';

/// Sends booking requests and keeps "My bookings" current.
///
/// Kept alive: the request sheet only reads it, so an auto-disposed one
/// would be gone by the time the server answers.

abstract class _$BookingRequester extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// How many of a variant are free on [day], and whether it's closed.

@ProviderFor(variantAvailability)
final variantAvailabilityProvider = VariantAvailabilityFamily._();

/// How many of a variant are free on [day], and whether it's closed.

final class VariantAvailabilityProvider
    extends
        $FunctionalProvider<
          AsyncValue<Availability>,
          Availability,
          FutureOr<Availability>
        >
    with $FutureModifier<Availability>, $FutureProvider<Availability> {
  /// How many of a variant are free on [day], and whether it's closed.
  VariantAvailabilityProvider._({
    required VariantAvailabilityFamily super.from,
    required (String, String, DateTime) super.argument,
  }) : super(
         retry: null,
         name: r'variantAvailabilityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$variantAvailabilityHash();

  @override
  String toString() {
    return r'variantAvailabilityProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Availability> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Availability> create(Ref ref) {
    final argument = this.argument as (String, String, DateTime);
    return variantAvailability(ref, argument.$1, argument.$2, argument.$3);
  }

  @override
  bool operator ==(Object other) {
    return other is VariantAvailabilityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$variantAvailabilityHash() =>
    r'9a4d8379c29b254197ab2aa38798b500ad068614';

/// How many of a variant are free on [day], and whether it's closed.

final class VariantAvailabilityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Availability>,
          (String, String, DateTime)
        > {
  VariantAvailabilityFamily._()
    : super(
        retry: null,
        name: r'variantAvailabilityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// How many of a variant are free on [day], and whether it's closed.

  VariantAvailabilityProvider call(
    String itemId,
    String variantId,
    DateTime day,
  ) => VariantAvailabilityProvider._(
    argument: (itemId, variantId, day),
    from: this,
  );

  @override
  String toString() => r'variantAvailabilityProvider';
}
