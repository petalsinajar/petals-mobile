import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/features/auth/presentation/complete_profile_screen.dart';
import 'package:petalsinajar/features/auth/presentation/sign_in_screen.dart';
import 'package:petalsinajar/features/auth/presentation/verify_code_screen.dart';
import 'package:petalsinajar/features/bookings/presentation/booking_screen.dart';
import 'package:petalsinajar/features/bookings/presentation/my_bookings_screen.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/detail_args.dart';
import 'package:petalsinajar/features/discover/presentation/item_screen.dart';
import 'package:petalsinajar/features/discover/presentation/look_screen.dart';
import 'package:petalsinajar/features/discover/presentation/search_screen.dart';
import 'package:petalsinajar/features/discover/presentation/vendor_screen.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/presentation/create/create_event_screen.dart';
import 'package:petalsinajar/features/events/presentation/event_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/start_business_screen.dart';

/// Full-screen routes reachable from either shell. They sit above the
/// bottom navigation, and every shareable one is deep-linkable.
final List<RouteBase> sharedRoutes = [
  GoRoute(
    path: Routes.startBusiness,
    builder: (_, _) => const StartBusinessScreen(),
  ),
  GoRoute(
    path: Routes.myBookings,
    builder: (_, _) => const MyBookingsScreen(),
  ),
  GoRoute(
    path: Routes.bookingPattern,
    builder: (_, state) =>
        BookingScreen(bookingId: state.pathParameters['id']!),
  ),
  GoRoute(
    path: Routes.search,
    builder: (_, state) => SearchScreen(
      categoryId: state.uri.queryParameters['category'],
      categoryName: state.uri.queryParameters['name'],
    ),
  ),
  GoRoute(
    path: Routes.itemPattern,
    builder: (_, state) => ItemScreen(
      itemId: state.pathParameters['id']!,
      args: DetailArgs.of<ItemCard>(state.extra),
    ),
  ),
  GoRoute(
    path: Routes.vendorPattern,
    builder: (_, state) => VendorScreen(
      vendorId: state.pathParameters['id']!,
      args: DetailArgs.of<VendorCard>(state.extra),
    ),
  ),
  GoRoute(
    path: Routes.postPattern,
    builder: (_, state) => LookScreen(
      postId: state.pathParameters['id']!,
      args: DetailArgs.of<LookPost>(state.extra),
    ),
  ),
  GoRoute(
    path: Routes.signIn,
    builder: (_, state) =>
        SignInScreen(from: state.uri.queryParameters['from']),
  ),
  GoRoute(
    path: Routes.verifyCode,
    builder: (_, state) =>
        VerifyCodeScreen(phone: state.uri.queryParameters['phone'] ?? ''),
  ),
  GoRoute(
    path: Routes.completeProfile,
    builder: (_, _) => const CompleteProfileScreen(),
  ),
  // Before [Routes.eventPattern], so `new` isn't matched as an id.
  GoRoute(
    path: Routes.createEvent,
    builder: (_, _) => const CreateEventScreen(),
  ),
  GoRoute(
    path: Routes.eventPattern,
    builder: (_, state) => EventScreen(
      eventId: state.pathParameters['id']!,
      initial: state.extra is Event ? state.extra! as Event : null,
    ),
  ),
];
