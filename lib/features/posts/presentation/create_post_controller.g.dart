// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The post being written. Kept alive so switching tabs doesn't lose it.

@ProviderFor(CreatePost)
final createPostProvider = CreatePostProvider._();

/// The post being written. Kept alive so switching tabs doesn't lose it.
final class CreatePostProvider
    extends $NotifierProvider<CreatePost, PostDraft> {
  /// The post being written. Kept alive so switching tabs doesn't lose it.
  CreatePostProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPostProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPostHash();

  @$internal
  @override
  CreatePost create() => CreatePost();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostDraft>(value),
    );
  }
}

String _$createPostHash() => r'b0ec3736c9b207e64030f4b93d9a7bcbb3f02946';

/// The post being written. Kept alive so switching tabs doesn't lose it.

abstract class _$CreatePost extends $Notifier<PostDraft> {
  PostDraft build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PostDraft, PostDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostDraft, PostDraft>,
              PostDraft,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(postableEvents)
final postableEventsProvider = PostableEventsProvider._();

final class PostableEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostableEvent>>,
          List<PostableEvent>,
          FutureOr<List<PostableEvent>>
        >
    with
        $FutureModifier<List<PostableEvent>>,
        $FutureProvider<List<PostableEvent>> {
  PostableEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postableEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postableEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<PostableEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PostableEvent>> create(Ref ref) {
    return postableEvents(ref);
  }
}

String _$postableEventsHash() => r'86f06528367707b32339df99749f8795c2ebb9cd';

@ProviderFor(tagSearch)
final tagSearchProvider = TagSearchFamily._();

final class TagSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TagTarget>>,
          List<TagTarget>,
          FutureOr<List<TagTarget>>
        >
    with $FutureModifier<List<TagTarget>>, $FutureProvider<List<TagTarget>> {
  TagSearchProvider._({
    required TagSearchFamily super.from,
    required (TagTargetType, String) super.argument,
  }) : super(
         retry: null,
         name: r'tagSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tagSearchHash();

  @override
  String toString() {
    return r'tagSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<TagTarget>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TagTarget>> create(Ref ref) {
    final argument = this.argument as (TagTargetType, String);
    return tagSearch(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is TagSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tagSearchHash() => r'dfcf3003fcdcb5c8cfd937b5d79dbe9ded6468b5';

final class TagSearchFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<TagTarget>>,
          (TagTargetType, String)
        > {
  TagSearchFamily._()
    : super(
        retry: null,
        name: r'tagSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TagSearchProvider call(TagTargetType type, String query) =>
      TagSearchProvider._(argument: (type, query), from: this);

  @override
  String toString() => r'tagSearchProvider';
}

/// Who the viewer can post as: themself, and businesses they manage.

@ProviderFor(postingIdentities)
final postingIdentitiesProvider = PostingIdentitiesProvider._();

/// Who the viewer can post as: themself, and businesses they manage.

final class PostingIdentitiesProvider
    extends
        $FunctionalProvider<
          List<PostingIdentity>,
          List<PostingIdentity>,
          List<PostingIdentity>
        >
    with $Provider<List<PostingIdentity>> {
  /// Who the viewer can post as: themself, and businesses they manage.
  PostingIdentitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postingIdentitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postingIdentitiesHash();

  @$internal
  @override
  $ProviderElement<List<PostingIdentity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PostingIdentity> create(Ref ref) {
    return postingIdentities(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PostingIdentity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PostingIdentity>>(value),
    );
  }
}

String _$postingIdentitiesHash() => r'20c6111e024fd58365dbc1da8eb37265b22b7d86';
