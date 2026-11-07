// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_name.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The `device_name` sent when signing in, e.g. `Petalsinajar ios 1a2b3c4d`.
///
/// The server names this device's tokens after it and signs out by name, so
/// it must be unique per install: two phones both called "ios" would sign
/// each other out. The random part is created once and kept.

@ProviderFor(deviceName)
final deviceNameProvider = DeviceNameProvider._();

/// The `device_name` sent when signing in, e.g. `Petalsinajar ios 1a2b3c4d`.
///
/// The server names this device's tokens after it and signs out by name, so
/// it must be unique per install: two phones both called "ios" would sign
/// each other out. The random part is created once and kept.

final class DeviceNameProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// The `device_name` sent when signing in, e.g. `Petalsinajar ios 1a2b3c4d`.
  ///
  /// The server names this device's tokens after it and signs out by name, so
  /// it must be unique per install: two phones both called "ios" would sign
  /// each other out. The random part is created once and kept.
  DeviceNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceNameProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceNameHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return deviceName(ref);
  }
}

String _$deviceNameHash() => r'dd073652c1bf3e5db96b1244694d1515edceb11d';
