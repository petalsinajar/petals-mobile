// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoSource)
final photoSourceProvider = PhotoSourceProvider._();

final class PhotoSourceProvider
    extends $FunctionalProvider<PhotoSource, PhotoSource, PhotoSource>
    with $Provider<PhotoSource> {
  PhotoSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoSourceHash();

  @$internal
  @override
  $ProviderElement<PhotoSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoSource create(Ref ref) {
    return photoSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoSource>(value),
    );
  }
}

String _$photoSourceHash() => r'c4c56464ae4b27a9829275d119927bbc63e68c31';
