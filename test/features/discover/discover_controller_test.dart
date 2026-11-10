import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/cart/domain/cart_line.dart';
import 'package:petalsinajar/features/cart/presentation/cart_controller.dart';
import 'package:petalsinajar/features/discover/data/device_locator.dart';
import 'package:petalsinajar/features/discover/data/discover_repository_impl.dart';
import 'package:petalsinajar/features/discover/domain/areas.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fakes.dart';

void main() {
  late FakeDiscoverRepository repo;
  late FakeLocator locator;

  Future<ProviderContainer> container({
    Map<String, Object> prefs = const {},
    String? viewer = 'u1',
  }) async {
    SharedPreferences.setMockInitialValues(prefs);
    final shared = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [
        discoverRepositoryProvider.overrideWithValue(repo),
        deviceLocatorProvider.overrideWithValue(locator),
        sharedPreferencesProvider.overrideWithValue(shared),
        viewerIdProvider.overrideWithValue(viewer),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  /// Lets the controller's background resolution finish.
  Future<DiscoverFilter> settle(ProviderContainer c) async {
    c.read(discoverControllerProvider);
    for (var i = 0; i < 10; i++) {
      await Future<void>.delayed(Duration.zero);
    }
    return c.read(discoverControllerProvider);
  }

  final venueEvent = UpcomingEvent(
    id: 'e1',
    title: 'Our wedding',
    startsAt: DateTime(2026, 12, 12),
    venueName: 'Villa Monticello',
    lat: 5.63,
    lng: -0.16,
    isHost: true,
  );

  setUp(() {
    repo = FakeDiscoverRepository();
    locator = FakeLocator();
  });

  group('where Discover looks', () {
    test("a picked area wins over the event's venue", () async {
      repo.events = [venueEvent];
      final c = await container(
        prefs: {DiscoverController.pickedAreaKey: 'Osu'},
      );
      final f = await settle(c);
      expect(f.place?.label, 'Osu');
      expect(f.place?.source, PlaceSource.picked);
    });

    test('else the venue of the next hosted event', () async {
      repo.events = [venueEvent.copyWith(isHost: false), venueEvent];
      final f = await settle(await container());
      expect(f.place?.label, 'Villa Monticello');
      expect(f.place?.source, PlaceSource.eventVenue);
    });

    test(
      'else the phone, but only if already allowed — never a prompt',
      () async {
        locator
          ..granted = true
          ..fix = (lat: 5.636, lng: -0.158);
        final f = await settle(await container());
        expect(f.place?.label, 'East Legon');
        expect(f.place?.source, PlaceSource.device);
      },
    );

    test('else it asks the viewer to choose, without prompting', () async {
      final f = await settle(await container(viewer: null));
      expect(f.place, isNull);
      expect(f.status, PlaceStatus.needsChoice);
      expect(locator.prompts, 0);
    });

    test('picking an area is remembered', () async {
      final c = await container();
      await settle(c);
      await c
          .read(discoverControllerProvider.notifier)
          .pickArea(launchAreas.firstWhere((a) => a.name == 'Tema'));
      expect(c.read(discoverControllerProvider).place?.label, 'Tema');
      expect(
        c
            .read(sharedPreferencesProvider)
            .getString(
              DiscoverController.pickedAreaKey,
            ),
        'Tema',
      );
    });

    test('a device fix far from any known area is just "you"', () {
      expect(placeFromDevice(7.95, -1.03).label, 'you');
    });
  });

  test('sections follow the place and event type', () async {
    repo.vendorList = [royal];
    final c = await container(prefs: {DiscoverController.pickedAreaKey: 'Osu'});
    await settle(c);
    await c.read(nearbyVendorsProvider.future);
    expect(repo.lastNear, (lat: 5.5560, lng: -0.1820));

    c
        .read(discoverControllerProvider.notifier)
        .setEventType(EventType.birthday);
    await c.read(nearbyVendorsProvider.future);
    expect(repo.lastEventType, EventType.birthday);
  });

  test('follow is optimistic and rolls back when refused', () async {
    repo.vendorList = [royal.copyWith(followers: 9)];
    final c = await container(prefs: {DiscoverController.pickedAreaKey: 'Osu'});
    await settle(c);
    await c.read(nearbyVendorsProvider.future);
    final notifier = c.read(nearbyVendorsProvider.notifier);

    final pending = notifier.toggleFollow('v1');
    expect(c.read(nearbyVendorsProvider).value!.single.isFollowing, isTrue);
    await pending;
    expect(c.read(nearbyVendorsProvider).value!.single.followers, 10);

    repo.failFollow = true;
    await expectLater(notifier.toggleFollow('v1'), throwsA(anything));
    expect(c.read(nearbyVendorsProvider).value!.single.isFollowing, isTrue);
  });

  test(
    '"For your event" only shows hosted events still missing things',
    () async {
      repo.events = [venueEvent];
      final c = await container();
      await settle(c); // the venue becomes the place first
      c.listen(forYourEventProvider, (_, _) {});
      expect(await c.read(forYourEventProvider.future), isNull);

      repo.eventNeeds = const [
        EventNeed(categoryId: 'tents', categoryName: 'Tents'),
        EventNeed(
          categoryId: 'sound',
          categoryName: 'Sound',
          vendors: [
            NeedVendor(
              vendor: VendorRef(id: 'v1', name: 'Royal'),
            ),
          ],
        ),
      ];
      c.invalidate(forYourEventProvider);
      final gap = await c.read(forYourEventProvider.future);
      expect(gap?.needs.map((n) => n.categoryId), ['sound']);
    },
  );

  test('the cart merges repeats and survives a restart', () async {
    final c = await container();
    const line = CartLine(
      eventId: 'e1',
      kind: CartLineKind.package,
      refId: 'p1',
      title: 'Kids’ party for 30',
      priceMinor: 250000,
      currency: 'GHS',
    );
    await c.read(cartProvider.notifier).add(line);
    await c.read(cartProvider.notifier).add(line);
    expect(c.read(cartProvider).single.quantity, 2);

    final restarted = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          c.read(sharedPreferencesProvider),
        ),
      ],
    );
    addTearDown(restarted.dispose);
    expect(restarted.read(cartProvider).single.title, 'Kids’ party for 30');
  });
}
