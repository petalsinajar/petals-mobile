import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:petalsinajar/features/events/presentation/widgets/event_card.dart';
import 'package:petalsinajar/features/events/presentation/widgets/rsvp_section.dart';

import '../../helpers/pump_app.dart';

Event _event({ViewerRole role = ViewerRole.guest, RsvpStatus? rsvp}) => Event(
  id: 'e1',
  type: EventType.birthday,
  title: 'Efua turns 30',
  startsAt: DateTime.utc(2030, 10, 24, 19),
  venue: const EventVenue(name: 'Sandbox Beach Club', city: 'Accra'),
  guestCount: 80,
  visibility: EventVisibility.public,
  hostId: 'h1',
  createdAt: DateTime.utc(2030),
  rsvpCounts: const RsvpCounts(going: 31, maybe: 11, declined: 1),
  viewerRole: role,
  viewerRsvp: rsvp,
);

EventDetail _detail(Event event) => EventDetail(
  event: event,
  host: const EventPerson(id: 'h1', name: 'Efua Owusu'),
  guests: const [
    EventGuest(
      person: EventPerson(id: 'g1', name: 'Kofi Asante'),
      status: RsvpStatus.going,
    ),
  ],
);

void main() {
  testWidgets('event card is tinted with the event type accent', (
    tester,
  ) async {
    await tester.pumpApp(
      SingleChildScrollView(
        child: EventCard(
          event: _event(rsvp: RsvpStatus.going),
          onTap: () {},
        ),
      ),
    );

    final card = tester.widget<Card>(find.byType(Card));
    final palette = tester.element(find.byType(Card)).palette;
    expect(card.color, palette.accentFor(EventType.birthday).container);
    expect(find.text('Birthday'), findsOneWidget);
    expect(find.text('Going'), findsOneWidget);
  });

  testWidgets('guests can tap an RSVP chip', (tester) async {
    RsvpStatus? picked;
    await tester.pumpApp(
      RsvpSection(
        detail: _detail(_event(rsvp: RsvpStatus.invited)),
        onRsvp: (s) => picked = s,
      ),
    );

    expect(find.text('Are you going?'), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
    await tester.tap(find.text('Maybe'));
    expect(picked, RsvpStatus.maybe);
  });

  testWidgets('hosts see the tally but cannot answer', (tester) async {
    RsvpStatus? picked;
    await tester.pumpApp(
      RsvpSection(
        detail: _detail(_event(role: ViewerRole.host)),
        onRsvp: (s) => picked = s,
      ),
    );

    expect(find.text('Guest list'), findsOneWidget);
    await tester.tap(find.text('Going'));
    expect(picked, isNull);
  });
}
