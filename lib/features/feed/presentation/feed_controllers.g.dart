// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// One of the home feeds, with infinite scroll, refresh and optimistic likes.

@ProviderFor(FeedPosts)
final feedPostsProvider = FeedPostsFamily._();

/// One of the home feeds, with infinite scroll, refresh and optimistic likes.
final class FeedPostsProvider
    extends $AsyncNotifierProvider<FeedPosts, Paginated<FeedPost>> {
  /// One of the home feeds, with infinite scroll, refresh and optimistic likes.
  FeedPostsProvider._({
    required FeedPostsFamily super.from,
    required FeedKind super.argument,
  }) : super(
         retry: null,
         name: r'feedPostsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedPostsHash();

  @override
  String toString() {
    return r'feedPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FeedPosts create() => FeedPosts();

  @override
  bool operator ==(Object other) {
    return other is FeedPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedPostsHash() => r'fd7e489a003ba67c9a0116548a2e7537e41ea0e5';

/// One of the home feeds, with infinite scroll, refresh and optimistic likes.

final class FeedPostsFamily extends $Family
    with
        $ClassFamilyOverride<
          FeedPosts,
          AsyncValue<Paginated<FeedPost>>,
          Paginated<FeedPost>,
          FutureOr<Paginated<FeedPost>>,
          FeedKind
        > {
  FeedPostsFamily._()
    : super(
        retry: null,
        name: r'feedPostsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One of the home feeds, with infinite scroll, refresh and optimistic likes.

  FeedPostsProvider call(FeedKind kind) =>
      FeedPostsProvider._(argument: kind, from: this);

  @override
  String toString() => r'feedPostsProvider';
}

/// One of the home feeds, with infinite scroll, refresh and optimistic likes.

abstract class _$FeedPosts extends $AsyncNotifier<Paginated<FeedPost>> {
  late final _$args = ref.$arg as FeedKind;
  FeedKind get kind => _$args;

  FutureOr<Paginated<FeedPost>> build(FeedKind kind);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Paginated<FeedPost>>, Paginated<FeedPost>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Paginated<FeedPost>>, Paginated<FeedPost>>,
              AsyncValue<Paginated<FeedPost>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// A post's comments, with "load more" and adding one.

@ProviderFor(PostComments)
final postCommentsProvider = PostCommentsFamily._();

/// A post's comments, with "load more" and adding one.
final class PostCommentsProvider
    extends $AsyncNotifierProvider<PostComments, Paginated<PostComment>> {
  /// A post's comments, with "load more" and adding one.
  PostCommentsProvider._({
    required PostCommentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'postCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postCommentsHash();

  @override
  String toString() {
    return r'postCommentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PostComments create() => PostComments();

  @override
  bool operator ==(Object other) {
    return other is PostCommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postCommentsHash() => r'82645320d75bd7de925c58da49c37bc4be02ade4';

/// A post's comments, with "load more" and adding one.

final class PostCommentsFamily extends $Family
    with
        $ClassFamilyOverride<
          PostComments,
          AsyncValue<Paginated<PostComment>>,
          Paginated<PostComment>,
          FutureOr<Paginated<PostComment>>,
          String
        > {
  PostCommentsFamily._()
    : super(
        retry: null,
        name: r'postCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A post's comments, with "load more" and adding one.

  PostCommentsProvider call(String postId) =>
      PostCommentsProvider._(argument: postId, from: this);

  @override
  String toString() => r'postCommentsProvider';
}

/// A post's comments, with "load more" and adding one.

abstract class _$PostComments extends $AsyncNotifier<Paginated<PostComment>> {
  late final _$args = ref.$arg as String;
  String get postId => _$args;

  FutureOr<Paginated<PostComment>> build(String postId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Paginated<PostComment>>, Paginated<PostComment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Paginated<PostComment>>,
                Paginated<PostComment>
              >,
              AsyncValue<Paginated<PostComment>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
