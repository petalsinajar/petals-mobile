import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/app.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/core/notifications/onesignal_service.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';
import 'package:petalsinajar/features/auth/data/auth_mock_source.dart';
import 'package:petalsinajar/features/auth/data/device_name.dart';
import 'package:petalsinajar/features/feed/data/feed_repository_impl.dart';
import 'package:petalsinajar/features/feed/domain/feed_repository.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';
import 'package:petalsinajar/features/profile/presentation/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/pump_app.dart';

/// These tests cover the shell, sign-in and vendor mode, not the feed
/// (see test/features/feed): keep the home tab empty and image-free.
class _EmptyFeed implements FeedRepository {
  @override
  Future<Paginated<FeedPost>> feed(FeedKind kind, {String? cursor}) async =>
      const Paginated.empty();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// No native OneSignal under test: a device that never registers and gets
/// no taps, so push stays out of these tests (see test/app/push).
class _NoPush implements OneSignalService {
  @override
  String? get pushSubscriptionId => null;

  @override
  PushWatch watchPushSubscriptionId(void Function(String?) _) =>
      PushWatch(() {});

  @override
  PushWatch watchNotificationTaps(void Function(String?) _) => PushWatch(() {});

  @override
  Future<void> login(String externalId) async {}

  @override
  Future<void> logout() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// The Feed tab's empty state, which the app opens on.
const _emptyFeed = 'Nothing here yet';

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
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
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
        feedRepositoryProvider.overrideWithValue(_EmptyFeed()),
        oneSignalServiceProvider.overrideWithValue(_NoPush()),
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

int _selectedTab(WidgetTester tester) =>
    tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex;

/// Records platform calls, so a test can see `SystemNavigator.pop` (the
/// app closing) without it actually happening.
List<String> _recordPlatformCalls(WidgetTester tester) {
  final calls = <String>[];
  final messenger = tester.binding.defaultBinaryMessenger
    ..setMockMethodCallHandler(SystemChannels.platform, (call) async {
      calls.add(call.method);
      return null;
    });
  addTearDown(
    () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
  );
  return calls;
}

void main() {
  testWidgets('starts on the user shell Feed', (tester) async {
    await _pumpApp(tester);

    expect(_navLabel('Feed'), findsOneWidget);
    expect(_navLabel('My Events'), findsOneWidget);
    expect(find.text(_emptyFeed), findsOneWidget);
  });

  testWidgets('demo data is marked with a DEMO ribbon', (tester) async {
    await _pumpApp(tester); // useMocks: true

    final ribbon = tester.widget<Banner>(find.byType(Banner));
    expect(ribbon.message, 'DEMO');
  });

  testWidgets('back goes to the first tab, and only there closes the app', (
    tester,
  ) async {
    await _pumpApp(tester);
    final platformCalls = _recordPlatformCalls(tester);

    await tester.tap(_navLabel('Discover'));
    await tester.pumpAndSettle();
    expect(_selectedTab(tester), 1);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(_selectedTab(tester), 0);
    expect(platformCalls, isNot(contains('SystemNavigator.pop')));

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(platformCalls, contains('SystemNavigator.pop'));
  });

  testWidgets('in vendor mode, back goes to Today first', (tester) async {
    await _pumpApp(tester, signedIn: true);
    final platformCalls = _recordPlatformCalls(tester);

    await tester.tap(_navLabel('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Switch to business'));
    await tester.pumpAndSettle();
    await tester.tap(_navLabel('Business'));
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(_navLabel('Today'), findsOneWidget);
    expect(_selectedTab(tester), 0);
    expect(platformCalls, isNot(contains('SystemNavigator.pop')));
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

    // Sign out sits at the bottom of the profile menu: scroll to the end.
    await tester.drag(
      find.descendant(
        of: find.byType(ProfileScreen),
        matching: find.byType(ListView),
      ),
      const Offset(0, -2000),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    // Confirm in the dialog.
    await tester.tap(find.widgetWithText(TextButton, 'Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in to Petalsinajar'), findsOneWidget);
  });

  testWidgets('a new number picks a name, then continues to the tab', (
    tester,
  ) async {
    await _pumpApp(tester);

    // Profile, not My Events: event covers need an image cache directory,
    // which doesn't exist under test.
    await tester.tap(_navLabel('Profile'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '024 123 4567');
    await tester.tap(find.text('Send code'));
    await _pumpFrames(tester);
    await tester.enterText(find.byType(EditableText), AuthMockSource.devCode);
    await _pumpFrames(tester);

    expect(find.text('What should we call you?'), findsOneWidget);
    expect(_navLabel('Profile'), findsNothing);

    await tester.enterText(
      find.widgetWithText(TextField, 'Your name'),
      'Kwame Boateng',
    );
    await _pumpFrames(tester); // debounce + availability check
    expect(find.text('kwame.boateng'), findsOneWidget);
    expect(find.text('@kwame.boateng is yours to take.'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await _pumpFrames(tester);
    await tester.pumpAndSettle();

    expect(find.text('What should we call you?'), findsNothing);
    expect(_navLabel('Profile'), findsOneWidget);
    expect(find.text('Kwame Boateng'), findsOneWidget);
  });

  testWidgets('switching to vendor mode swaps the shell, and back', (
    tester,
  ) async {
    await _pumpApp(tester, signedIn: true);

    await tester.tap(_navLabel('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Switch to business'));
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
    expect(find.text(_emptyFeed), findsOneWidget);
  });
}
