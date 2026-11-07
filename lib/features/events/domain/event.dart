import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

part 'event.freezed.dart';

/// Who can see the event: anyone, invited guests, or only hosts.
enum EventVisibility { public, guests, private }

/// A guest's answer. `invited` means they haven't answered yet.
enum RsvpStatus { going, maybe, declined, invited }

/// How the signed-in user relates to an event. Computed by the server.
enum ViewerRole { host, coHost, guest, none }

/// A remote (or, right after creating, local `file://`) image with its
/// blurhash placeholder.
@freezed
abstract class EventImage with _$EventImage {
  const factory EventImage({
    required String url,
    String? blurhash,
    int? width,
    int? height,
  }) = _EventImage;
}

@freezed
abstract class EventVenue with _$EventVenue {
  const factory EventVenue({
    required String name,
    required String city,
    String? address,
  }) = _EventVenue;
}

@freezed
abstract class RsvpCounts with _$RsvpCounts {
  const factory RsvpCounts({
    @Default(0) int going,
    @Default(0) int maybe,
    @Default(0) int declined,
    @Default(0) int invited,
  }) = _RsvpCounts;

  const RsvpCounts._();

  int of(RsvpStatus status) => switch (status) {
    RsvpStatus.going => going,
    RsvpStatus.maybe => maybe,
    RsvpStatus.declined => declined,
    RsvpStatus.invited => invited,
  };

  /// Moves one guest from [from] (if any) to [to].
  RsvpCounts move({required RsvpStatus? from, required RsvpStatus to}) {
    int delta(RsvpStatus s) => (s == to ? 1 : 0) - (s == from ? 1 : 0);
    return RsvpCounts(
      going: going + delta(RsvpStatus.going),
      maybe: maybe + delta(RsvpStatus.maybe),
      declined: declined + delta(RsvpStatus.declined),
      invited: invited + delta(RsvpStatus.invited),
    );
  }
}

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required EventType type,
    required String title,
    required DateTime startsAt,
    required EventVenue venue,
    required int guestCount,
    required EventVisibility visibility,
    required String hostId,
    required DateTime createdAt,
    @Default('') String description,
    DateTime? endsAt,
    EventImage? cover,
    @Default(<String>[]) List<String> coHostIds,
    @Default(RsvpCounts()) RsvpCounts rsvpCounts,
    @Default(ViewerRole.none) ViewerRole viewerRole,
    RsvpStatus? viewerRsvp,
  }) = _Event;

  const Event._();

  /// Events without an end are treated as lasting six hours.
  DateTime get effectiveEndsAt =>
      endsAt ?? startsAt.add(const Duration(hours: 6));

  bool get viewerIsHosting =>
      viewerRole == ViewerRole.host || viewerRole == ViewerRole.coHost;
}
