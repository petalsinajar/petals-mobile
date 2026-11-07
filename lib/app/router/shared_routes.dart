import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/features/auth/presentation/sign_in_screen.dart';
import 'package:petalsinajar/features/auth/presentation/verify_code_screen.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/presentation/create/create_event_screen.dart';
import 'package:petalsinajar/features/events/presentation/event_screen.dart';

/// Full-screen routes reachable from either shell. They sit above the
/// bottom navigation, and every shareable one is deep-linkable.
final List<RouteBase> sharedRoutes = [
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
