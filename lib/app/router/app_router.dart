import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/router/shared_routes.dart';
import 'package:petalsinajar/app/router/shell_redirect.dart';
import 'package:petalsinajar/app/router/shells.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// The app's single [GoRouter]. Switching [activeActorProvider] re-runs the
/// redirect, which moves the user into the matching shell.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final actor = ValueNotifier<Actor>(ref.read(activeActorProvider));
  ref
    ..listen(activeActorProvider, (_, next) => actor.value = next)
    ..onDispose(actor.dispose);

  final router = GoRouter(
    initialLocation: Routes.feed,
    refreshListenable: actor,
    redirect: (context, state) =>
        shellRedirect(actor: actor.value, location: state.matchedLocation),
    routes: [userShellRoute, vendorShellRoute, ...sharedRoutes],
  );
  ref.onDispose(router.dispose);
  return router;
}
