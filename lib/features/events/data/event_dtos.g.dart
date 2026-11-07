// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDto _$ImageDtoFromJson(Map<String, dynamic> json) => ImageDto(
  url: json['url'] as String,
  blurhash: json['blurhash'] as String?,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) => PersonDto(
  id: json['id'] as String,
  name: json['name'] as String,
  handle: json['handle'] as String?,
  avatar: json['avatar'] == null
      ? null
      : ImageDto.fromJson(json['avatar'] as Map<String, dynamic>),
  isVendor: json['is_vendor'] as bool? ?? false,
);

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
  id: json['id'] as String,
  type: $enumDecode(_$EventTypeEnumMap, json['type']),
  title: json['title'] as String,
  startsAt: DateTime.parse(json['starts_at'] as String),
  venue: json['venue'] as Map<String, dynamic>,
  guestCount: (json['guest_count'] as num).toInt(),
  visibility: $enumDecode(_$EventVisibilityEnumMap, json['visibility']),
  hostId: json['host_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  description: json['description'] as String? ?? '',
  endsAt: json['ends_at'] == null
      ? null
      : DateTime.parse(json['ends_at'] as String),
  cover: json['cover'] == null
      ? null
      : ImageDto.fromJson(json['cover'] as Map<String, dynamic>),
  coHostIds:
      (json['co_host_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  rsvpCounts:
      (json['rsvp_counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  viewerRole: json['viewer_role'] as String?,
  viewerRsvp: $enumDecodeNullable(_$RsvpStatusEnumMap, json['viewer_rsvp']),
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

GuestDto _$GuestDtoFromJson(Map<String, dynamic> json) => GuestDto(
  user: PersonDto.fromJson(json['user'] as Map<String, dynamic>),
  status: $enumDecode(_$RsvpStatusEnumMap, json['status']),
);

EventPostDto _$EventPostDtoFromJson(Map<String, dynamic> json) => EventPostDto(
  id: json['id'] as String,
  author: PersonDto.fromJson(json['author'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['created_at'] as String),
  caption: json['caption'] as String? ?? '',
  media:
      (json['media'] as List<dynamic>?)
          ?.map((e) => ImageDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
);

EventBookingDto _$EventBookingDtoFromJson(Map<String, dynamic> json) =>
    EventBookingDto(
      id: json['id'] as String,
      vendor: PersonDto.fromJson(json['vendor'] as Map<String, dynamic>),
      status: json['status'] as String,
      startsOn: DateTime.parse(json['starts_on'] as String),
      endsOn: DateTime.parse(json['ends_on'] as String),
      totalMinor: (json['total_minor'] as num).toInt(),
      currency: json['currency'] as String,
      lines:
          (json['lines'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
    );
