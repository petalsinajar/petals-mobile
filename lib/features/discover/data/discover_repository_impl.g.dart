// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(discoverRepository)
final discoverRepositoryProvider = DiscoverRepositoryProvider._();

final class DiscoverRepositoryProvider
    extends
        $FunctionalProvider<
          DiscoverRepository,
          DiscoverRepository,
          DiscoverRepository
        >
    with $Provider<DiscoverRepository> {
  DiscoverRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverRepositoryHash();

  @$internal
  @override
  $ProviderElement<DiscoverRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DiscoverRepository create(Ref ref) {
    return discoverRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoverRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoverRepository>(value),
    );
  }
}

String _$discoverRepositoryHash() =>
    r'75c2a844ff4a5e750577239ac9c1073eba73b1aa';
