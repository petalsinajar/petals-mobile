import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/app.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';

import '../helpers/pump_app.dart';

Future<void> _pumpApp(WidgetTester tester) async {
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig(useMocks: true, apiBaseUrl: ''),
        ),
        appThemesProvider.overrideWithValue(testThemes),
      ],
      child: const App(),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _navLabel(String label) => find.descendant(
  of: find.byType(NavigationBar),
  matching: find.text(label),
);

void main() {
  testWidgets('starts on the user shell Feed', (tester) async {
    await _pumpApp(tester);

    expect(_navLabel('Feed'), findsOneWidget);
    expect(_navLabel('My Events'), findsOneWidget);
    expect(find.text('Your feed is warming up'), findsOneWidget);
  });

  testWidgets('switching to vendor mode swaps the shell, and back', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_navLabel('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Switch to vendor mode'));
    await tester.pumpAndSettle();

    expect(_navLabel('Inventory'), findsOneWidget);
    expect(_navLabel('Feed'), findsNothing);
    expect(find.text('All quiet for now'), findsOneWidget);

    await tester.tap(_navLabel('Business'));
    await tester.pumpAndSettle();
    expect(find.text('Royal Canopies & Chairs'), findsOneWidget);
    await tester.tap(find.text('Back to personal'));
    await tester.pumpAndSettle();

    expect(_navLabel('Feed'), findsOneWidget);
    expect(find.text('Your feed is warming up'), findsOneWidget);
  });
}
