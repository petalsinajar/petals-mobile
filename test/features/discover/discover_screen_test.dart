import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/discover/data/device_locator.dart';
import 'package:petalsinajar/features/discover/data/discover_repository_impl.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_app.dart';
import 'fakes.dart';

void main() {
  late FakeDiscoverRepository repo;

  setUp(() => repo = FakeDiscoverRepository());

  Future<void> pump(
    WidgetTester tester, {
    String? area = 'Osu',
    ThemeMode theme = ThemeMode.light,
  }) async {
    // A small phone: 360 px wide.
    tester.view
      ..physicalSize = const Size(360, 780)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({
      DiscoverController.pickedAreaKey: ?area,
    });
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpApp(
      const DiscoverScreen(),
      themeMode: theme,
      overrides: [
        discoverRepositoryProvider.overrideWithValue(repo),
        deviceLocatorProvider.overrideWithValue(FakeLocator()),
        sharedPreferencesProvider.overrideWithValue(prefs),
        viewerIdProvider.overrideWithValue('u1'),
      ],
    );
    await tester.pumpAndSettle();
  }

  testWidgets('sections with data show; empty ones hide', (tester) async {
    repo.vendorList = [royal];
    await pump(tester);

    expect(find.text('Near Osu'), findsOneWidget);
    expect(find.text('Vendors near you'), findsOneWidget);
    expect(find.text('Royal Canopies'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Trending looks'), findsNothing);
    expect(find.text('Packages'), findsNothing);
    expect(find.text('For your event'), findsNothing);
    expect(
      find.bySemanticsLabel(RegExp('^Royal Canopies, verified')),
      findsOneWidget,
    );
  });

  testWidgets('a failing section offers its own retry; the rest still load', (
    tester,
  ) async {
    repo
      ..vendorList = null
      ..itemList = [
        const ItemCard(
          id: 'i1',
          title: 'Chiavari chair',
          fromPriceMinor: 1200,
          currency: 'GHS',
          vendor: VendorRef(id: 'v1', name: 'Royal Canopies'),
        ),
      ];
    await pump(tester);

    expect(find.text('Vendors near you'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    repo.vendorList = [royal];
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsNothing);
    expect(find.text('Royal Canopies'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Chiavari chair'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('from GH₵12 / event'), findsOneWidget);
  });

  testWidgets('nothing for the area: one friendly empty state', (tester) async {
    await pump(tester, theme: ThemeMode.dark);

    expect(find.text('Nothing near Osu yet'), findsOneWidget);
    expect(find.text('Change area'), findsOneWidget);
    expect(find.text('Categories'), findsNothing);
  });

  testWidgets('no known place: a polite prompt instead of a system dialog', (
    tester,
  ) async {
    await pump(tester, area: null);

    expect(find.text('See vendors that deliver to you'), findsOneWidget);
    expect(find.text('Choose your area'), findsOneWidget);
  });

  testWidgets('event-type chips filter the sections', (tester) async {
    repo.vendorList = [royal];
    await pump(tester);

    await tester.tap(find.text('Birthdays'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('looks birthday'));
  });

  testWidgets('follow taps flip the button at once', (tester) async {
    repo.vendorList = [royal];
    await pump(tester);

    await tester.tap(find.bySemanticsLabel('Follow Royal Canopies'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('follow v1'));
    expect(find.text('Following'), findsOneWidget);
  });
}
