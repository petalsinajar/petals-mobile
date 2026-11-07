import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:petalsinajar/features/events/domain/my_events.dart';

void main() {
  final now = DateTime.utc(2030, 6, 15, 12);

  Event event({
    required Duration startsIn,
    ViewerRole role = ViewerRole.guest,
    RsvpStatus? rsvp = RsvpStatus.going,
    String id = 'e1',
  }) {
    final starts = now.add(startsIn);
    return Event(
      id: id,
      type: EventType.birthday,
      title: 'Party',
      startsAt: starts,
      endsAt: starts.add(const Duration(hours: 4)),
      venue: const EventVenue(name: 'Home', city: 'Accra'),
      guestCount: 10,
      visibility: EventVisibility.guests,
      hostId: 'h1',
      createdAt: DateTime.utc(2030),
      viewerRole: role,
      viewerRsvp: role == ViewerRole.guest ? rsvp : null,
    );
  }

  const soon = Duration(days: 3);
  const ago = Duration(days: -3);

  MyEventsBucket? bucket(Event e) => bucketOf(e, now);

  test('hosting is planning until it ends, then past', () {
    expect(
      bucket(event(startsIn: soon, role: ViewerRole.host)),
      MyEventsBucket.planning,
    );
    expect(
      bucket(event(startsIn: soon, role: ViewerRole.coHost)),
      MyEventsBucket.planning,
    );
    expect(
      bucket(event(startsIn: ago, role: ViewerRole.host)),
      MyEventsBucket.past,
    );
  });

  test('guests see future events they have not declined', () {
    for (final rsvp in [
      RsvpStatus.going,
      RsvpStatus.maybe,
      RsvpStatus.invited,
    ]) {
      expect(
        bucket(event(startsIn: soon, rsvp: rsvp)),
        MyEventsBucket.upcoming,
      );
    }
    expect(bucket(event(startsIn: soon, rsvp: RsvpStatus.declined)), isNull);
  });

  test('an event in progress is still upcoming', () {
    expect(
      bucket(event(startsIn: const Duration(hours: -1))),
      MyEventsBucket.upcoming,
    );
  });

  test('past keeps attended events only', () {
    expect(bucket(event(startsIn: ago)), MyEventsBucket.past);
    expect(
      bucket(event(startsIn: ago, rsvp: RsvpStatus.maybe)),
      MyEventsBucket.past,
    );
    expect(bucket(event(startsIn: ago, rsvp: RsvpStatus.invited)), isNull);
    expect(bucket(event(startsIn: ago, rsvp: RsvpStatus.declined)), isNull);
  });

  test('unrelated events are hidden', () {
    expect(bucket(event(startsIn: soon, role: ViewerRole.none)), isNull);
  });

  test('groups sort soonest first, past most recent first', () {
    final groups = groupMyEvents([
      event(id: 'later', startsIn: const Duration(days: 9)),
      event(id: 'sooner', startsIn: soon),
      event(id: 'old', startsIn: const Duration(days: -30)),
      event(id: 'recent', startsIn: ago),
    ], now);

    expect(groups[MyEventsBucket.upcoming]!.map((e) => e.id), [
      'sooner',
      'later',
    ]);
    expect(groups[MyEventsBucket.past]!.map((e) => e.id), ['recent', 'old']);
    expect(groups[MyEventsBucket.planning], isEmpty);
  });
}
