// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorDto _$AuthorDtoFromJson(Map<String, dynamic> json) => AuthorDto(
  id: json['id'] as String,
  type: json['type'] as String? ?? 'user',
  name: json['name'] as String?,
  handle: json['handle'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  isVerified: json['is_verified'] as bool? ?? false,
);

MediaDto _$MediaDtoFromJson(Map<String, dynamic> json) => MediaDto(
  url: json['url'] as String,
  type: json['type'] as String?,
  w: (json['w'] as num?)?.toInt(),
  h: (json['h'] as num?)?.toInt(),
  blurhash: json['blurhash'] as String?,
);

PostDto _$PostDtoFromJson(Map<String, dynamic> json) => PostDto(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  author: json['author'] == null
      ? null
      : AuthorDto.fromJson(json['author'] as Map<String, dynamic>),
  event: json['event'] as Map<String, dynamic>?,
  caption: json['caption'] as String?,
  media:
      (json['media'] as List<dynamic>?)
          ?.map((e) => MediaDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  counts:
      (json['counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num?)?.toInt()),
      ) ??
      const {},
  myReaction: json['my_reaction'] as String?,
);

CommentDto _$CommentDtoFromJson(Map<String, dynamic> json) => CommentDto(
  id: json['id'] as String,
  body: json['body'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  author: json['author'] == null
      ? null
      : AuthorDto.fromJson(json['author'] as Map<String, dynamic>),
);
