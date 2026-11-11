import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/media_uploader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/auth_repository.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/profile/presentation/dashboard_sign_in_screen.dart';
import 'package:petalsinajar/features/vendor/data/vendor_repository_impl.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_repository.dart';
import 'package:petalsinajar/features/vendor/presentation/calendar_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/edit_business_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/inventory_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/record_booking_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/requests_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/start_business_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/today_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_profile_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/web_dashboard.dart';

import '../../helpers/fake_media.dart';
import '../../helpers/pump_app.dart';

const _vendor = MeVendor(
  id: 'v1',
  handle: 'royalcanopies',
  name: 'Royal Canopies',
  role: 'owner',
);

Me _me({List<MeVendor> vendors = const [_vendor]}) => Me(
  id: 'u1',
  handle: 'ama',
  phone: '+233240000001',
  displayName: 'Ama Mensah',
  vendors: vendors,
);

VendorBooking _booking(String id, VendorBookingStatus status) => VendorBooking(
  id: id,
  number: 'PIJ-$id',
  status: status,
  startsAt: DateTime(2026, 12, 12, 8),
  endsAt: DateTime(2026, 12, 13, 10),
  totalMinor: 480000,
  currency: 'GHS',
  customerName: 'Kwame Boateng',
  lines: const [VendorBookingLine(title: 'Chiavari chair', qty: 120)],
  respondBy: DateTime.now().add(const Duration(days: 2)),
  fulfilment: 'delivery',
);

class _FakeVendors implements VendorRepository {
  final List<VendorBooking> pending = [
    _booking('b1', VendorBookingStatus.pendingVendor),
  ];
  final List<VendorBooking> upcoming = [];
  final List<String> answered = [];
  NewBusiness? started;
  bool acceptFails = false;
  List<VendorItem> inventory = const [];
  BusinessProfile profile = const BusinessProfile(
    id: 'v1',
    handle: 'royalcanopies',
    name: 'Royal Canopies',
    bio: 'Tents and chairs for every party',
    city: 'Accra',
    categories: ['shelter'],
    eventTypes: ['wedding'],
    phone: '0244000000',
    followers: 120,
    completedBookings: 31,
    ratingAverage: 4.8,
    ratingCount: 23,
    serviceRadiusKm: 40,
    delivery: BusinessDelivery(baseFeeMinor: 15000, perKmMinor: 200),
    myRole: 'owner',
  );
  final patches = <Map<String, Object?>>[];

  /// Every upload goes through the shared uploader; this one records them.
  final uploader = FakeMediaUploader();
  List<String> get uploaded => [for (final u in uploader.uploads) u.path];

  bool failBusiness = false;

  @override
  Future<BusinessProfile> business(String vendorId) async => failBusiness
      ? throw const ApiException(type: ApiErrorType.network, message: 'Offline')
      : profile;

  @override
  Future<BusinessProfile> updateBusiness(
    String vendorId,
    Map<String, Object?> changes,
  ) async {
    patches.add(changes);
    return profile = profile.copyWith(
      name: changes['name'] as String? ?? profile.name,
      logoUrl: changes['logo_media_id'] == null
          ? profile.logoUrl
          : 'https://cdn.test/${changes['logo_media_id']}',
    );
  }

  @override
  Future<List<VendorItem>> items(String vendorId) async => inventory;

  final photoSaves = <List<String>>[];

  @override
  Future<VendorItem> setItemPhotos(
    String vendorId,
    String itemId,
    List<String> mediaIds,
  ) async {
    photoSaves.add(mediaIds);
    final media = [for (final id in mediaIds) _photo(id)];
    final saved = inventory
        .firstWhere((i) => i.id == itemId)
        .copyWith(media: media, photoUrl: media.firstOrNull?.stillUrl);
    inventory = [for (final i in inventory) i.id == itemId ? saved : i];
    return saved;
  }

  /// What the Calendar shows (asked for with a date range).
  final List<VendorBooking> calendar = [];
  final List<Blackout> blocked = [];
  var _blackoutIds = 0;

  @override
  Future<List<VendorBooking>> bookings(
    String vendorId, {
    required List<VendorBookingStatus> statuses,
    DateTime? from,
    DateTime? to,
  }) async => from != null
      ? [
          for (final b in calendar)
            if (b.endsAt.isAfter(from) && b.startsAt.isBefore(to!)) b,
        ]
      : statuses.contains(VendorBookingStatus.pendingVendor)
      ? [...pending]
      : [...upcoming];

  @override
  Future<List<Blackout>> blackouts(
    String vendorId, {
    required DateTime from,
    required DateTime to,
  }) async => [
    for (final b in blocked)
      if (!b.endsOn.isBefore(from) && !b.startsOn.isAfter(to)) b,
  ];

  @override
  Future<Blackout> addBlackout(
    String vendorId, {
    required DateTime from,
    required DateTime to,
    String? reason,
  }) async {
    final b = Blackout(
      id: 'bo${++_blackoutIds}',
      startsOn: from,
      endsOn: to,
      reason: (reason ?? '').isEmpty ? null : reason,
    );
    blocked.add(b);
    return b;
  }

  @override
  Future<void> removeBlackout(String vendorId, String blackoutId) async =>
      blocked.removeWhere((b) => b.id == blackoutId);

  @override
  Future<VendorBooking> accept(String bookingId) async {
    if (acceptFails) {
      pending.clear(); // it expired meanwhile
      throw const ApiException(
        type: ApiErrorType.validation,
        message: 'Expired',
        statusCode: 422,
        fieldErrors: {
          'status': ["A booking that is expired can't become accepted."],
        },
      );
    }
    answered.add('accept $bookingId');
    final b = pending.firstWhere((b) => b.id == bookingId);
    pending.remove(b);
    final accepted = b.copyWith(status: VendorBookingStatus.accepted);
    upcoming.add(accepted);
    return accepted;
  }

