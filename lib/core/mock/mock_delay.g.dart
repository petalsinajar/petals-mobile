// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_delay.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mockDelay)
final mockDelayProvider = MockDelayProvider._();

final class MockDelayProvider
    extends $FunctionalProvider<MockDelay, MockDelay, MockDelay>
    with $Provider<MockDelay> {
  MockDelayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockDelayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockDelayHash();

  @$internal
  @override
  $ProviderElement<MockDelay> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MockDelay create(Ref ref) {
    return mockDelay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockDelay value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockDelay>(value),
    );
  }
}

String _$mockDelayHash() => r'ca008d8a863ee4a9053f252d7894d06ccc4d17a1';
