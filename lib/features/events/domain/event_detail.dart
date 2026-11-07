import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/features/events/domain/event.dart';

part 'event_detail.freezed.dart';

/// A person or business as embedded in event responses (host, guest, author).
@freezed
abstract class EventPerson with _$EventPerson {
  const factory EventPerson({
    required String id,
    required String name,
    String? handle,
    EventImage? avatar,
    @Default(false) bool isVendor,
  }) = _EventPerson;
}

@freezed
abstract class EventGuest with _$EventGuest {
  const factory EventGuest({
    required EventPerson person,
    required RsvpStatus status,
  }) = _EventGuest;
}

/// Everything the event page header needs: the event, its hosts and a
/// preview of the guest list (for avatar stacks — counts live on [Event]).
@freezed
abstract class EventDetail with _$EventDetail {
  const factory EventDetail({
    required Event event,
    required EventPerson host,
    @Default(<EventPerson>[]) List<EventPerson> coHosts,
    @Default(<EventGuest>[]) List<EventGuest> guests,
  }) = _EventDetail;

  const EventDetail._();

  List<EventPerson> guestsWith(RsvpStatus status) => [
    for (final g in guests)
      if (g.status == status) g.person,
  ];
}

/// A post shared to the event's feed.
@freezed
abstract class EventPost with _$EventPost {
  const factory EventPost({
    required String id,
    required EventPerson author,
    required DateTime createdAt,
    @Default('') String caption,
    @Default(<EventImage>[]) List<EventImage> media,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
  }) = _EventPost;
}
