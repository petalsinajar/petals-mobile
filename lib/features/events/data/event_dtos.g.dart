// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorDto _$ActorDtoFromJson(Map<String, dynamic> json) => ActorDto(
  id: json['id'] as String,
  type: json['type'] as String? ?? 'user',
  name: json['name'] as String?,
  handle: json['handle'] as String?,
  avatarUrl: json['avatar_url'] as String?,
);

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
  id: json['id'] as String,
  type: $enumDecode(_$EventTypeEnumMap, json['type']),
  title: json['title'] as String,
  startsAt: DateTime.parse(json['starts_at'] as String),
  endsAt: DateTime.parse(json['ends_at'] as String),
  venue: json['venue'] as Map<String, dynamic>,
  visibility: $enumDecode(_$EventVisibilityEnumMap, json['visibility']),
  host: ActorDto.fromJson(json['host'] as Map<String, dynamic>),
  description: json['description'] as String?,
  coverUrl: json['cover_url'] as String?,
  guestCount: (json['guest_count'] as num?)?.toInt(),
  counts:
      (json['counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num?)?.toInt()),
      ) ??
      const {},
  myRsvp: $enumDecodeNullable(_$RsvpStatusEnumMap, json['my_rsvp']),
  isHost: json['is_host'] as bool? ?? false,
);

const _$EventTypeEnumMap = {
  EventType.wedding: 'wedding',
  EventType.birthday: 'birthday',
  EventType.corporate: 'corporate',
};

const _$EventVisibilityEnumMap = {
  EventVisibility.public: 'public',
  EventVisibility.guests: 'guests',
  EventVisibility.private: 'private',
};

const _$RsvpStatusEnumMap = {
  RsvpStatus.going: 'going',
  RsvpStatus.maybe: 'maybe',
  RsvpStatus.declined: 'declined',
  RsvpStatus.invited: 'invited',
};

MemberUserDto _$MemberUserDtoFromJson(Map<String, dynamic> json) =>
    MemberUserDto(
      id: json['id'] as String,
      handle: json['handle'] as String?,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

MemberDto _$MemberDtoFromJson(Map<String, dynamic> json) => MemberDto(
  role: json['role'] as String,
  rsvp: $enumDecode(_$RsvpStatusEnumMap, json['rsvp']),
  user: MemberUserDto.fromJson(json['user'] as Map<String, dynamic>),
);

PostMediaDto _$PostMediaDtoFromJson(Map<String, dynamic> json) => PostMediaDto(
  url: json['url'] as String,
  w: (json['w'] as num?)?.toInt(),
  h: (json['h'] as num?)?.toInt(),
  blurhash: json['blurhash'] as String?,
);

EventPostDto _$EventPostDtoFromJson(Map<String, dynamic> json) => EventPostDto(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  author: json['author'] == null
      ? null
      : ActorDto.fromJson(json['author'] as Map<String, dynamic>),
  caption: json['caption'] as String?,
  media:
      (json['media'] as List<dynamic>?)
          ?.map((e) => PostMediaDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  counts:
      (json['counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num?)?.toInt()),
      ) ??
      const {},
);

EventBookingDto _$EventBookingDtoFromJson(Map<String, dynamic> json) =>
    EventBookingDto(
      id: json['id'] as String,
      status: json['status'] as String,
      window: json['window'] as Map<String, dynamic>,
      totals: json['totals'] as Map<String, dynamic>,
      vendor: json['vendor'] as Map<String, dynamic>? ?? const {},
      lines:
          (json['lines'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
    );
