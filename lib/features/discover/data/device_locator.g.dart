// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_locator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceLocator)
final deviceLocatorProvider = DeviceLocatorProvider._();

final class DeviceLocatorProvider
    extends $FunctionalProvider<DeviceLocator, DeviceLocator, DeviceLocator>
    with $Provider<DeviceLocator> {
  DeviceLocatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceLocatorHash();

  @$internal
  @override
  $ProviderElement<DeviceLocator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeviceLocator create(Ref ref) {
    return deviceLocator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceLocator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceLocator>(value),
    );
  }
}

String _$deviceLocatorHash() => r'1bf38cf7d1f1ce23bb4b27758db515acbb70b8fb';
