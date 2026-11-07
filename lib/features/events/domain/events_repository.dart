import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';

abstract interface class EventsRepository {
  /// Events the viewer hosts, co-hosts or is invited to.
  Future<List<Event>> myEvents();

  Future<EventDetail> detail(String eventId);

  /// Newest first, cursor-paginated.
  Future<Paginated<EventPost>> feed(String eventId, {String? cursor});

  /// Bookings and cart for the event. Hosts only.
  Future<EventPlan> plan(String eventId);

  Future<Event> create(EventDraft draft);

  /// Sets the viewer's RSVP and returns the refreshed detail.
  Future<EventDetail> rsvp(String eventId, RsvpStatus status);
}
