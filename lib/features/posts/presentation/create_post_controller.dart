import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/posts/data/posts_repository_impl.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_post_controller.freezed.dart';
part 'create_post_controller.g.dart';

enum DraftPhase { editing, uploading, posting }

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

    /// Photos uploaded so far while sharing.
    @Default(0) int uploaded,
  }) = _PostDraft;

  const PostDraft._();

  bool get isEmpty => photos.isEmpty && caption.trim().isEmpty;
  bool get isBusy => phase != DraftPhase.editing;
  bool get canShare => photos.isNotEmpty && !isBusy;
}

/// The post being written. Kept alive so switching tabs doesn't lose it.
@Riverpod(keepAlive: true)
class CreatePost extends _$CreatePost {
  static const maxPhotos = 10;

  /// Uploads by local path, so a retry after a failure doesn't upload twice.
  final _uploads = <String, UploadedImage>{};

  @override
  PostDraft build() => const PostDraft();

  void addPhotos(List<String> paths) {
    final room = maxPhotos - state.photos.length;
    state = state.copyWith(
      photos: [
        ...state.photos,
        for (final p in paths.take(room)) DraftPhoto(path: p),
      ],
    );
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

  void discard() {
    _uploads.clear();
    state = const PostDraft();
  }

  /// Uploads the photos, then publishes. Returns the new post's id and
  /// clears the draft; on failure keeps the draft and rethrows.
  Future<String> share() async {
    final draft = state;
    if (!draft.canShare) throw StateError('Nothing to share');
    final repo = ref.read(postsRepositoryProvider);

    try {
      state = draft.copyWith(phase: DraftPhase.uploading, uploaded: 0);
      final media = <UploadedImage>[];
      for (final photo in draft.photos) {
        media.add(_uploads[photo.path] ??= await repo.upload(photo.path));
        state = state.copyWith(uploaded: media.length);
      }

      state = state.copyWith(phase: DraftPhase.posting);
      final id = await repo.create(
        NewPost(
          media: media,
          caption: draft.caption,
          asVendorId: draft.asVendorId,
          eventId: draft.event?.id,
          visibility: draft.visibility,
          tags: draft.tags,
        ),
      );
      discard();
      return id;
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
