import 'package:json_annotation/json_annotation.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';

part 'feed_dtos.g.dart';

// Shapes mirror the backend: ActorResource, Social/Services/PostPresenter and
// CommentController::present. The mock source emits the same JSON.

/// `ActorResource`.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class AuthorDto {
  AuthorDto({
    required this.id,
    this.type = 'user',
    this.name,
    this.handle,
    this.avatarUrl,
    this.isVerified = false,
  });

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);

  final String id;
  final String type;
  final String? name;
  final String? handle;
  final String? avatarUrl;
  final bool isVerified;

  PostAuthor toDomain() => PostAuthor(
    id: id,
    // New accounts have no display name yet.
    name: (name ?? '').isEmpty ? '@${handle ?? 'someone'}' : name!,
    handle: handle,
    avatarUrl: (avatarUrl ?? '').isEmpty ? null : avatarUrl,
    isVendor: type == 'vendor',
    isVerified: isVerified,
  );

  static const deleted = PostAuthor(id: '', name: 'Deleted account');
}

/// A post's photo or video: `Media::toPayload` (or the older `{ url }`).
class MediaDto {
  MediaDto(this.media);

  factory MediaDto.fromJson(Map<String, dynamic> json) =>
      MediaDto(Media.fromApi(json));

  final Media media;

  PostMedia toDomain() => PostMedia(
    url: media.stillUrl ?? '',
    width: media.width,
    height: media.height,
    blurhash: media.blurhash,
    isVideo: media.isVideo,
    media: media,
  );
}

/// `PostPresenter::present`.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostDto {
  PostDto({
    required this.id,
    required this.createdAt,
    this.author,
    this.event,
    this.caption,
    this.media = const [],
    this.counts = const {},
    this.myReaction,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  final String id;
  final AuthorDto? author;
  final Map<String, dynamic>? event;
  final String? caption;
  final List<MediaDto> media;
  final Map<String, int?> counts;
  final String? myReaction;
  final DateTime createdAt;

  FeedPost toDomain() => FeedPost(
    id: id,
    author: author?.toDomain() ?? AuthorDto.deleted,
    caption: caption ?? '',
    media: [for (final m in media) m.toDomain()],
    event: switch (event) {
      {'id': final String id, 'title': final String title} => PostEventRef(
        id: id,
        title: title,
      ),
      _ => null,
    },
    likeCount: counts['likes'] ?? 0,
    commentCount: counts['comments'] ?? 0,
    likedByMe: myReaction != null,
    createdAt: createdAt.toLocal(),
  );
}

/// `CommentController::present`.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class CommentDto {
  CommentDto({
    required this.id,
    required this.body,
    required this.createdAt,
    this.author,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  final String id;
  final AuthorDto? author;
  final String body;
  final DateTime createdAt;

  PostComment toDomain() => PostComment(
    id: id,
    author: author?.toDomain() ?? AuthorDto.deleted,
    body: body,
    createdAt: createdAt.toLocal(),
  );
}
