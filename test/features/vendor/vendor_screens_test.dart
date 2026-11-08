import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/auth_repository.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/profile/presentation/dashboard_sign_in_screen.dart';
import 'package:petalsinajar/features/vendor/data/vendor_repository_impl.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_repository.dart';
import 'package:petalsinajar/features/vendor/presentation/requests_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/start_business_screen.dart';

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

  @override
  Future<List<VendorBooking>> bookings(
    String vendorId, {
    required List<VendorBookingStatus> statuses,
  }) async => statuses.contains(VendorBookingStatus.pendingVendor)
      ? [...pending]
      : [...upcoming];

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

List<Override> _overrides(_FakeVendors vendors, _FakeAuth auth) => [
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

  group('Start a business', () {
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
      await tester.ensureVisible(find.text('Create business'));
      await tester.tap(find.text('Create business'));
      await tester.pumpAndSettle();

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

      await tester.ensureVisible(find.text('Create business'));
      await tester.tap(find.text('Create business'));
      await tester.pumpAndSettle();

      expect(find.text('Enter your business name.'), findsOneWidget);
      expect(vendors.started, isNull);
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
