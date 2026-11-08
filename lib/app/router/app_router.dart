import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/auth_redirect.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/router/shared_routes.dart';
import 'package:petalsinajar/app/router/shell_redirect.dart';
import 'package:petalsinajar/app/router/shells.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

AuthStatus _statusOf(AsyncValue<Me?> session) => switch (session) {
  AsyncData(value: null) => AuthStatus.signedOut,
  AsyncData(value: Me(needsProfile: true)) => AuthStatus.needsProfile,
  AsyncData() => AuthStatus.signedIn,
  _ => AuthStatus.unknown,
};

/// The app's single [GoRouter]. Signing in or out, and switching
/// [activeActorProvider], re-run the redirects: the auth gate first, then
/// the one that keeps the user in the matching shell.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final actor = ValueNotifier<Actor>(ref.read(activeActorProvider));
  final auth = ValueNotifier<AuthStatus>(
    _statusOf(ref.read(authSessionProvider)),
  );
  ref
    ..listen(activeActorProvider, (_, next) => actor.value = next)
    ..listen(authSessionProvider, (_, next) => auth.value = _statusOf(next))
    ..onDispose(actor.dispose)
    ..onDispose(auth.dispose);

  final router = GoRouter(
    initialLocation: Routes.feed,
    refreshListenable: Listenable.merge([actor, auth]),
    redirect: (context, state) =>
        authRedirect(
          status: auth.value,
          location: state.matchedLocation,
          uri: state.uri,
        ) ??
        shellRedirect(actor: actor.value, location: state.matchedLocation),
    routes: [userShellRoute, vendorShellRoute, ...sharedRoutes],
  );
  ref.onDispose(router.dispose);
  return router;
}
