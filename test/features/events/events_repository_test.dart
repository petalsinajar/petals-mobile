import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/events/data/events_mock_source.dart';
import 'package:petalsinajar/features/events/data/events_repository_impl.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

/// Runs the repository over the real seed through the mock source, so the
/// JSON it builds is checked against the DTOs the remote path uses too.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const ama = '01KK67BN00FWWT9PCC060FWN3G';
  const wedding = '01M4TS07R02ZWKXASREESTWEWT';
  const efuaBirthday = '01M0X4PAW05D2XVWAAXV4R2F88';
  const kofiBrunch = '01KZTT22W050AZN2TVGZBWEKR5';

  late EventsRepositoryImpl repo;

  setUp(() {
    repo = EventsRepositoryImpl(
      EventsMockSource(
        seed: SeedLoader(),
        delay: MockDelay.none(),
        viewerId: ama,
      ),
    );
  });

  test('my events are the ones the viewer hosts or is invited to', () async {
    final events = await repo.myEvents();
    final byId = {for (final e in events) e.id: e};

    expect(events, hasLength(8));
    expect(byId[wedding]!.viewerRole, ViewerRole.host);
    expect(byId[wedding]!.viewerIsHosting, isTrue);
    expect(byId[efuaBirthday]!.viewerRole, ViewerRole.guest);
    expect(byId[efuaBirthday]!.viewerRsvp, RsvpStatus.going);
  });

  test('detail embeds host, co-hosts and guest people', () async {
    final d = await repo.detail(wedding);

    expect(d.host.name, 'Ama Mensah');
    expect(d.coHosts.single.name, 'Kojo Addo');
    expect(d.guests, hasLength(6));
    expect(d.guestsWith(RsvpStatus.maybe), hasLength(2));
    expect(d.event.rsvpCounts.going, 78);
  });

  test('unknown events are a 404 ApiException', () async {
    expect(
      repo.detail('nope'),
      throwsA(
        isA<ApiException>().having(
          (e) => e.type,
          'type',
          ApiErrorType.notFound,
        ),
      ),
    );
  });

  test('rsvp moves the viewer between counts', () async {
    final before = await repo.detail(efuaBirthday);
    final after = await repo.rsvp(efuaBirthday, RsvpStatus.maybe);

    expect(after.event.viewerRsvp, RsvpStatus.maybe);
    expect(after.event.rsvpCounts.going, before.event.rsvpCounts.going - 1);
    expect(after.event.rsvpCounts.maybe, before.event.rsvpCounts.maybe + 1);
  });

  test('feed is newest first with authors joined', () async {
    final page = await repo.feed(kofiBrunch);

    expect(page.items, isNotEmpty);
    expect(page.items.first.author.isVendor, isTrue);
    final times = page.items.map((p) => p.createdAt).toList();
    expect(times, [...times]..sort((a, b) => b.compareTo(a)));
  });

  test('plan lists the event bookings with vendors, cart empty', () async {
    final plan = await repo.plan(wedding);

    expect(plan.bookings, hasLength(2));
    expect(
      plan.bookings.map((b) => b.status),
      containsAll([BookingStatus.pendingVendor, BookingStatus.accepted]),
    );
    expect(plan.bookings.every((b) => b.vendor.isVendor), isTrue);
    expect(plan.bookings.first.itemQuantity, greaterThan(0));
    expect(plan.cart, isEmpty);
  });

  test('created events are hosted by the viewer and listed', () async {
    final starts = DateTime.now().add(const Duration(days: 30));
    final created = await repo.create(
      EventDraft(
        type: EventType.birthday,
        title: '  Yaa turns 7  ',
        startsAt: starts,
        venueName: 'Legon Botanical Gardens',
        venueCity: 'Accra',
        guestCount: 40,
      ),
    );

    expect(created.title, 'Yaa turns 7');
    expect(created.viewerRole, ViewerRole.host);
    expect(created.visibility, EventVisibility.guests);
    expect(created.cover, isNull);
    final mine = await repo.myEvents();
    expect(mine.map((e) => e.id), contains(created.id));
    expect((await repo.detail(created.id)).host.name, 'Ama Mensah');
  });
}
