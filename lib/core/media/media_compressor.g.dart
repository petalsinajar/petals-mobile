// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_compressor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mediaCompressor)
final mediaCompressorProvider = MediaCompressorProvider._();

final class MediaCompressorProvider
    extends
        $FunctionalProvider<MediaCompressor, MediaCompressor, MediaCompressor>
    with $Provider<MediaCompressor> {
  MediaCompressorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaCompressorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaCompressorHash();

  @$internal
  @override
  $ProviderElement<MediaCompressor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MediaCompressor create(Ref ref) {
    return mediaCompressor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MediaCompressor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MediaCompressor>(value),
    );
  }
}

String _$mediaCompressorHash() => r'89dcf42ceffeef9698bda948662fadd092e4b48e';
