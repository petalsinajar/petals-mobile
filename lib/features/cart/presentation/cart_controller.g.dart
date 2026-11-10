// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The host's carts, one per event, kept on the phone across launches.

@ProviderFor(Cart)
final cartProvider = CartProvider._();

/// The host's carts, one per event, kept on the phone across launches.
final class CartProvider extends $NotifierProvider<Cart, List<CartLine>> {
  /// The host's carts, one per event, kept on the phone across launches.
  CartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartHash();

  @$internal
  @override
  Cart create() => Cart();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CartLine> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CartLine>>(value),
    );
  }
}

String _$cartHash() => r'0e7ea962955fa1a823a316b474ced3769f6a127d';

/// The host's carts, one per event, kept on the phone across launches.

abstract class _$Cart extends $Notifier<List<CartLine>> {
  List<CartLine> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<CartLine>, List<CartLine>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CartLine>, List<CartLine>>,
              List<CartLine>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
