import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/bookings/data/bookings_repository_impl.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';
import 'package:petalsinajar/features/bookings/domain/bookings_repository.dart';
import 'package:petalsinajar/features/bookings/presentation/booking_screen.dart';
import 'package:petalsinajar/features/discover/data/discover_repository_impl.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/request_booking_sheet.dart';

import '../discover/fakes.dart';

class _Bookings implements BookingsRepository {
  final sent = <BookingRequest>[];
  bool cancelled = false;

  CustomerBooking _booking(BookingStatus status) => CustomerBooking(
    id: 'b1',
    number: 'BK-26-000042',
    status: status,
    startsAt: DateTime(2026, 12, 12, 11),
    endsAt: DateTime(2026, 12, 12, 23),
    totalMinor: 163320,
    currency: 'GHS',
    vendor: const BookingVendor(id: 'v1', name: 'Royal Canopies'),
    lines: const [BookingItemLine(title: 'Chiavari chair', qty: 120)],
    timeline: [
      BookingStep(to: BookingStatus.pendingVendor, at: DateTime(2026, 11, 10)),
      if (status != BookingStatus.pendingVendor)
        BookingStep(to: status, at: DateTime(2026, 11, 11)),
    ],
  );

  @override
  Future<CustomerBooking> request(BookingRequest request) async {
    // Like the network: long enough for unwatched providers to be disposed.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    sent.add(request);
    return _booking(BookingStatus.pendingVendor);
  }

  @override
  Future<CustomerBooking> booking(String id) async => _booking(
    cancelled ? BookingStatus.cancelled : BookingStatus.pendingVendor,
  );

  @override
  Future<CustomerBooking> cancel(String id, {String? reason}) async {
    cancelled = true;
    return _booking(BookingStatus.cancelled);
  }

  @override
  Future<int> available({
    required String itemId,
    required String variantId,
    required DateTime from,
    required DateTime to,
  }) async => 80;

  @override
  Future<Paginated<CustomerBooking>> mine({String? cursor}) async =>
      const Paginated.empty();
}

final _themes = AppThemes.build(googleFonts: false);

Future<void> _pump(
  WidgetTester tester,
  String initial,
  _Bookings bookings, {
  required List<GoRoute> routes,
  FakeDiscoverRepository? discover,
}) async {
  final router = GoRouter(initialLocation: initial, routes: routes);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        bookingsRepositoryProvider.overrideWithValue(bookings),
        discoverRepositoryProvider.overrideWithValue(
          discover ?? FakeDiscoverRepository(),
        ),
        viewerIdProvider.overrideWithValue('u1'),
      ],
      child: MaterialApp.router(
        theme: _themes.light,
        routerConfig: router,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: child!,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

const _item = ItemCard(
  id: 'i1',
  title: 'Chiavari chair',
  fromPriceMinor: 1200,
  currency: 'GHS',
  vendorId: 'v1',
  vendor: VendorRef(id: 'v1', name: 'Royal Canopies'),
  minQty: 10,
  variants: [
    ItemVariant(id: 'gold', name: 'Gold', quantity: 200),
    ItemVariant(id: 'white', name: 'White', quantity: 150),
  ],
);

void main() {
  testWidgets(
    'requesting an item sends it to the vendor and opens the booking',
    (tester) async {
      final bookings = _Bookings();
      final discover = FakeDiscoverRepository()
        ..events = [
          UpcomingEvent(
            id: 'e1',
            title: 'Our wedding',
            startsAt: DateTime(2026, 12, 12, 14),
            isHost: true,
          ),
        ];
      await _pump(
        tester,
        '/item',
        bookings,
        discover: discover,
        routes: [
          GoRoute(
            path: '/item',
            builder: (_, _) => Scaffold(
              body: Consumer(
                builder: (context, ref, _) => TextButton(
                  onPressed: () => requestToBook(context, ref, _item),
                  child: const Text('Request to book'),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/bookings/:id',
            builder: (_, state) => Scaffold(
              body: Text('booking ${state.pathParameters['id']}'),
            ),
          ),
        ],
      );

      await tester.tap(find.text('Request to book'));
      await tester.pumpAndSettle();
      expect(find.text('80 available on 12 Dec'), findsOneWidget);

      await tester.tap(find.text('White'));
      await tester.tap(find.byTooltip('More'));
      await tester.tap(find.text('Pickup'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Send request'));
      await tester.tap(find.text('Send request'));
      await tester.pumpAndSettle();

      final sent = bookings.sent.single;
      expect(sent.eventId, 'e1');
      expect(sent.variantId, 'white');
      expect(sent.qty, 11); // minimum 10, plus one
      expect(sent.fulfilment, Fulfilment.pickup);
      expect(find.text('booking b1'), findsOneWidget);
      expect(find.text('Request sent to Royal Canopies'), findsOneWidget);
    },
  );

  testWidgets('without a hosted event, it asks to create one first', (
    tester,
  ) async {
    await _pump(
      tester,
      '/item',
      _Bookings(),
      routes: [
        GoRoute(
          path: '/item',
          builder: (_, _) => Scaffold(
            body: Consumer(
              builder: (context, ref, _) => TextButton(
                onPressed: () => requestToBook(context, ref, _item),
                child: const Text('Request to book'),
              ),
            ),
          ),
        ),
      ],
    );
    await tester.tap(find.text('Request to book'));
    await tester.pumpAndSettle();
    expect(find.text('Plan an event first'), findsOneWidget);
  });

  testWidgets('a booking shows where it stands and can be withdrawn', (
    tester,
  ) async {
    final bookings = _Bookings();
    await _pump(
      tester,
      '/bookings/b1',
      bookings,
      routes: [
        GoRoute(
          path: '/bookings/:id',
          builder: (_, state) =>
              BookingScreen(bookingId: state.pathParameters['id']!),
        ),
      ],
    );

    expect(find.text('Waiting for vendor'), findsOneWidget);
    expect(find.text('Requested'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Withdraw request'), 200);
    await tester.tap(find.text('Withdraw request'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel booking'));
    await tester.pumpAndSettle();

    expect(bookings.cancelled, isTrue);
    expect(find.text('Cancelled'), findsWidgets);
    expect(find.text('Withdraw request'), findsNothing);
  });
}
