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
import 'package:petalsinajar/features/vendor/presentation/edit_business_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/inventory_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/requests_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/start_business_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_profile_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/web_dashboard.dart';

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
  final uploaded = <String>[];

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
      logoUrl: changes['logo_url'] as String? ?? profile.logoUrl,
    );
  }

  @override
  Future<String> uploadImage(String path) async {
    uploaded.add(path);
    return 'https://cdn.test/$path';
  }

  @override
  Future<List<VendorItem>> items(String vendorId) async => inventory;

  final photoSaves = <List<String>>[];

  @override
  Future<ItemMedia> uploadItemPhoto(String path) async {
    uploaded.add(path);
    return ItemMedia(url: 'https://cdn.test/$path', width: 1600, height: 1200);
  }

  @override
  Future<VendorItem> setItemPhotos(
    String vendorId,
    String itemId,
    List<ItemMedia> media,
  ) async {
    photoSaves.add([for (final m in media) m.url]);
    final saved = inventory
        .firstWhere((i) => i.id == itemId)
        .copyWith(media: media, photoUrl: media.firstOrNull?.url);
    inventory = [for (final i in inventory) i.id == itemId ? saved : i];
    return saved;
  }

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
      media: const [ItemMedia(url: 'https://cdn.test/old.jpg')],
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
      expect(vendors.photoSaves.single, [
        'https://cdn.test/old.jpg',
        'https://cdn.test/snap.jpg',
      ]);
      expect(find.text('Photo added'), findsOneWidget);
    });

    testWidgets('the first photo of an item without any becomes the cover', (
      tester,
    ) async {
      final vendors = await pump(tester, [chairs]);
      await openSheet(tester);

      await tester.tap(find.text('Choose'));
      await tester.pumpAndSettle();
      expect(vendors.photoSaves.single, ['https://cdn.test/gallery.jpg']);
      expect(find.text('Cover'), findsOneWidget);
    });

    testWidgets('another photo can be made the cover, or removed', (
      tester,
    ) async {
      final vendors = await pump(tester, [
        withPhoto.copyWith(
          media: const [
            ItemMedia(url: 'https://cdn.test/a.jpg'),
            ItemMedia(url: 'https://cdn.test/b.jpg'),
          ],
        ),
      ]);
      await openSheet(tester);

      await tester.tap(find.bySemanticsLabel('Photo 2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Make cover photo'));
      await tester.pumpAndSettle();
      expect(vendors.photoSaves.last, [
        'https://cdn.test/b.jpg',
        'https://cdn.test/a.jpg',
      ]);

      await tester.tap(find.bySemanticsLabel('Photo 2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Remove photo'));
      await tester.pumpAndSettle();
      expect(vendors.photoSaves.last, ['https://cdn.test/b.jpg']);
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
        'logo_url': 'https://cdn.test/logo.jpg',
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
        'logo_url': 'https://cdn.test/logo.jpg',
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
