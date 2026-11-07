import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/core/session/active_actor.dart';

/// Keeps the user in the shell that matches who they're acting as.
///
/// * Acting as a vendor on a user tab → vendor Today.
/// * Acting as themself inside the vendor shell → Feed.
/// * Shared screens (events, posts, items, profiles) are allowed in both.
String? shellRedirect({required Actor actor, required String location}) {
  final inVendorShell = location.startsWith(Routes.vendorShellPrefix);
  final onUserTab = Routes.userTabs.any(
    (tab) => location == tab || location.startsWith('$tab/'),
  );

  return switch (actor) {
    _ when location == '/' =>
      actor is VendorActor ? Routes.vendorToday : Routes.feed,
    VendorActor() when onUserTab => Routes.vendorToday,
    SelfActor() when inVendorShell => Routes.feed,
    _ => null,
  };
}
