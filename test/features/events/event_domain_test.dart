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

  group("parses the backend's EventResource", () {
    Map<String, dynamic> resource({
      bool isHost = false,
      String? myRsvp,
      String? coverUrl,
    }) => {
      'id': 'e1',
      'type': 'corporate',
      'title': 'Launch',
      'slug': 'launch-x1y2z3',
      'description': null,
      'cover_url': coverUrl,
      'starts_at': '2030-01-01T10:00:00+00:00',
      'ends_at': '2030-01-01T15:00:00+00:00',
      'timezone': 'Africa/Accra',
      'venue': {
        'name': 'Kempinski',
        'address': null,
        'city': 'Accra',
        'lat': null,
        'lng': null,
      },
      'guest_count': null,
      'currency': 'GHS',
      'visibility': 'public',
      'theme': <String, dynamic>{},
      'status': 'planning',
      'host': {
        'type': 'user',
        'id': 'u1',
        'handle': 'user4567',
        'name': '',
        'avatar_url': null,
        'is_verified': false,
      },
      'counts': {
        'going': 3,
        'maybe': 2,
        'declined': 1,
        'posts': 0,
        'bookings': 0,
      },
      'my_rsvp': ?myRsvp,
      'is_host': isHost,
    };

    test('fields, counts and defaults for nulls', () {
      final e = EventDto.fromJson(resource()).toDomain();

      expect(e.venue, const EventVenue(name: 'Kempinski', city: 'Accra'));
      expect(e.rsvpCounts, const RsvpCounts(going: 3, maybe: 2, declined: 1));
      expect(e.hostId, 'u1');
      expect(e.description, isEmpty);
      expect(e.guestCount, 0);
      expect(e.cover, isNull);
      expect(e.endsAt!.isAtSameMomentAs(DateTime.utc(2030, 1, 1, 15)), isTrue);
      expect(e.endsAt!.isUtc, isFalse, reason: 'shown in local time');
    });

    test('the viewer role comes from is_host and my_rsvp', () {
      ViewerRole role(Map<String, dynamic> json) =>
          EventDto.fromJson(json).toDomain().viewerRole;

      expect(role(resource(isHost: true, myRsvp: 'going')), ViewerRole.host);
      expect(role(resource(myRsvp: 'maybe')), ViewerRole.guest);
      expect(role(resource()), ViewerRole.none);
    });

    test('a host without a name yet shows as their @handle', () {
      final dto = EventDto.fromJson(resource());
      expect(dto.host.toDomain().name, '@user4567');
    });

    test('cover_url becomes the cover image', () {
      final e = EventDto.fromJson(
        resource(coverUrl: 'https://petalsinajar.com/storage/uploads/a.jpg'),
      ).toDomain();
      expect(e.cover?.url, 'https://petalsinajar.com/storage/uploads/a.jpg');
    });
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