  final steps = <String>[];
  bool advanceFails = false;

  @override
  Future<VendorBooking> advance(String bookingId, BookingStep step) async {
    if (advanceFails) {
      calendar.removeWhere((b) => b.id == bookingId); // cancelled meanwhile
      throw const ApiException(
        type: ApiErrorType.validation,
        message: 'Cancelled',
        statusCode: 422,
        fieldErrors: {
          'status': ["A booking that is cancelled can't become delivered."],
        },
      );
    }
    steps.add('${step.name} $bookingId');
    final i = calendar.indexWhere((b) => b.id == bookingId);
    final updated = calendar[i].copyWith(
      status: switch (step) {
        BookingStep.dispatch => VendorBookingStatus.outForDelivery,
        BookingStep.deliver => VendorBookingStatus.delivered,
        BookingStep.markReturned => VendorBookingStatus.returned,
      },
    );
    calendar[i] = updated;
    return updated;
  }

  final recorded = <RecordedBooking>[];
  ApiException? recordError;

  @override
  Future<VendorBooking> recordBooking(
    String vendorId,
    RecordedBooking booking,
  ) async {
    if (recordError case final e?) throw e;
    recorded.add(booking);
    final saved = _booking('r1', VendorBookingStatus.confirmed).copyWith(
      customerName: booking.customerName,
      customerPhone: '+233241234567',
      recorded: true,
    );
    upcoming.add(saved);
    return saved;
  }

  @override
  Future<VendorBooking> decline(String bookingId, {String? reason}) async {
    answered.add('decline $bookingId: $reason');
    final b = pending.firstWhere((b) => b.id == bookingId);
    pending.remove(b);
    return b.copyWith(status: VendorBookingStatus.declined);
  }

  @override
  Future<List<BusinessCategory>> categories() async => const [
    BusinessCategory(id: 'chairs', name: 'Chairs'),
    BusinessCategory(id: 'tents', name: 'Tents'),
  ];

  @override
  Future<bool> isHandleAvailable(String handle) async => true;

  @override
  Future<CreatedBusiness> startBusiness(NewBusiness business) async {
    started = business;
    return CreatedBusiness(
      id: 'v9',
      handle: business.handle,
      name: business.name,
    );
  }
}

class _FakeAuth implements AuthRepository {
  _FakeAuth(this.me);

  Me me;
  final List<String> dashboard = [];
  ApiException? dashboardError;

  @override
  Future<Me?> restore() async => me;

