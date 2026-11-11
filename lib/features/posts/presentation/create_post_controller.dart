import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/posts/data/posts_repository_impl.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/presentation/pending_posts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_post_controller.freezed.dart';
part 'create_post_controller.g.dart';

/// `uploading` covers the moment Share hands the files to the queue.
enum DraftPhase { editing, uploading }

@freezed
abstract class PostDraft with _$PostDraft {
  const factory PostDraft({
    @Default(<DraftPhoto>[]) List<DraftPhoto> photos,
    @Default('') String caption,
    String? asVendorId,
    PostableEvent? event,
    @Default(PostVisibility.public) PostVisibility visibility,
    @Default(<DraftTag>[]) List<DraftTag> tags,
    @Default(DraftPhase.editing) DraftPhase phase,
  }) = _PostDraft;

  const PostDraft._();

  bool get isEmpty => photos.isEmpty && caption.trim().isEmpty;
  bool get isBusy => phase != DraftPhase.editing;
  bool get canShare => photos.isNotEmpty && !isBusy;
}

/// The post being written. Kept alive so switching tabs doesn't lose it.
@Riverpod(keepAlive: true)
class CreatePost extends _$CreatePost {
  static const int maxPhotos = MediaLimits.postMaxMedia;

  @override
  PostDraft build() => const PostDraft();

  /// Adds picked photos and videos, up to [maxPhotos] in all.
  void addPhotos(List<DraftPhoto> picked) {
    final room = maxPhotos - state.photos.length;
    state = state.copyWith(photos: [...state.photos, ...picked.take(room)]);
  }

  /// Drops photo [index] and its pins; later photos' pins shift down.
  void removePhoto(int index) {
    state = state.copyWith(
      photos: [...state.photos]..removeAt(index),
      tags: [
        for (final t in state.tags)
          if (t.mediaIndex != index)
            t.mediaIndex > index ? t.copyWith(mediaIndex: t.mediaIndex - 1) : t,
      ],
    );
  }

  void addTag(DraftTag tag) =>
      state = state.copyWith(tags: [...state.tags, tag]);

  void removeTag(DraftTag tag) => state = state.copyWith(
    tags: [
      for (final t in state.tags)
        if (t != tag) t,
    ],
  );

  void setCaption(String caption) => state = state.copyWith(caption: caption);

  void setIdentity(String? vendorId) =>
      state = state.copyWith(asVendorId: vendorId);

  void setEvent(PostableEvent? event) => state = state.copyWith(
    event: event,
    // "Event guests only" means nothing without an event.
    visibility: event == null && state.visibility == PostVisibility.eventMembers
        ? PostVisibility.public
        : state.visibility,
  );

  void setVisibility(PostVisibility visibility) =>
      state = state.copyWith(visibility: visibility);

  void discard() => state = const PostDraft();

  /// Hands the post to the upload queue and clears the draft at once; it
  /// shows in the feed as uploading and publishes when its media is ready.
  Future<void> share() async {
    final draft = state;
    if (!draft.canShare) throw StateError('Nothing to share');
    state = draft.copyWith(phase: DraftPhase.uploading);
    try {
      await ref.read(pendingPostsProvider.notifier).submit(draft);
      discard();
    } on Object {
      state = state.copyWith(phase: DraftPhase.editing);
      rethrow;
    }
  }
}

@riverpod
Future<List<PostableEvent>> postableEvents(Ref ref) =>
    ref.watch(postsRepositoryProvider).postableEvents();

@riverpod
Future<List<TagTarget>> tagSearch(Ref ref, TagTargetType type, String query) {
  if (query.trim().length < 2) return Future.value(const []);
  return ref.watch(postsRepositoryProvider).searchTargets(type, query);
}

/// Who the viewer can post as: themself, and businesses they manage.
@riverpod
List<PostingIdentity> postingIdentities(Ref ref) {
  final me = ref.watch(authSessionProvider).value;
  if (me == null) return const [];
  return [
    PostingIdentity(
      name: me.displayName.isEmpty ? '@${me.handle}' : me.displayName,
      avatarUrl: me.avatarUrl,
    ),
    for (final v in me.vendors)
      if (v.role == 'owner' || v.role == 'manager')
        PostingIdentity(name: v.name, vendorId: v.id, avatarUrl: v.logoUrl),
  ];
}
