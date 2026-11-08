// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Categories to choose from when starting a business.

@ProviderFor(businessCategories)
final businessCategoriesProvider = BusinessCategoriesProvider._();

/// Categories to choose from when starting a business.

final class BusinessCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BusinessCategory>>,
          List<BusinessCategory>,
          FutureOr<List<BusinessCategory>>
        >
    with
        $FutureModifier<List<BusinessCategory>>,
        $FutureProvider<List<BusinessCategory>> {
  /// Categories to choose from when starting a business.
  BusinessCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<BusinessCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BusinessCategory>> create(Ref ref) {
    return businessCategories(ref);
  }
}

String _$businessCategoriesHash() =>
    r'd92685aa99556db9b5060c623806bc0b9d90fe37';

@ProviderFor(VendorRequests)
final vendorRequestsProvider = VendorRequestsFamily._();

final class VendorRequestsProvider
    extends $AsyncNotifierProvider<VendorRequests, VendorRequestsView> {
  VendorRequestsProvider._({
    required VendorRequestsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorRequestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorRequestsHash();

  @override
  String toString() {
    return r'vendorRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VendorRequests create() => VendorRequests();

  @override
  bool operator ==(Object other) {
    return other is VendorRequestsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorRequestsHash() => r'c1f36592ad2ad646fd99ef06d639c0fdae43a913';

final class VendorRequestsFamily extends $Family
    with
        $ClassFamilyOverride<
          VendorRequests,
          AsyncValue<VendorRequestsView>,
          VendorRequestsView,
          FutureOr<VendorRequestsView>,
          String
        > {
  VendorRequestsFamily._()
    : super(
        retry: null,
        name: r'vendorRequestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorRequestsProvider call(String vendorId) =>
      VendorRequestsProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'vendorRequestsProvider';
}

abstract class _$VendorRequests extends $AsyncNotifier<VendorRequestsView> {
  late final _$args = ref.$arg as String;
  String get vendorId => _$args;

  FutureOr<VendorRequestsView> build(String vendorId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<VendorRequestsView>, VendorRequestsView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VendorRequestsView>, VendorRequestsView>,
              AsyncValue<VendorRequestsView>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
