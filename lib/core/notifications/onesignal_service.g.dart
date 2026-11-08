// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onesignal_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Overridden in tests, where the native SDK isn't available.

@ProviderFor(oneSignalService)
final oneSignalServiceProvider = OneSignalServiceProvider._();

/// Overridden in tests, where the native SDK isn't available.

final class OneSignalServiceProvider
    extends
        $FunctionalProvider<
          OneSignalService,
          OneSignalService,
          OneSignalService
        >
    with $Provider<OneSignalService> {
  /// Overridden in tests, where the native SDK isn't available.
  OneSignalServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oneSignalServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oneSignalServiceHash();

  @$internal
  @override
  $ProviderElement<OneSignalService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OneSignalService create(Ref ref) {
    return oneSignalService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OneSignalService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OneSignalService>(value),
    );
  }
}

String _$oneSignalServiceHash() => r'7e995d69b7b8dde93cb188596c2ef273afc58b6c';
