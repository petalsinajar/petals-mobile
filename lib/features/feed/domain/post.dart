import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/core/media/media.dart';

part 'post.freezed.dart';

/// Who posted or commented: a person, or a vendor posting as their business.
@freezed
abstract class PostAuthor with _$PostAuthor {
  const factory PostAuthor({
    required String id,
    required String name,
    String? handle,
    String? avatarUrl,
    @Default(false) bool isVendor,
    @Default(false) bool isVerified,
  }) = _PostAuthor;
}

@freezed
abstract class PostMedia with _$PostMedia {
  const factory PostMedia({
    required String url,
    int? width,
    int? height,
    String? blurhash,
    @Default(false) bool isVideo,

    /// Every size (and the stream, for videos), when the API sent them.
    Media? media,
  }) = _PostMedia;

  const PostMedia._();

  /// Width / height, kept between 4:5 (portrait) and 1.91:1 (landscape) so
  /// one odd photo can't make a card absurdly tall or thin.
  double get aspectRatio {
    final w = width;
    final h = height;
    if (w == null || h == null || w <= 0 || h <= 0) return 4 / 5;
    return (w / h).clamp(4 / 5, 1.91);
  }
}

/// The event a post was shared to, for the "at (event)" link on the card.
@freezed
abstract class PostEventRef with _$PostEventRef {
  const factory PostEventRef({required String id, required String title}) =
      _PostEventRef;
}

@freezed
abstract class FeedPost with _$FeedPost {
  const factory FeedPost({
    required String id,
    required PostAuthor author,
    required DateTime createdAt,
    @Default('') String caption,
    @Default(<PostMedia>[]) List<PostMedia> media,
    PostEventRef? event,
    @Default(0) int likeCount,
    @Default(0) int commentCount,

    /// Whether the signed-in viewer has liked it. Always false signed out.
    @Default(false) bool likedByMe,

    /// The viewer posted it, or manages the business that did.
    @Default(false) bool canDelete,
  }) = _FeedPost;

  const FeedPost._();

  /// [likedByMe] flipped, with the count moved to match.
  FeedPost toggledLike() => copyWith(
    likedByMe: !likedByMe,
    likeCount: (likeCount + (likedByMe ? -1 : 1)).clamp(0, 1 << 31),
  );
}

@freezed
abstract class PostComment with _$PostComment {
  const factory PostComment({
    required String id,
    required PostAuthor author,
    required String body,
    required DateTime createdAt,
  }) = _PostComment;
}
