// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_posts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Shared posts still uploading, kept across restarts.

@ProviderFor(PendingPosts)
final pendingPostsProvider = PendingPostsProvider._();

/// Shared posts still uploading, kept across restarts.
final class PendingPostsProvider
    extends $NotifierProvider<PendingPosts, List<PendingPost>> {
  /// Shared posts still uploading, kept across restarts.
  PendingPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingPostsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingPostsHash();

  @$internal
  @override
  PendingPosts create() => PendingPosts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PendingPost> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PendingPost>>(value),
    );
  }
}

String _$pendingPostsHash() => r'd083c64f5318e335728ab1c2a25b35ab07b748ba';

/// Shared posts still uploading, kept across restarts.

abstract class _$PendingPosts extends $Notifier<List<PendingPost>> {
  List<PendingPost> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<PendingPost>, List<PendingPost>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<PendingPost>, List<PendingPost>>,
              List<PendingPost>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
