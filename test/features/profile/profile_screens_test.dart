import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/theme/theme_mode.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/auth_repository.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/profile/presentation/edit_profile_screen.dart';
import 'package:petalsinajar/features/profile/presentation/profile_screen.dart';
import 'package:petalsinajar/features/profile/presentation/profile_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_app.dart';

const _kwame = Me(
  id: 'u1',
  handle: 'kwame.b',
  phone: '+233241234567',
  displayName: 'Kwame Boateng',
  bio: 'Planning a big 40th',
  city: 'Accra',
  counts: MeCounts(followers: 12, following: 30, posts: 4),
);

/// The signed-in user's account, in memory.
class _FakeAuth implements AuthRepository {
  _FakeAuth(this.me);

  Me me;
  final List<ProfileChanges> saved = [];
  final List<String> uploaded = [];
  ApiException? rejectWith;

  @override
  Future<Me?> restore() async => me;

  @override
  Future<Me> updateMe(ProfileChanges changes) async {
    if (rejectWith case final e?) throw e;
    saved.add(changes);
    return me = me.copyWith(
      displayName: changes.displayName ?? me.displayName,
      handle: changes.handle ?? me.handle,
      bio: changes.bio ?? me.bio,
      city: changes.city ?? me.city,
      avatarUrl: changes.avatarUrl ?? me.avatarUrl,
      isPrivate: changes.isPrivate ?? me.isPrivate,
      notify: changes.notify ?? me.notify,
    );
  }

