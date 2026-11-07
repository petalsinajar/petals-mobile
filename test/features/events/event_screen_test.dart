import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/features/events/data/events_mock_source.dart';
import 'package:petalsinajar/features/events/data/events_repository_impl.dart';
import 'package:petalsinajar/features/events/presentation/event_screen.dart';

import '../../helpers/pump_app.dart';

void main() {
  const ama = '01KK67BN00FWWT9PCC060FWN3G';
  const wedding = '01M4TS07R02ZWKXASREESTWEWT';
  const efuaBirthday = '01M0X4PAW05D2XVWAAXV4R2F88';

  Future<void> pumpEvent(WidgetTester tester, String id) async {
    // A phone-sized viewport (360 px wide) catches overflows.
    tester.view
      ..physicalSize = const Size(360, 2400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final repo = EventsRepositoryImpl(
      EventsMockSource(
        seed: SeedLoader(),
        delay: MockDelay.none(),
        viewerId: ama,
      ),
    );
    await tester.runAsync(() => repo.detail(id)); // warm the seed cache
    await tester.pumpApp(
      EventScreen(eventId: id),
      overrides: [eventsRepositoryProvider.overrideWithValue(repo)],
    );
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pump();
    }
  }

  testWidgets('hosts see the guest list and Plan & rent', (tester) async {
    await pumpEvent(tester, wedding);

    expect(find.text("Ama & Kojo's White Wedding"), findsOneWidget);
    expect(find.text('Ama Mensah & Kojo Addo'), findsOneWidget);
    expect(find.text('Guest list'), findsOneWidget);
    expect(find.text('Plan & rent'), findsOneWidget);
    expect(find.text('Awaiting vendor'), findsOneWidget);
    expect(find.text('Browse rentals'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('guests can RSVP and see no plan', (tester) async {
    await pumpEvent(tester, efuaBirthday);

    expect(find.text('Are you going?'), findsOneWidget);
    expect(find.text('Plan & rent'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
