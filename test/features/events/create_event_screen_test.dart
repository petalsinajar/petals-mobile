import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/features/events/presentation/create/create_event_screen.dart';

import '../../helpers/pump_app.dart';

void main() {
  FilledButton next(WidgetTester tester) => tester.widget<FilledButton>(
    find.ancestor(of: find.text('Next'), matching: find.byType(FilledButton)),
  );

  testWidgets('Next unlocks only once the step is answered', (tester) async {
    await tester.pumpApp(const CreateEventScreen());

    expect(find.text('What are you celebrating?'), findsOneWidget);
    expect(find.text('New event · 1 of 7'), findsOneWidget);
    expect(next(tester).onPressed, isNull);

    await tester.tap(find.text('Wedding'));
    await tester.pump();
    expect(next(tester).onPressed, isNotNull);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Give it a name'), findsOneWidget);
    expect(next(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField), "Ama & Kojo's day");
    await tester.pump();
    expect(next(tester).onPressed, isNotNull);
  });
}
