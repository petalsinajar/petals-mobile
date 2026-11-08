import 'package:json_annotation/json_annotation.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

part 'event_dtos.g.dart';

// Shapes mirror the backend's resources (app/Modules/*/Http/Resources and
// Social/Services/PostPresenter); the mock source emits the same JSON.

/// `pending_vendor` → `pendingVendor`.
T _enumBySnake<T extends Enum>(List<T> values, String raw, T fallback) {
  final camel = raw.replaceAllMapped(
    RegExp('_([a-z])'),
    (m) => m[1]!.toUpperCase(),
  );
  return values.asNameMap()[camel] ?? fallback;
}

EventImage? _image(String? url, {int? width, int? height, String? blurhash}) =>
    url == null || url.isEmpty
    ? null
    : EventImage(url: url, width: width, height: height, blurhash: blurhash);

/// `ActorResource`: a user or vendor as embedded in other resources.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ActorDto {
  ActorDto({
    required this.id,
    this.type = 'user',
    this.name,
    this.handle,
    this.avatarUrl,
  });

  factory ActorDto.fromJson(Map<String, dynamic> json) =>
      _$ActorDtoFromJson(json);

  final String id;
  final String type;
  final String? name;
  final String? handle;
  final String? avatarUrl;

  EventPerson toDomain() => EventPerson(
    id: id,
    // New accounts have no display name yet.
    name: (name ?? '').isEmpty ? '@${handle ?? 'guest'}' : name!,
    handle: handle,
    avatar: _image(avatarUrl),
    isVendor: type == 'vendor',
  );
}

/// `EventResource`.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class EventDto {
  EventDto({
    required this.id,
    required this.type,
    required this.title,
    required this.startsAt,
    required this.endsAt,
    required this.venue,
    required this.visibility,
    required this.host,
    this.description,
    this.coverUrl,
    this.guestCount,
    this.counts = const {},
    this.myRsvp,
    this.isHost = false,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  final String id;
  final EventType type;
  final String title;
  final String? description;
  final String? coverUrl;
  final DateTime startsAt;
  final DateTime endsAt;
  final Map<String, dynamic> venue;
  final int? guestCount;
  final EventVisibility visibility;
  final ActorDto host;
  final Map<String, int?> counts;
  final RsvpStatus? myRsvp;
  final bool isHost;

  Event toDomain() => Event(
    id: id,
    type: type,
    title: title,
    description: description ?? '',
    startsAt: startsAt.toLocal(),
    endsAt: endsAt.toLocal(),
    venue: EventVenue(
      name: venue['name'] as String? ?? '',
      city: venue['city'] as String? ?? '',
      address: venue['address'] as String?,
    ),
    guestCount: guestCount ?? 0,
    visibility: visibility,
    cover: _image(coverUrl),
    hostId: host.id,
    rsvpCounts: RsvpCounts(
      going: counts['going'] ?? 0,
      maybe: counts['maybe'] ?? 0,
      declined: counts['declined'] ?? 0,
    ),
    viewerRole: isHost
        ? ViewerRole.host
        : myRsvp != null
        ? ViewerRole.guest
        : ViewerRole.none,
    viewerRsvp: myRsvp,
  );
}

/// `UserResource`, as embedded in a member row.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class MemberUserDto {
  MemberUserDto({
    required this.id,
    this.handle,
    this.displayName,
    this.avatarUrl,
  });

  factory MemberUserDto.fromJson(Map<String, dynamic> json) =>
      _$MemberUserDtoFromJson(json);

  final String id;
  final String? handle;
  final String? displayName;
  final String? avatarUrl;

  EventPerson toDomain() => ActorDto(
    id: id,
    name: displayName,
    handle: handle,
    avatarUrl: avatarUrl,
  ).toDomain();
}

/// `GET /v1/events/{id}/members` row. `role` is host, cohost or guest.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class MemberDto {
  MemberDto({required this.role, required this.rsvp, required this.user});

  factory MemberDto.fromJson(Map<String, dynamic> json) =>
      _$MemberDtoFromJson(json);

  final String role;
  final RsvpStatus rsvp;
  final MemberUserDto user;
}

/// The event page's header: the event plus its members, from two calls.
/// The server reports co-hosts as `is_host` too, so they get
/// [ViewerRole.host]; the app treats both the same.
EventDetail eventDetailFrom(EventDto event, List<MemberDto> members) {
  final coHosts = [
    for (final m in members)
      if (m.role == 'cohost') m.user,
  ];
  return EventDetail(
    event: event.toDomain().copyWith(
      coHostIds: [for (final u in coHosts) u.id],
    ),
    host: event.host.toDomain(),
    coHosts: [for (final u in coHosts) u.toDomain()],
    guests: [
      for (final m in members)
        if (m.role == 'guest')
          EventGuest(person: m.user.toDomain(), status: m.rsvp),
    ],
  );
}

/// One photo or video in a post: `{ url, type, w, h, blurhash }`.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostMediaDto {
  PostMediaDto({required this.url, this.w, this.h, this.blurhash});

  factory PostMediaDto.fromJson(Map<String, dynamic> json) =>
      _$PostMediaDtoFromJson(json);

  final String url;
  final int? w;
  final int? h;
  final String? blurhash;

  EventImage toDomain() =>
      EventImage(url: url, width: w, height: h, blurhash: blurhash);
}

/// `PostPresenter` output.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class EventPostDto {
  EventPostDto({
    required this.id,
    required this.createdAt,
    this.author,
    this.caption,
    this.media = const [],
    this.counts = const {},
  });

  factory EventPostDto.fromJson(Map<String, dynamic> json) =>
      _$EventPostDtoFromJson(json);

  final String id;
  final ActorDto? author;
  final String? caption;
  final List<PostMediaDto> media;
  final Map<String, int?> counts;
  final DateTime createdAt;

  EventPost toDomain() => EventPost(
    id: id,
    author:
        author?.toDomain() ??
        const EventPerson(id: '', name: 'Deleted account'),
    caption: caption ?? '',
    media: [for (final m in media) m.toDomain()],
    likeCount: counts['likes'] ?? 0,
    commentCount: counts['comments'] ?? 0,
    createdAt: createdAt.toLocal(),
  );
}

/// `BookingResource`, as the host sees it on their event.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class EventBookingDto {
  EventBookingDto({
    required this.id,
    required this.status,
    required this.window,
    required this.totals,
    this.vendor = const {},
    this.lines = const [],
  });

  factory EventBookingDto.fromJson(Map<String, dynamic> json) =>
      _$EventBookingDtoFromJson(json);

  final String id;
  final String status;
  final Map<String, dynamic> vendor;
  final Map<String, dynamic> window;
  final Map<String, dynamic> totals;
  final List<Map<String, dynamic>> lines;

  EventBooking toDomain() => EventBooking(
    id: id,
    vendor: ActorDto(
      id: vendor['id'] as String? ?? '',
      type: 'vendor',
      name: vendor['name'] as String?,
      handle: vendor['handle'] as String?,
      avatarUrl: vendor['logo_url'] as String?,
    ).toDomain(),
    status: _enumBySnake(
      BookingStatus.values,
      status,
      BookingStatus.pendingVendor,
    ),
    startsOn: DateTime.parse(window['start'] as String).toLocal(),
    endsOn: DateTime.parse(window['end'] as String).toLocal(),
    totalMinor: totals['total_minor'] as int? ?? 0,
    currency: totals['currency'] as String? ?? 'GHS',
    itemTitles: [for (final l in lines) l['title'] as String],
    itemQuantity: lines.fold(0, (sum, l) => sum + (l['qty'] as int? ?? 0)),
  );
}
