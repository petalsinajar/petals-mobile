// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's id, or null when signed out (or still restoring).
///
/// Lives in the app layer so features can ask "is someone signed in?"
/// without importing the auth feature's internals.
///
/// Listeners are only told when the id itself changes (a new value equal to
/// the old one doesn't notify), so profile edits don't reload feeds.

@ProviderFor(viewerId)
final viewerIdProvider = ViewerIdProvider._();

/// The signed-in user's id, or null when signed out (or still restoring).
///
/// Lives in the app layer so features can ask "is someone signed in?"
/// without importing the auth feature's internals.
///
/// Listeners are only told when the id itself changes (a new value equal to
/// the old one doesn't notify), so profile edits don't reload feeds.

final class ViewerIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// The signed-in user's id, or null when signed out (or still restoring).
  ///
  /// Lives in the app layer so features can ask "is someone signed in?"
  /// without importing the auth feature's internals.
  ///
  /// Listeners are only told when the id itself changes (a new value equal to
  /// the old one doesn't notify), so profile edits don't reload feeds.
  ViewerIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewerIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewerIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return viewerId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$viewerIdHash() => r'a22082ffe16e1490dbef11a7d32a9b633620dc6f';
