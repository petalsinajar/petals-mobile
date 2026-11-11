import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_draft.freezed.dart';

/// Who sees the post. `eventMembers` needs an event.
enum PostVisibility { public, followers, eventMembers }

/// What a pin points at.
enum TagTargetType { item, vendor }

/// A photo or video picked from the phone, not uploaded yet.
@freezed
abstract class DraftPhoto with _$DraftPhoto {
  const factory DraftPhoto({
    required String path,
    @Default(false) bool isVideo,
  }) = _DraftPhoto;
}

/// Something a pin can tag: a rentable item or a vendor.
@freezed
abstract class TagTarget with _$TagTarget {
  const factory TagTarget({
    required TagTargetType type,
    required String id,
    required String label,

    /// The vendor's name for items; the city for vendors.
    String? subtitle,
    String? imageUrl,
  }) = _TagTarget;
}

/// A pin on photo [mediaIndex] at fractional [x], [y].
@freezed
abstract class DraftTag with _$DraftTag {
  const factory DraftTag({
    required int mediaIndex,
    required double x,
    required double y,
    required TagTarget target,
  }) = _DraftTag;
}

/// An event the viewer may post to (hosting, or going / maybe).
@freezed
abstract class PostableEvent with _$PostableEvent {
  const factory PostableEvent({
    required String id,
    required String title,
    required DateTime startsAt,
  }) = _PostableEvent;
}

/// A business the viewer may post as (owner or manager).
@freezed
abstract class PostingIdentity with _$PostingIdentity {
  const factory PostingIdentity({
    required String name,

    /// Null for the viewer themself.
    String? vendorId,
    String? avatarUrl,
  }) = _PostingIdentity;
}

/// Everything `POST /v1/posts` needs, with its media uploaded and ready.
@freezed
abstract class NewPost with _$NewPost {
  const factory NewPost({
    /// Ready media ids, in order.
    required List<String> mediaIds,
    @Default('') String caption,
    String? asVendorId,
    String? eventId,
    @Default(PostVisibility.public) PostVisibility visibility,
    @Default(<DraftTag>[]) List<DraftTag> tags,
  }) = _NewPost;
}
