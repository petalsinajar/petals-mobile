import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/features/events/data/event_dtos.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:petalsinajar/features/events/presentation/widgets/countdown.dart';

void main() {
  group('RsvpCounts.move', () {
    const counts = RsvpCounts(going: 5, maybe: 2, declined: 1, invited: 3);

    test('answering an invite', () {
      expect(
        counts.move(from: RsvpStatus.invited, to: RsvpStatus.going),
        const RsvpCounts(going: 6, maybe: 2, declined: 1, invited: 2),
      );
    });

    test('a first answer only adds', () {
      expect(counts.move(from: null, to: RsvpStatus.maybe).maybe, 3);
    });
  });

  group('EventDraft.isStepValid', () {
    final start = DateTime(2030, 6, 1, 14);

    test('requires a type and a real title', () {
      const empty = EventDraft();
      expect(empty.isStepValid(EventDraftStep.type), isFalse);
      expect(empty.isStepValid(EventDraftStep.title), isFalse);
      expect(
        const EventDraft(title: '  ab ').isStepValid(EventDraftStep.title),
        isFalse,
      );
      expect(
        const EventDraft(
          type: EventType.wedding,
          title: 'Our day',
        ).isStepValid(EventDraftStep.title),
        isTrue,
      );
    });

    test('ends must come after starts', () {
      expect(
        EventDraft(startsAt: start).isStepValid(EventDraftStep.dateTime),
        isTrue,
      );
      expect(
        EventDraft(
          startsAt: start,
          endsAt: start.subtract(const Duration(hours: 1)),
        ).isStepValid(EventDraftStep.dateTime),
        isFalse,
      );
    });

    test('venue needs a name and a city; cover is optional', () {
      const venue = EventDraft(venueName: 'Labadi Beach Hotel');
      expect(venue.isStepValid(EventDraftStep.venue), isFalse);
      expect(
        venue.copyWith(venueCity: 'Accra').isStepValid(EventDraftStep.venue),
        isTrue,
      );
      expect(venue.isStepValid(EventDraftStep.cover), isTrue);
    });
  });

  test('snake_case enums round-trip', () {
    expect(enumToSnake(ViewerRole.coHost), 'co_host');
    final dto = EventDto.fromJson({
      'id': 'e1',
      'type': 'corporate',
      'title': 'Launch',
      'starts_at': '2030-01-01T10:00:00Z',
      'venue': {'name': 'Kempinski', 'city': 'Accra'},
      'guest_count': 100,
      'visibility': 'public',
      'host_id': 'u1',
      'created_at': '2029-12-01T10:00:00Z',
      'viewer_role': 'co_host',
    });
    expect(dto.toDomain().viewerRole, ViewerRole.coHost);
  });

  group('CountdownState', () {
    final event = Event(
      id: 'e1',
      type: EventType.birthday,
      title: 'Party',
      startsAt: DateTime.utc(2030, 1, 10, 18),
      endsAt: DateTime.utc(2030, 1, 10, 23),
      venue: const EventVenue(name: 'Home', city: 'Accra'),
      guestCount: 10,
      visibility: EventVisibility.guests,
      hostId: 'u1',
      createdAt: DateTime.utc(2029),
    );

    test('ticks down in days, hours, minutes, seconds', () {
      final state = CountdownState.of(event, DateTime.utc(2030, 1, 8, 15, 30));
      expect(state, isA<CountdownTicking>());
      final t = state as CountdownTicking;
      expect((t.days, t.hours, t.minutes, t.seconds), (2, 2, 30, 0));
    });

    test('is live during the event and ended after', () {
      expect(
        CountdownState.of(event, DateTime.utc(2030, 1, 10, 20)),
        isA<CountdownLive>(),
      );
      expect(
        CountdownState.of(event, DateTime.utc(2030, 1, 11)),
        isA<CountdownEnded>(),
      );
    });
  });
}
