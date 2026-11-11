// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autoplay.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the phone is on Wi-Fi (or Ethernet); replaceable in tests.

@ProviderFor(onWifi)
final onWifiProvider = OnWifiProvider._();

/// Whether the phone is on Wi-Fi (or Ethernet); replaceable in tests.

final class OnWifiProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// Whether the phone is on Wi-Fi (or Ethernet); replaceable in tests.
  OnWifiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onWifiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onWifiHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return onWifi(ref);
  }
}

String _$onWifiHash() => r'6ac083ed95bac4631b5cabeca71cebc6324cae3c';

/// "Autoplay videos on mobile data" — off unless the user turns it on.

@ProviderFor(AutoplayOnCellular)
final autoplayOnCellularProvider = AutoplayOnCellularProvider._();

/// "Autoplay videos on mobile data" — off unless the user turns it on.
final class AutoplayOnCellularProvider
    extends $NotifierProvider<AutoplayOnCellular, bool> {
  /// "Autoplay videos on mobile data" — off unless the user turns it on.
  AutoplayOnCellularProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoplayOnCellularProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoplayOnCellularHash();

  @$internal
  @override
  AutoplayOnCellular create() => AutoplayOnCellular();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$autoplayOnCellularHash() =>
    r'6ac5b1b919fd22a16c9890d7bb818fb7b6244b90';

/// "Autoplay videos on mobile data" — off unless the user turns it on.

abstract class _$AutoplayOnCellular extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Feed videos may start on their own: on Wi-Fi, or when allowed.

@ProviderFor(canAutoplay)
final canAutoplayProvider = CanAutoplayProvider._();

/// Feed videos may start on their own: on Wi-Fi, or when allowed.

final class CanAutoplayProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Feed videos may start on their own: on Wi-Fi, or when allowed.
  CanAutoplayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'canAutoplayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$canAutoplayHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return canAutoplay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$canAutoplayHash() => r'92bfd61a5b57cff2ac5a7f282914451246fe3dd4';
