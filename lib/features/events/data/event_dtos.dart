import 'package:json_annotation/json_annotation.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

part 'event_dtos.g.dart';

/// `co_host` → `coHost`, `pending_vendor` → `pendingVendor`.
T _enumBySnake<T extends Enum>(List<T> values, String raw, T fallback) {
  final camel = raw.replaceAllMapped(
    RegExp('_([a-z])'),
    (m) => m[1]!.toUpperCase(),
  );
  return values.asNameMap()[camel] ?? fallback;
}

/// `coHost` → `co_host`, for request bodies.
String enumToSnake(Enum value) => value.name.replaceAllMapped(
  RegExp('[A-Z]'),
  (m) => '_${m[0]!.toLowerCase()}',
);

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ImageDto {
  ImageDto({required this.url, this.blurhash, this.width, this.height});

  factory ImageDto.fromJson(Map<String, dynamic> json) =>
      _$ImageDtoFromJson(json);

  final String url;
  final String? blurhash;
  final int? width;
  final int? height;

  EventImage toDomain() =>
      EventImage(url: url, blurhash: blurhash, width: width, height: height);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PersonDto {
  PersonDto({
    required this.id,
    required this.name,
    this.handle,
    this.avatar,
    this.isVendor = false,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);

  final String id;
  final String name;
  final String? handle;
  final ImageDto? avatar;
  final bool isVendor;

  EventPerson toDomain() => EventPerson(
    id: id,
    name: name,
    handle: handle,
    avatar: avatar?.toDomain(),
    isVendor: isVendor,
  );
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class EventDto {
  EventDto({
    required this.id,
    required this.type,
    required this.title,
    required this.startsAt,
    required this.venue,
    required this.guestCount,
    required this.visibility,
    required this.hostId,
    required this.createdAt,
    this.description = '',
    this.endsAt,
    this.cover,
    this.coHostIds = const [],
    this.rsvpCounts = const {},
    this.viewerRole,
    this.viewerRsvp,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  final String id;
  final EventType type;
  final String title;
  final String description;
  final DateTime startsAt;
  final DateTime? endsAt;
  final Map<String, dynamic> venue;
  final int guestCount;
  final EventVisibility visibility;
  final ImageDto? cover;
  final String hostId;
  final List<String> coHostIds;
  final Map<String, int> rsvpCounts;
  final String? viewerRole;
  final RsvpStatus? viewerRsvp;
  final DateTime createdAt;

  Event toDomain() => Event(
    id: id,
    type: type,
    title: title,
    description: description,
    startsAt: startsAt,
    endsAt: endsAt,
    venue: EventVenue(
      name: venue['name'] as String,
      city: venue['city'] as String? ?? '',
      address: venue['address'] as String?,
    ),
    guestCount: guestCount,
    visibility: visibility,
    cover: cover?.toDomain(),
    hostId: hostId,
    coHostIds: coHostIds,
    rsvpCounts: RsvpCounts(
      going: rsvpCounts['going'] ?? 0,
      maybe: rsvpCounts['maybe'] ?? 0,
      declined: rsvpCounts['declined'] ?? 0,
      invited: rsvpCounts['invited'] ?? 0,
    ),
    viewerRole: viewerRole == null
        ? ViewerRole.none
        : _enumBySnake(ViewerRole.values, viewerRole!, ViewerRole.none),
    viewerRsvp: viewerRsvp,
    createdAt: createdAt,
  );
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GuestDto {
  GuestDto({required this.user, required this.status});

  factory GuestDto.fromJson(Map<String, dynamic> json) =>
      _$GuestDtoFromJson(json);

  final PersonDto user;
  final RsvpStatus status;
}

/// `GET /v1/events/{id}`: the event resource plus embedded people.
class EventDetailDto {
  EventDetailDto.fromJson(Map<String, dynamic> json)
    : event = EventDto.fromJson(json),
      host = PersonDto.fromJson(json['host'] as Map<String, dynamic>),
      coHosts = [
        for (final p in json['co_hosts'] as List? ?? const [])
          PersonDto.fromJson(p as Map<String, dynamic>),
      ],
      guests = [
        for (final g in json['guests'] as List? ?? const [])
          GuestDto.fromJson(g as Map<String, dynamic>),
      ];

  final EventDto event;
  final PersonDto host;
  final List<PersonDto> coHosts;
  final List<GuestDto> guests;

  EventDetail toDomain() => EventDetail(
    event: event.toDomain(),
    host: host.toDomain(),
    coHosts: [for (final p in coHosts) p.toDomain()],
    guests: [
      for (final g in guests)
        EventGuest(person: g.user.toDomain(), status: g.status),
    ],
  );
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class EventPostDto {
  EventPostDto({
    required this.id,
    required this.author,
    required this.createdAt,
    this.caption = '',
    this.media = const [],
    this.likeCount = 0,
    this.commentCount = 0,
  });

  factory EventPostDto.fromJson(Map<String, dynamic> json) =>
      _$EventPostDtoFromJson(json);

  final String id;
  final PersonDto author;
  final String caption;
  final List<ImageDto> media;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;

  EventPost toDomain() => EventPost(
    id: id,
    author: author.toDomain(),
    caption: caption,
    media: [for (final m in media) m.toDomain()],
    likeCount: likeCount,
    commentCount: commentCount,
    createdAt: createdAt,
  );
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class EventBookingDto {
  EventBookingDto({
    required this.id,
    required this.vendor,
    required this.status,
    required this.startsOn,
    required this.endsOn,
    required this.totalMinor,
    required this.currency,
    this.lines = const [],
  });

  factory EventBookingDto.fromJson(Map<String, dynamic> json) =>
      _$EventBookingDtoFromJson(json);

  final String id;
  final PersonDto vendor;
  final String status;
  final DateTime startsOn;
  final DateTime endsOn;
  final int totalMinor;
  final String currency;
  final List<Map<String, dynamic>> lines;

  EventBooking toDomain() => EventBooking(
    id: id,
    vendor: vendor.toDomain(),
    status: _enumBySnake(
      BookingStatus.values,
      status,
      BookingStatus.pendingVendor,
    ),
    startsOn: startsOn,
    endsOn: endsOn,
    totalMinor: totalMinor,
    currency: currency,
    itemTitles: [for (final l in lines) l['title'] as String],
    itemQuantity: lines.fold(0, (sum, l) => sum + (l['quantity'] as int)),
  );
}

/// `GET /v1/events/{id}/plan`: `{ bookings: [...], cart: { lines, currency } }`.
class EventPlanDto {
  EventPlanDto.fromJson(Map<String, dynamic> json)
    : bookings = [
        for (final b in json['bookings'] as List? ?? const [])
          EventBookingDto.fromJson(b as Map<String, dynamic>),
      ],
      cart = json['cart'] as Map<String, dynamic>? ?? const {};

  final List<EventBookingDto> bookings;
  final Map<String, dynamic> cart;

  EventPlan toDomain() {
    final currency = cart['currency'] as String? ?? 'GHS';
    return EventPlan(
      bookings: [for (final b in bookings) b.toDomain()],
      cart: [
        for (final l
            in (cart['lines'] as List? ?? const [])
                .cast<Map<String, dynamic>>())
          EventCartLine(
            itemId: l['item_id'] as String,
            title: l['title'] as String,
            vendorName: l['vendor_name'] as String,
            quantity: l['quantity'] as int,
            lineTotalMinor: l['line_total_minor'] as int,
            currency: currency,
          ),
      ],
    );
  }
}