  @override
  Future<void> setDashboardSignIn({
    required String email,
    required String password,
  }) async {
    if (dashboardError case final e?) throw e;
    dashboard.add('$email $password');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A ready photo with id [id].
Media _photo(String id) => Media(
  id: id,
  kind: MediaKind.image,
  status: MediaStatus.ready,
  urls: {'thumb': 'https://cdn.test/$id', 'feed': 'https://cdn.test/$id'},
);

List<Override> _overrides(_FakeVendors vendors, _FakeAuth auth) => [
  mediaUploaderProvider.overrideWithValue(vendors.uploader),
  vendorRepositoryProvider.overrideWithValue(vendors),
  authRepositoryProvider.overrideWithValue(auth),
];

void main() {
  group('Requests tab', () {
    Future<_FakeVendors> pump(
      WidgetTester tester, {
      String role = 'owner',
    }) async {
      final vendors = _FakeVendors();
      await tester.pumpApp(
        const VendorRequestsScreen(),
        overrides: _overrides(
          vendors,
          _FakeAuth(_me(vendors: [_vendor.copyWith(role: role)])),
        ),
      );
      // Into vendor mode the way the app does it.
      ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
          .read(activeActorProvider.notifier)
          .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
      await tester.pumpAndSettle();
      return vendors;
    }

    testWidgets('shows what needs an answer', (tester) async {
      await pump(tester);

      expect(find.text('Needs your answer · 1'), findsOneWidget);
      expect(find.text('Kwame Boateng'), findsOneWidget);
      expect(find.text('120 × Chiavari chair'), findsOneWidget);
      expect(find.text('GH₵4,800'), findsOneWidget);
      expect(find.textContaining('Respond by'), findsOneWidget);
    });

    testWidgets('accepting moves it to Upcoming', (tester) async {
      final vendors = await pump(tester);

      await tester.tap(find.text('Accept'));
      await tester.pumpAndSettle();

      expect(vendors.answered, ['accept b1']);
      expect(find.text('Needs your answer · 0'), findsOneWidget);
      expect(find.text('Upcoming · 1'), findsOneWidget);
      expect(find.text('Awaiting deposit'), findsOneWidget);
    });

    testWidgets('declining sends the reason and removes it', (tester) async {
      final vendors = await pump(tester);

      await tester.tap(find.text('Decline'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Fully booked');
      await tester.tap(find.widgetWithText(TextButton, 'Decline'));
      await tester.pumpAndSettle();

      expect(vendors.answered, ['decline b1: Fully booked']);
      // Nothing left in either section: the tab's empty state.
      expect(find.text('No booking requests yet'), findsOneWidget);
    });

    testWidgets('staff see requests but cannot answer', (tester) async {
      await pump(tester, role: 'staff');

      expect(find.text('Kwame Boateng'), findsOneWidget);
      expect(find.text('Accept'), findsNothing);
      expect(find.textContaining('Only owners and managers'), findsOneWidget);
    });

    testWidgets('a request that expired meanwhile says so and refreshes', (
      tester,
    ) async {
      final vendors = await pump(tester)
        ..acceptFails = true;

      await tester.tap(find.text('Accept'));
      await tester.pumpAndSettle();

      expect(find.textContaining("can't become accepted"), findsOneWidget);
      expect(find.text('No booking requests yet'), findsOneWidget);
      expect(vendors.answered, isEmpty);
    });
  });

  group('Today tab', () {
    final today = DateTime(2026, 12, 12);

    Future<(_FakeVendors, List<String>)> pump(
      WidgetTester tester,
      List<VendorBooking> jobs,
    ) {
      return () async {
        tester.view
          ..physicalSize = const Size(1080, 3200)
          ..devicePixelRatio = 2;
        addTearDown(tester.view.reset);
        final vendors = _FakeVendors()..calendar.addAll(jobs);
        final called = <String>[];
        await tester.pumpApp(
          VendorTodayScreen(
            today: today,
            dial: (phone) async => called.add(phone),
          ),
          overrides: _overrides(
            vendors,
            _FakeAuth(_me(vendors: [_vendor.copyWith(role: 'staff')])),
          ),
        );
        ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
            .read(activeActorProvider.notifier)
            .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
        await tester.pumpAndSettle();
        return (vendors, called);
      }();
    }

    // Out 12 Dec 8am, back 13 Dec 10am, delivery.
    VendorBooking job(String id, VendorBookingStatus status) =>
        _booking(id, status).copyWith(
          address: 'Villa Monticello, East Legon',
          contactPhone: '+233241234567',
        );

    test('groups jobs into late, today and tomorrow, by time', () {
      final start = DateTime(2026, 12, 12);
      final view = VendorToday.group([
        // Going out today at 8, and another at 7.
        job('a', VendorBookingStatus.confirmed),
        job('b', VendorBookingStatus.confirmed).copyWith(
          startsAt: DateTime(2026, 12, 12, 7),
        ),
        // Out now, back tomorrow.
        job('c', VendorBookingStatus.delivered),
        // Should have come back yesterday.
        job('d', VendorBookingStatus.delivered).copyWith(
          endsAt: DateTime(2026, 12, 11, 18),
        ),
        // Far off: not shown.
        job('e', VendorBookingStatus.delivered).copyWith(
          endsAt: DateTime(2026, 12, 20),
        ),
      ], start);

      expect([for (final b in view.today) b.id], ['b', 'a']);
      expect([for (final b in view.tomorrow) b.id], ['c']);
      expect([for (final b in view.overdue) b.id], ['d']);
    });

    testWidgets('a delivery goes out, arrives and comes back', (tester) async {
      final (vendors, _) = await pump(tester, [
        job('b1', VendorBookingStatus.confirmed),
      ]);

      expect(find.text('Today · 1'), findsOneWidget);
      expect(find.text('Deliver · 8:00 AM'), findsOneWidget);
      expect(find.text('Villa Monticello, East Legon'), findsOneWidget);

      await tester.tap(find.text('Mark out for delivery'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mark delivered'));
      await tester.pumpAndSettle();

      // Delivered: now it's tomorrow's collection.
      expect(find.text('Today · 0'), findsOneWidget);
      expect(find.text('Tomorrow · 1'), findsOneWidget);
      expect(find.text('Collect · 10:00 AM'), findsOneWidget);
      await tester.tap(find.text('Mark returned'));
      await tester.pumpAndSettle();

      expect(vendors.steps, ['dispatch b1', 'deliver b1', 'markReturned b1']);
      expect(find.text('Tomorrow · 0'), findsOneWidget);
    });

    testWidgets('a pickup is marked picked up', (tester) async {
      final (vendors, _) = await pump(tester, [
        job(
          'p1',
          VendorBookingStatus.confirmed,
        ).copyWith(fulfilment: 'pickup'),
      ]);

      expect(find.text('Customer collects · 8:00 AM'), findsOneWidget);
      expect(find.text('Villa Monticello, East Legon'), findsNothing);
      await tester.tap(find.text('Mark picked up'));
      await tester.pumpAndSettle();
      expect(vendors.steps, ['deliver p1']);
    });

    testWidgets('late returns stand out, and the customer can be called', (
      tester,
    ) async {
      final (_, called) = await pump(tester, [
        job(
          'd1',
          VendorBookingStatus.delivered,
        ).copyWith(endsAt: DateTime(2026, 12, 11, 18)),
      ]);

      expect(find.text('Late · 1'), findsOneWidget);
      expect(find.textContaining('was due Fri 11 Dec'), findsOneWidget);
      await tester.tap(find.byTooltip('Call Kwame Boateng'));
      expect(called, ['+233241234567']);
    });

    testWidgets('a step refused by the server says why and reloads', (
      tester,
    ) async {
      final (vendors, _) = await pump(tester, [
        job('x1', VendorBookingStatus.outForDelivery),
      ]);
      vendors.advanceFails = true;

      await tester.tap(find.text('Mark delivered'));
      await tester.pumpAndSettle();

      expect(find.textContaining("can't become delivered"), findsOneWidget);
      expect(find.text('Mark delivered'), findsNothing);
    });

    testWidgets('requests waiting are flagged; a quiet day says so', (
      tester,
    ) async {
      await pump(tester, const []);

      // The fake always has one pending request.
      expect(find.text('1 request waiting for your answer'), findsOneWidget);
      expect(
        find.text('Nothing going out or coming back today'),
        findsOneWidget,
      );
    });
  });

  group('Calendar tab', () {
    final today = DateTime(2026, 12, 10);

    Future<_FakeVendors> pump(WidgetTester tester, {String role = 'owner'}) {
      return () async {
        tester.view
          ..physicalSize = const Size(1080, 3200)
          ..devicePixelRatio = 2;
        addTearDown(tester.view.reset);
        final vendors = _FakeVendors()
          ..calendar.addAll([
            _booking('c1', VendorBookingStatus.confirmed),
            _booking('c2', VendorBookingStatus.pendingVendor).copyWith(
              customerName: 'Esi Owusu',
              startsAt: DateTime(2026, 12, 13, 9),
              endsAt: DateTime(2026, 12, 15, 17),
            ),
          ])
          ..blocked.add(
            Blackout(
              id: 'xmas',
              startsOn: DateTime(2026, 12, 24),
              endsOn: DateTime(2026, 12, 26),
              reason: 'Christmas',
            ),
          );
        await tester.pumpApp(
          VendorCalendarScreen(today: today),
          overrides: _overrides(
            vendors,
            _FakeAuth(_me(vendors: [_vendor.copyWith(role: role)])),
          ),
        );
        ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
            .read(activeActorProvider.notifier)
            .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
        await tester.pumpAndSettle();
        return vendors;
      }();
    }

    Future<void> tapDay(WidgetTester tester, int day) async {
      await tester.tap(find.byKey(ValueKey('day-$day')));
      await tester.pumpAndSettle();
    }

    // A tall phone, so the grid and the day's agenda are all on screen.
    Future<void> scrollTo(WidgetTester tester, Finder finder) async =>
        expect(finder, findsWidgets);

    testWidgets('shows the month and what is out on a day', (tester) async {
      await pump(tester);

      expect(find.text('December 2026'), findsOneWidget);
      await scrollTo(tester, find.text('Nothing out this day.'));

      // 13 Dec: one comes back, another goes out (and awaits an answer).
      await tapDay(tester, 13);
      await scrollTo(tester, find.text('Esi Owusu'));
      expect(find.text('Kwame Boateng'), findsOneWidget);
      expect(find.textContaining('Comes back 10:00 AM'), findsOneWidget);
      expect(find.textContaining('Awaiting your answer'), findsOneWidget);
    });

    testWidgets('a blocked day says so and can be opened again', (
      tester,
    ) async {
      final vendors = await pump(tester);

      await tapDay(tester, 25);
      await scrollTo(tester, find.text('Blocked 24 Dec – 26 Dec'));
      expect(find.textContaining('Christmas'), findsOneWidget);

      await tester.tap(find.widgetWithText(TextButton, 'Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Open').last);
      await tester.pumpAndSettle();

      expect(vendors.blocked, isEmpty);
      expect(find.text('Blocked 24 Dec – 26 Dec'), findsNothing);
    });

    testWidgets('blocking a day with a reason', (tester) async {
      final vendors = await pump(tester);

      await tapDay(tester, 18);
      await scrollTo(tester, find.text('Block this day'));
      await tester.tap(find.text('Block this day'));
      await tester.pumpAndSettle();
      // The range picker starts on the chosen day.
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('Block 18 Dec?'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Stocktake');
      await tester.tap(find.widgetWithText(TextButton, 'Block'));
      await tester.pumpAndSettle();

      final b = vendors.blocked.last;
      expect(b.startsOn, DateTime(2026, 12, 18));
      expect(b.endsOn, DateTime(2026, 12, 18));
      expect(b.reason, 'Stocktake');
      await scrollTo(tester, find.text('Blocked 18 Dec'));
    });

    testWidgets('staff see the calendar but cannot block', (tester) async {
      await pump(tester, role: 'staff');

      expect(find.text('Block dates'), findsNothing);
      await tapDay(tester, 18);
      expect(find.text('Block this day'), findsNothing);
    });

    testWidgets('moving between months', (tester) async {
      await pump(tester);

      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
      expect(find.text('January 2027'), findsOneWidget);
      await tester.tap(find.byTooltip('Previous month'));
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
      expect(find.text('November 2026'), findsOneWidget);
    });
  });

  group('Record a booking', () {
    const chairs = VendorItem(
      id: 'i1',
      title: 'Chiavari chair',
      status: VendorItemStatus.active,
      fromPriceMinor: 1200,
      currency: 'GHS',
      variants: [
        VendorItemVariant(id: 'g', name: 'Gold', quantity: 120),
        VendorItemVariant(id: 'w', name: 'White', quantity: 80),
      ],
    );
    const tent = VendorItem(
      id: 'i2',
      title: 'Frame tent',
      status: VendorItemStatus.draft,
      fromPriceMinor: 90000,
      currency: 'GHS',
      variants: [VendorItemVariant(id: 't', name: 'Standard', quantity: 2)],
    );

    Future<_FakeVendors> pump(WidgetTester tester, {String role = 'owner'}) {
      return () async {
        final vendors = _FakeVendors()..inventory = const [chairs, tent];
        await tester.pumpApp(
          const RecordBookingScreen(),
          overrides: _overrides(
            vendors,
            _FakeAuth(_me(vendors: [_vendor.copyWith(role: role)])),
          ),
        );
        ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
            .read(activeActorProvider.notifier)
            .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
        await tester.pumpAndSettle();
        return vendors;
      }();
    }

    // The form is a lazy ListView: build what's below the fold first.
    Future<void> scrollTo(
      WidgetTester tester,
      Finder finder, {
      bool up = false,
    }) async {
      await tester.scrollUntilVisible(
        finder,
        up ? -200 : 200,
        scrollable: find.byType(Scrollable).first,
      );
      // Fully on screen, so a tap lands on it.
      await tester.ensureVisible(finder);
      await tester.pumpAndSettle();
    }

    Future<void> addGoldChairs(WidgetTester tester) async {
      await scrollTo(tester, find.text('Add item'));
      await tester.tap(find.text('Add item'));
      await tester.pumpAndSettle();
      // Drafts can't be booked; each active variant is its own choice.
      expect(find.text('Frame tent'), findsNothing);
      expect(find.text('Chiavari chair · White'), findsOneWidget);
      await tester.tap(find.text('Chiavari chair · Gold'));
      await tester.pumpAndSettle();
    }

    testWidgets('saves a delivery with items, paid amount and a note', (
      tester,
    ) async {
      final vendors = await pump(tester);

      await tester.enterText(
        find.widgetWithText(TextField, 'Name'),
        'Akosua Mensah',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Phone'),
        '024 123 4567',
      );
      await tester.tap(find.text('Delivery'));
      await tester.pumpAndSettle();
      await scrollTo(
        tester,
        find.widgetWithText(TextField, 'Delivery address'),
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Delivery address'),
        'East Legon',
      );
      await scrollTo(
        tester,
        find.widgetWithText(TextField, 'Delivery fee (optional)'),
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Delivery fee (optional)'),
        '50',
      );
      await addGoldChairs(tester);
      await scrollTo(tester, find.byTooltip('One more'));
      await tester.tap(find.byTooltip('One more'));
      await tester.pump();
      await scrollTo(
        tester,
        find.widgetWithText(TextField, 'Already paid (optional)'),
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Already paid (optional)'),
        '200',
      );
      // 2 × GH₵12 + GH₵50 delivery.
      await scrollTo(tester, find.text('GH₵74'));

      await scrollTo(tester, find.text('Save booking'));
      await tester.tap(find.text('Save booking'));
      await tester.pumpAndSettle();

      final b = vendors.recorded.single;
      expect(b.customerName, 'Akosua Mensah');
      expect(b.customerPhone, '024 123 4567');
      expect(b.delivery, isTrue);
      expect(b.address, 'East Legon');
      expect(b.deliveryFeeMinor, 5000);
      expect(b.paidMinor, 20000);
      expect(b.lines, const [
        RecordedLine(itemId: 'i1', variantId: 'g', qty: 2),
      ]);
      expect(b.endsAt.isAfter(b.startsAt), isTrue);
      expect(find.text('Booking #PIJ-r1 recorded'), findsOneWidget);
    });

    testWidgets('missing details are pointed out and nothing is sent', (
      tester,
    ) async {
      final vendors = await pump(tester);

      await scrollTo(tester, find.text('Save booking'));
      await tester.tap(find.text('Save booking'));
      await tester.pumpAndSettle();

      expect(vendors.recorded, isEmpty);
      await scrollTo(tester, find.text('Add at least one item.'), up: true);
      await scrollTo(tester, find.text('Enter their name.'), up: true);
      expect(find.text('Enter their phone number.'), findsOneWidget);
    });

    testWidgets('dates already taken show on the item', (tester) async {
      final vendors = await pump(tester)
        ..recordError = const ApiException(
          type: ApiErrorType.validation,
          message: 'Only 20 Chiavari chair (Gold) free on 12 Dec.',
          statusCode: 422,
          fieldErrors: {
            'lines.0.qty': ['Only 20 Chiavari chair (Gold) free on 12 Dec.'],
          },
        );

      await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Akosua');
      await tester.enterText(
        find.widgetWithText(TextField, 'Phone'),
        '0241234567',
      );
      await addGoldChairs(tester);
      await scrollTo(tester, find.text('Save booking'));
      await tester.tap(find.text('Save booking'));
      await tester.pumpAndSettle();

      expect(vendors.recorded, isEmpty);
      expect(find.textContaining('Only 20 Chiavari chair'), findsOneWidget);
      expect(find.text('Record a booking'), findsOneWidget, reason: 'stays');
    });

    testWidgets('Requests: owners get the button, recorded ones are marked', (
      tester,
    ) async {
      final vendors = _FakeVendors()
        ..upcoming.add(
          _booking('r1', VendorBookingStatus.confirmed).copyWith(
            recorded: true,
            customerPhone: '+233241234567',
          ),
        );
      await tester.pumpApp(
        const VendorRequestsScreen(),
        overrides: _overrides(vendors, _FakeAuth(_me())),
      );
      ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
          .read(activeActorProvider.notifier)
          .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
      await tester.pumpAndSettle();

      expect(find.text('Record a booking'), findsOneWidget);
      expect(
        find.text('#PIJ-r1 · Recorded by you · +233241234567'),
        findsOneWidget,
      );
    });

    testWidgets('staff get no record button', (tester) async {
      await tester.pumpApp(
        const VendorRequestsScreen(),
        overrides: _overrides(
          _FakeVendors(),
          _FakeAuth(_me(vendors: [_vendor.copyWith(role: 'staff')])),
        ),
      );
      ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
          .read(activeActorProvider.notifier)
          .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
      await tester.pumpAndSettle();

      expect(find.text('Record a booking'), findsNothing);
    });
  });

  group('Inventory tab', () {
    Future<_FakeVendors> pump(
      WidgetTester tester,
      List<VendorItem> items, {
      String role = 'owner',
    }) {
      return () async {
        final vendors = _FakeVendors()..inventory = items;
        await tester.pumpApp(
          VendorInventoryScreen(
            pickPhoto: ({required camera}) async =>
                camera ? 'snap.jpg' : 'gallery.jpg',
          ),
          overrides: _overrides(
            vendors,
            _FakeAuth(_me(vendors: [_vendor.copyWith(role: role)])),
          ),
        );
        ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
            .read(activeActorProvider.notifier)
            .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
        await tester.pumpAndSettle();
        return vendors;
      }();
    }

    const chairs = VendorItem(
      id: 'i1',
      title: 'Chiavari chair',
      status: VendorItemStatus.active,
      fromPriceMinor: 1200,
      currency: 'GHS',
      variants: [
        VendorItemVariant(id: 'g', name: 'Gold', quantity: 120),
        VendorItemVariant(id: 'w', name: 'White', quantity: 80),
        VendorItemVariant(id: 'x', name: 'Broken', quantity: 5, active: false),
      ],
    );
    const tent = VendorItem(
      id: 'i2',
      title: 'Frame tent',
      status: VendorItemStatus.draft,
      fromPriceMinor: 90000,
      currency: 'GHS',
      unit: 'per_day',
    );
    const old = VendorItem(
      id: 'i3',
      title: 'Old speaker',
      status: VendorItemStatus.archived,
      fromPriceMinor: 5000,
      currency: 'GHS',
    );

    testWidgets('lists items with price and stock; archived hidden', (
      tester,
    ) async {
      await pump(tester, [chairs, tent, old]);

      expect(find.text('1 active · 200 units to rent'), findsOneWidget);
      expect(find.text('Chiavari chair'), findsOneWidget);
      expect(
        find.text('from GH₵12 / event\n200 in stock · 3 options'),
        findsOneWidget,
      );
      expect(find.text('Frame tent'), findsOneWidget);
      expect(find.text('Draft'), findsOneWidget);
      expect(find.text('Old speaker'), findsNothing);
      expect(find.textContaining('on the web dashboard'), findsOneWidget);
    });

    testWidgets('status chips filter, and an item shows its stock', (
      tester,
    ) async {
      await pump(tester, [chairs, tent, old]);

      await tester.tap(find.text('Archived · 1'));
      await tester.pumpAndSettle();
      expect(find.text('Old speaker'), findsOneWidget);
      expect(find.text('Chiavari chair'), findsNothing);

      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chiavari chair'));
      await tester.pumpAndSettle();
      expect(find.text('Gold'), findsOneWidget);
      expect(find.text('Broken (off)'), findsOneWidget);
      expect(find.text('Edit on the web'), findsOneWidget);
    });

    final withPhoto = chairs.copyWith(
      media: [_photo('old')],
      photoUrl: 'https://cdn.test/old.jpg',
    );

    Future<void> openSheet(WidgetTester tester) async {
      tester.view
        ..physicalSize = const Size(400, 1400)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.tap(find.text('Chiavari chair'));
      await tester.pumpAndSettle();
    }

    testWidgets('a snapped photo is uploaded and added, saved at once', (
      tester,
    ) async {
      final vendors = await pump(tester, [withPhoto]);
      await openSheet(tester);

      expect(find.text('Cover'), findsOneWidget);
      await tester.tap(find.text('Take photo'));
      await tester.pumpAndSettle();

      expect(vendors.uploaded, ['snap.jpg']);
      expect(vendors.photoSaves.single, ['old', 'media-snap.jpg']);
      expect(vendors.uploader.uploads.single.purpose, MediaPurpose.item);
      expect(vendors.uploader.uploads.single.vendorId, 'v1');
      expect(find.text('Photo added'), findsOneWidget);
    });

    testWidgets('the first photo of an item without any becomes the cover', (
      tester,
    ) async {
      final vendors = await pump(tester, [chairs]);
      await openSheet(tester);

      await tester.tap(find.text('Choose'));
      await tester.pumpAndSettle();
      expect(vendors.photoSaves.single, ['media-gallery.jpg']);
      expect(find.text('Cover'), findsOneWidget);
    });

    testWidgets('another photo can be made the cover, or removed', (
      tester,
    ) async {
      final vendors = await pump(tester, [
        withPhoto.copyWith(
          media: [_photo('a'), _photo('b')],
        ),
      ]);
      await openSheet(tester);

      await tester.tap(find.bySemanticsLabel('Photo 2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Make cover photo'));
      await tester.pumpAndSettle();
      expect(vendors.photoSaves.last, ['b', 'a']);

      await tester.tap(find.bySemanticsLabel('Photo 2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Remove photo'));
      await tester.pumpAndSettle();
      expect(vendors.photoSaves.last, ['b']);
    });

    testWidgets('staff see the photos but cannot change them', (tester) async {
      await pump(tester, [withPhoto], role: 'staff');
      await openSheet(tester);

      expect(find.text('Cover'), findsOneWidget);
      expect(find.text('Take photo'), findsNothing);
      expect(find.text('Choose'), findsNothing);
    });

    testWidgets('no items: points to the web to add the first', (
      tester,
    ) async {
      await pump(tester, const []);
      expect(find.text('No items yet'), findsOneWidget);
      expect(find.text('Add your first item'), findsOneWidget);
    });

    test('dashboard links use the business handle', () {
      expect(
        WebDashboard.editItem('royalcanopies', 'Chiavari chair').toString(),
        'https://petalsinajar.com/vendor/royalcanopies/items?search=Chiavari+chair',
      );
    });
  });

  group('Business tab', () {
    Future<_FakeVendors> pump(
      WidgetTester tester,
      Widget screen, {
      String role = 'owner',
    }) async {
      final vendors = _FakeVendors();
      vendors.profile = vendors.profile.copyWith(myRole: role);
      await tester.pumpApp(
        screen,
        overrides: _overrides(
          vendors,
          _FakeAuth(_me(vendors: [_vendor.copyWith(role: role)])),
        ),
      );
      ProviderScope.containerOf(tester.element(find.byType(Scaffold).first))
          .read(activeActorProvider.notifier)
          .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
      await tester.pumpAndSettle();
      return vendors;
    }

    Future<String?> picked({required bool logo}) async =>
        logo ? 'logo.jpg' : 'cover.jpg';

    testWidgets('shows the storefront and changes the logo in one tap', (
      tester,
    ) async {
      final vendors = await pump(
        tester,
        VendorProfileScreen(pickPhoto: picked),
      );

      // In the title bar and the header.
      expect(find.text('Royal Canopies'), findsNWidgets(2));
      expect(find.text('@royalcanopies · Accra'), findsOneWidget);
      expect(find.text('★ 4.8'), findsOneWidget);
      expect(find.text('Tents and chairs for every party'), findsOneWidget);
      expect(find.textContaining('Not verified yet'), findsOneWidget);

      await tester.tap(find.byTooltip('Change logo'));
      await tester.pumpAndSettle();
      expect(vendors.uploaded, ['logo.jpg']);
      expect(vendors.patches.single, {
        'logo_media_id': 'media-logo.jpg',
      });
      expect(find.text('Logo updated'), findsOneWidget);
    });

    testWidgets('if the profile won’t load, you can still leave vendor mode', (
      tester,
    ) async {
      final vendors = _FakeVendors()..failBusiness = true;
      await tester.pumpApp(
        const VendorProfileScreen(),
        overrides: _overrides(vendors, _FakeAuth(_me())),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(Scaffold).first),
      );
      container
          .read(activeActorProvider.notifier)
          .actAsVendor(vendorId: 'v1', name: 'Royal Canopies');
      await tester.pumpAndSettle();

      expect(find.text('Royal Canopies'), findsOneWidget);
      await tester.tap(find.text('Back to personal'));
      await tester.pumpAndSettle();
      expect(container.read(activeActorProvider), const Actor.self());
    });

    testWidgets('staff can look but not edit', (tester) async {
      await pump(tester, const VendorProfileScreen(), role: 'staff');
      expect(find.byTooltip('Change logo'), findsNothing);
      expect(find.text('Only owners and managers can edit'), findsOneWidget);
    });

    testWidgets('editing sends only what changed, keeping the per-km fee', (
      tester,
    ) async {
      tester.view
        ..physicalSize = const Size(400, 2400)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final vendors = await pump(
        tester,
        EditBusinessScreen(pickPhoto: picked),
      );

      await tester.enterText(
        find.widgetWithText(TextField, 'Business name'),
        'Royal Canopies & Co',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Delivery fee (GH₵)'),
        '200',
      );
      await tester.tap(find.text('Weddings'));
      await tester.tap(find.text('Birthdays'));
      await tester.tap(find.bySemanticsLabel('Change logo'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Save'));
      await tester.pumpAndSettle();

      expect(vendors.uploaded, ['logo.jpg']);
      expect(vendors.patches.single, {
        'name': 'Royal Canopies & Co',
        'event_types': ['birthday'],
        'delivery': {
          'offered': true,
          'base_fee_minor': 20000,
          'setup_offered': false,
          'setup_fee_minor': 0,
          'per_km_minor': 200,
        },
        'logo_media_id': 'media-logo.jpg',
      });
    });

    testWidgets('a bad email is caught before sending', (tester) async {
      tester.view
        ..physicalSize = const Size(400, 2400)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final vendors = await pump(tester, const EditBusinessScreen());

      await tester.enterText(
        find.widgetWithText(TextField, 'Email'),
        'not-an-email',
      );
      await tester.tap(find.widgetWithText(TextButton, 'Save'));
      await tester.pumpAndSettle();

      expect(find.text('That email doesn’t look right.'), findsOneWidget);
      expect(vendors.patches, isEmpty);
    });

    test('cedis to pesewas', () {
      expect(parseCedis('150'), 15000);
      expect(parseCedis('150.50'), 15050);
      expect(parseCedis('1,200'), 120000);
      expect(parseCedis('abc'), isNull);
    });
  });

  group('Start a business', () {
    // A lazy ListView: build the button before tapping it.
    Future<void> tapCreate(WidgetTester tester) async {
      await tester.scrollUntilVisible(
        find.text('Create business'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(find.text('Create business'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Create business'));
      await tester.pumpAndSettle();
    }

    Future<void> fillSignIn(WidgetTester tester, String email) async {
      await tester.scrollUntilVisible(
        find.widgetWithText(TextField, 'Password'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.enterText(find.widgetWithText(TextField, 'Email'), email);
      await tester.enterText(
        find.widgetWithText(TextField, 'Password'),
        'tents4weddings',
      );
    }

    testWidgets('creates it, joins it, and switches to vendor mode', (
      tester,
    ) async {
      final vendors = _FakeVendors();
      final auth = _FakeAuth(_me(vendors: const []));
      final router = GoRouter(
        initialLocation: '/new',
        routes: [
          GoRoute(path: '/new', builder: (_, _) => const StartBusinessScreen()),
          GoRoute(
            path: '/vendor/today',
            builder: (_, _) => const Scaffold(body: Text('vendor today')),
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: _overrides(vendors, auth),
          child: MaterialApp.router(
            theme: testThemes.light,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Business name'),
        'Kwame Chairs',
      );
      await tester.pump(const Duration(milliseconds: 500)); // handle check
      expect(find.text('kwame.chairs'), findsOneWidget, reason: 'suggested');
      await tester.enterText(find.widgetWithText(TextField, 'City'), 'Kumasi');
      await tester.tap(find.text('Chairs'));
      await tester.tap(find.text('Weddings'));
      // The new business shows up in the user's vendors once refreshed.
      auth.me = _me(
        vendors: const [
          MeVendor(
            id: 'v9',
            handle: 'kwame.chairs',
            name: 'Kwame Chairs',
            role: 'owner',
          ),
        ],
      );
      await fillSignIn(tester, 'kwame@example.com');
      await tapCreate(tester);

      expect(auth.dashboard, ['kwame@example.com tents4weddings']);
      expect(
        vendors.started,
        const NewBusiness(
          name: 'Kwame Chairs',
          handle: 'kwame.chairs',
          city: 'Kumasi',
          categoryIds: ['chairs'],
          eventTypes: ['wedding'],
        ),
      );
      expect(find.text('vendor today'), findsOneWidget);
      final container = ProviderScope.containerOf(
        tester.element(find.text('vendor today')),
      );
      expect(
        container.read(activeActorProvider),
        const Actor.vendor(vendorId: 'v9', name: 'Kwame Chairs'),
      );
    });

    testWidgets('a name is required', (tester) async {
      final vendors = _FakeVendors();
      await tester.pumpApp(
        const StartBusinessScreen(),
        overrides: _overrides(vendors, _FakeAuth(_me(vendors: const []))),
      );
      await tester.pumpAndSettle();

      await tapCreate(tester);

      expect(find.text('Enter a valid email address.'), findsOneWidget);
      expect(find.text('Use at least 10 characters.'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Enter your business name.'),
        -200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(vendors.started, isNull);
    });

    testWidgets('a taken email stops it before the business is made', (
      tester,
    ) async {
      final vendors = _FakeVendors();
      final auth = _FakeAuth(_me(vendors: const []))
        ..dashboardError = const ApiException(
          type: ApiErrorType.validation,
          message: 'The email has already been taken.',
          statusCode: 422,
          fieldErrors: {
            'email': ['The email has already been taken.'],
          },
        );
      await tester.pumpApp(
        const StartBusinessScreen(),
        overrides: _overrides(vendors, auth),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Business name'),
        'Kwame Chairs',
      );
      await fillSignIn(tester, 'taken@example.com');
      await tapCreate(tester);

      expect(find.text('The email has already been taken.'), findsOneWidget);
      expect(vendors.started, isNull);
    });

    testWidgets('no sign-in asked for once there is one', (tester) async {
      final vendors = _FakeVendors();
      final auth = _FakeAuth(
        _me(vendors: const []).copyWith(hasDashboardSignIn: true),
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: _overrides(vendors, auth),
          child: MaterialApp.router(
            theme: testThemes.light,
            routerConfig: GoRouter(
              initialLocation: '/new',
              routes: [
                GoRoute(
                  path: '/new',
                  builder: (_, _) => const StartBusinessScreen(),
                ),
                GoRoute(
                  path: '/vendor/today',
                  builder: (_, _) => const Scaffold(body: Text('vendor today')),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Business name'),
        'Kwame Chairs',
      );
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Web dashboard sign-in'), findsNothing);
      await tapCreate(tester);

      expect(auth.dashboard, isEmpty);
      expect(vendors.started?.name, 'Kwame Chairs');
    });

    testWidgets('a dashboard link without a sign-in sets one up first', (
      tester,
    ) async {
      await tester.pumpApp(
        Builder(
          builder: (context) => TextButton(
            onPressed: () =>
                openWebDashboard(context, WebDashboard.home('royalcanopies')),
            child: const Text('Open dashboard'),
          ),
        ),
        overrides: _overrides(_FakeVendors(), _FakeAuth(_me())),
      );
      await tester.pumpAndSettle();

      // Signed in, as it always is by the time vendor screens show.
      await ProviderScope.containerOf(
        tester.element(find.text('Open dashboard')),
      ).read(authSessionProvider.future);

      await tester.tap(find.text('Open dashboard'));
      await tester.pumpAndSettle();

      expect(find.byType(DashboardSignInScreen), findsOneWidget);
    });
  });

  group('Web dashboard sign-in', () {
    Future<_FakeAuth> pump(WidgetTester tester) async {
      final auth = _FakeAuth(_me());
      await tester.pumpApp(
        const DashboardSignInScreen(),
        overrides: _overrides(_FakeVendors(), auth),
      );
      await tester.pumpAndSettle();
      return auth;
    }

    test('password rule mirrors the backend', () {
      expect(DashboardSignInScreen.passwordProblem('short1'), isNotNull);
      expect(DashboardSignInScreen.passwordProblem('onlyletters'), isNotNull);
      expect(DashboardSignInScreen.passwordProblem('1234567890'), isNotNull);
      expect(DashboardSignInScreen.passwordProblem('chairs4ever'), isNull);
    });

    testWidgets('saves and shows where to sign in', (tester) async {
      final auth = await pump(tester);

      await tester.enterText(
        find.widgetWithText(TextField, 'Email'),
        'ama@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'New password'),
        'chairs4ever',
      );
      await tester.tap(find.text('Save sign-in'));
      await tester.pumpAndSettle();

      expect(auth.dashboard, ['ama@example.com chairs4ever']);
      expect(find.text('Sign-in saved'), findsOneWidget);
      expect(find.text(DashboardSignInScreen.dashboardUrl), findsOneWidget);
    });

    testWidgets('a weak password is caught before sending', (tester) async {
      final auth = await pump(tester);

      await tester.enterText(
        find.widgetWithText(TextField, 'Email'),
        'ama@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'New password'),
        'short',
      );
      await tester.tap(find.text('Save sign-in'));
      await tester.pumpAndSettle();

      expect(find.text('Use at least 10 characters.'), findsOneWidget);
      expect(auth.dashboard, isEmpty);
    });

    testWidgets("the server's email error shows under the field", (
      tester,
    ) async {
      final auth = await pump(tester)
        ..dashboardError = const ApiException(
          type: ApiErrorType.validation,
          message: 'The email has already been taken.',
          statusCode: 422,
          fieldErrors: {
            'email': ['The email has already been taken.'],
          },
        );

      await tester.enterText(
        find.widgetWithText(TextField, 'Email'),
        'used@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'New password'),
        'chairs4ever',
      );
      await tester.tap(find.text('Save sign-in'));
      await tester.pumpAndSettle();

      expect(find.text('The email has already been taken.'), findsOneWidget);
      expect(auth.dashboard, isEmpty);
    });
  });
}
