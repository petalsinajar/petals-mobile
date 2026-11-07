// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_loader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(seedLoader)
final seedLoaderProvider = SeedLoaderProvider._();

final class SeedLoaderProvider
    extends $FunctionalProvider<SeedLoader, SeedLoader, SeedLoader>
    with $Provider<SeedLoader> {
  SeedLoaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seedLoaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seedLoaderHash();

  @$internal
  @override
  $ProviderElement<SeedLoader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SeedLoader create(Ref ref) {
    return seedLoader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeedLoader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeedLoader>(value),
    );
  }
}

String _$seedLoaderHash() => r'46d07df40a1b276d14472c511119ebd2a42d3b87';
