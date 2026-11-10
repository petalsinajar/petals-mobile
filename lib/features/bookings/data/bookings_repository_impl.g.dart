// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookingsRepository)
final bookingsRepositoryProvider = BookingsRepositoryProvider._();

final class BookingsRepositoryProvider
    extends
        $FunctionalProvider<
          BookingsRepository,
          BookingsRepository,
          BookingsRepository
        >
    with $Provider<BookingsRepository> {
  BookingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookingsRepository create(Ref ref) {
    return bookingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingsRepository>(value),
    );
  }
}

String _$bookingsRepositoryHash() =>
    r'c836173cf4254659bfd299ba5efd43440cf9c1dc';
