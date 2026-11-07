import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/app.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';
import 'package:petalsinajar/features/auth/data/auth_mock_source.dart';
import 'package:petalsinajar/features/auth/data/device_name.dart';

import '../helpers/pump_app.dart';

Future<void> _pumpApp(WidgetTester tester, {bool signedIn = false}) async {
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

  // Asset reads are real I/O, which never completes in the fake-async zone;
  // warm the seed cache outside it so the auth mock answers.
  final seed = SeedLoader();
  await tester.runAsync(
    () => Future.wait([seed.load('users'), seed.load('vendors')]),
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        seedLoaderProvider.overrideWithValue(seed),
        mockDelayProvider.overrideWithValue(MockDelay.none()),
        appConfigProvider.overrideWithValue(
          AppConfig(useMocks: true, apiBaseUrl: ''),
        ),
        appThemesProvider.overrideWithValue(testThemes),
        tokenStorageProvider.overrideWithValue(
          InMemoryTokenStorage(
            signedIn ? const AuthTokens(access: 'a', refresh: 'r') : null,
          ),
        ),
        deviceNameProvider.overrideWith((_) async => 'test device'),
      ],
      child: const App(),
    ),
  );
  await _pumpFrames(tester);
  await tester.pumpAndSettle();
}

/// Lets futures over the warmed seed (completed outside the fake-async zone)
/// land, then pumps. Also stands in for `pumpAndSettle` on the code screen,
/// whose blinking cursor never lets it finish.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump(const Duration(milliseconds: 100));
  }
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

  testWidgets('signed out, account tabs ask to sign in; the code signs in '
      'and continues to the tab; signing out returns to sign in', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_navLabel('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in to Petalsinajar'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '024 000 0001');
    await tester.tap(find.text('Send code'));
    await _pumpFrames(tester);
    expect(
      find.text('We texted a 6-digit code to +233240000001.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(EditableText), '000000');
    await _pumpFrames(tester);
    expect(find.text('That code is not correct.'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), AuthMockSource.devCode);
    await _pumpFrames(tester);
    await tester.pumpAndSettle();
    expect(find.text('Ama Mensah'), findsOneWidget);
    expect(_navLabel('Profile'), findsOneWidget);

    await tester.tap(find.byTooltip('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in to Petalsinajar'), findsOneWidget);
  });

  testWidgets('switching to vendor mode swaps the shell, and back', (
    tester,
  ) async {
    await _pumpApp(tester, signedIn: true);

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