  @override
  Future<String> uploadPhoto(String path) async {
    uploaded.add(path);
    return 'https://petalsinajar.com/storage/uploads/me.png';
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A real 1×1 PNG, so `Image.file` can decode the picked photo.
File _photo() {
  final file = File('${Directory.systemTemp.createTempSync().path}/me.png')
    ..writeAsBytesSync(
      base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk'
        'YAAAAAYAAjCB0C8AAAAASUVORK5CYII=',
      ),
    );
  return file;
}

Future<List<Override>> _overrides(_FakeAuth auth) async {
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final prefs = await SharedPreferences.getInstance();
  return [
    authRepositoryProvider.overrideWithValue(auth),
    sharedPreferencesProvider.overrideWithValue(prefs),
  ];
}

/// [screen] at `/page`, above a stand-in for the profile tab at `/`.
Future<void> _pumpRouted(
  WidgetTester tester,
  Widget screen,
  _FakeAuth auth,
) async {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Text('profile tab')),
        routes: [GoRoute(path: 'page', builder: (_, _) => screen)],
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: await _overrides(auth),
      child: MaterialApp.router(theme: testThemes.light, routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  // Not awaited: it completes when the page is popped.
  unawaited(router.push('/page'));
  await tester.pumpAndSettle();
}

void main() {
  group('ProfileScreen', () {
    Future<ProviderContainer> pump(WidgetTester tester, Me me) async {
      await tester.pumpApp(
        const ProfileScreen(),
        overrides: await _overrides(_FakeAuth(me)),
      );
      await tester.pumpAndSettle();
      return ProviderScope.containerOf(
        tester.element(find.byType(ProfileScreen)),
      );
    }

    testWidgets('sums up the account', (tester) async {
      // For the count labels. Disposed in the body: the framework checks for
      // live handles before tear-downs run.
      final semantics = tester.ensureSemantics();
      await pump(tester, _kwame);

      expect(find.text('Kwame Boateng'), findsOneWidget);
      expect(find.text('@kwame.b'), findsOneWidget);
      expect(find.text('Accra'), findsOneWidget);
      expect(find.text('Planning a big 40th'), findsOneWidget);
      // Each count is read out as one phrase.
      for (final (value, label) in [
        ('12', '12 Followers'),
        ('30', '30 Following'),
        ('4', '4 Posts'),
      ]) {
        expect(
          tester.getSemantics(find.text(value)),
          matchesSemantics(label: label, textDirection: TextDirection.ltr),
        );
      }
      semantics.dispose();
    });

    testWidgets('lists the account menu; no business, no switch', (
      tester,
    ) async {
      await pump(tester, _kwame);

      expect(find.text('Edit profile'), findsOneWidget);
      expect(find.text('Profile settings'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Sign out'), findsOneWidget);
      expect(find.text('Switch to business'), findsNothing);
    });

    testWidgets('a business owner can switch to it', (tester) async {
      final container = await pump(
        tester,
        _kwame.copyWith(
          vendors: const [
            MeVendor(
              id: 'v1',
              handle: 'kwamechairs',
              name: 'Kwame Chairs',
              role: 'owner',
            ),
          ],
        ),
      );

      expect(find.text('Kwame Chairs'), findsOneWidget);
      await tester.tap(find.text('Switch to business'));
      await tester.pumpAndSettle();

      expect(
        container.read(activeActorProvider),
        const Actor.vendor(vendorId: 'v1', name: 'Kwame Chairs'),
      );
    });

    testWidgets('appearance can be set to dark and is remembered', (
      tester,
    ) async {
      final container = await pump(tester, _kwame);
      expect(find.text('Same as phone'), findsOneWidget);

      await tester.ensureVisible(find.text('Appearance'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Appearance'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      expect(container.read(appThemeModeProvider), ThemeMode.dark);
      final prefs = container.read(sharedPreferencesProvider);
      expect(prefs.getString('theme_mode'), 'dark');
    });
  });

  group('EditProfileScreen', () {
    testWidgets('saves only what changed, uploading a new photo first', (
      tester,
    ) async {
      final auth = _FakeAuth(_kwame);
      final photo = _photo();
      await _pumpRouted(
        tester,
        EditProfileScreen(pickPhoto: () async => photo.path),
        auth,
      );

      await tester.tap(find.text('Change photo'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextField, 'Bio'),
        'Event planner in Accra',
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(auth.uploaded, [photo.path]);
      expect(
        auth.saved.single,
        const ProfileChanges(
          bio: 'Event planner in Accra',
          avatarUrl: 'https://petalsinajar.com/storage/uploads/me.png',
        ),
      );
      expect(find.text('profile tab'), findsOneWidget, reason: 'went back');
    });

    testWidgets('a name is required', (tester) async {
      final auth = _FakeAuth(_kwame);
      await _pumpRouted(tester, const EditProfileScreen(), auth);

      await tester.enterText(find.widgetWithText(TextField, 'Name'), ' ');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Enter your name.'), findsOneWidget);
      expect(auth.saved, isEmpty);
    });

    testWidgets("the server's username error shows under the field", (
      tester,
    ) async {
      final auth = _FakeAuth(_kwame)
        ..rejectWith = const ApiException(
          type: ApiErrorType.validation,
          message: 'That handle is already taken.',
          statusCode: 422,
          fieldErrors: {
            'handle': ['That handle is already taken.'],
          },
        );
      await _pumpRouted(tester, const EditProfileScreen(), auth);

      await tester.enterText(
        find.widgetWithText(TextField, 'Username'),
        'amamensah',
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('That handle is already taken.'), findsOneWidget);
      expect(find.text('profile tab'), findsNothing, reason: 'stayed');
    });
  });

  group('ProfileSettingsScreen', () {
    testWidgets('a switch saves its setting', (tester) async {
      final auth = _FakeAuth(_kwame);
      await tester.pumpApp(
        const ProfileSettingsScreen(),
        overrides: await _overrides(auth),
      );
      await tester.pumpAndSettle();

      expect(find.text('+233241234567'), findsOneWidget);
      await tester.tap(find.text('Text messages'));
      await tester.pumpAndSettle();

      expect(
        auth.saved.single,
        const ProfileChanges(notify: NotifySettings(sms: false)),
      );
      final sms = tester.widget<SwitchListTile>(
        find.widgetWithText(SwitchListTile, 'Text messages'),
      );
      expect(sms.value, isFalse);
    });
  });
}
