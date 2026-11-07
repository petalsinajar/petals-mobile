// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The seed user mock sources treat as signed in (Ama Mensah: hosts a
/// wedding, attends several events, owns a vendor).
///
/// Mock-only: with the real API the server knows who's calling. Replaced by
/// the auth session's `me` once auth lands.

@ProviderFor(mockViewerId)
final mockViewerIdProvider = MockViewerIdProvider._();

/// The seed user mock sources treat as signed in (Ama Mensah: hosts a
/// wedding, attends several events, owns a vendor).
///
/// Mock-only: with the real API the server knows who's calling. Replaced by
/// the auth session's `me` once auth lands.

final class MockViewerIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// The seed user mock sources treat as signed in (Ama Mensah: hosts a
  /// wedding, attends several events, owns a vendor).
  ///
  /// Mock-only: with the real API the server knows who's calling. Replaced by
  /// the auth session's `me` once auth lands.
  MockViewerIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockViewerIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockViewerIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return mockViewerId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$mockViewerIdHash() => r'df9d0f0fe162a0d42337ffd1493363f6858bbb5b';
