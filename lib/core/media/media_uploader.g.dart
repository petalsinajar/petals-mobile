// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_uploader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mediaUploader)
final mediaUploaderProvider = MediaUploaderProvider._();

final class MediaUploaderProvider
    extends $FunctionalProvider<MediaUploader, MediaUploader, MediaUploader>
    with $Provider<MediaUploader> {
  MediaUploaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaUploaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaUploaderHash();

  @$internal
  @override
  $ProviderElement<MediaUploader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MediaUploader create(Ref ref) {
    return mediaUploader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MediaUploader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MediaUploader>(value),
    );
  }
}

String _$mediaUploaderHash() => r'b275ea2573f68addf15b0817dbd51f255b05684a';
