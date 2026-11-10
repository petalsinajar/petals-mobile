import 'package:petalsinajar/app/router/routes.dart';

/// Where the session stands, as far as the router cares.
enum AuthStatus {
  /// Restoring on launch, or `/me` failed for a reason other than a rejected
  /// session (e.g. offline). Screens handle their own errors meanwhile.
  unknown,
  signedIn,

  /// Signed in, but a new account that hasn't chosen a name yet.
  needsProfile,
  signedOut,
}

/// Screens that need an account. Everything else can be browsed signed out.
const List<String> _accountPaths = [
  Routes.create,
  Routes.myEvents,
  Routes.profile,
  Routes.createEvent,
  Routes.completeProfile,
  Routes.startBusiness,
  Routes.myBookings,
];

bool _needsAccount(String location) =>
    location.startsWith(Routes.vendorShellPrefix) ||
    _accountPaths.any((p) => location == p || location.startsWith('$p/'));

/// Sends signed-out users to sign in for account screens, new accounts to
/// pick a name before anything else, and everyone out of those screens to
/// where they were headed once done.
///
/// [location] is the matched path; [uri] the full one with its query.
String? authRedirect({
  required AuthStatus status,
  required String location,
  required Uri uri,
}) {
  final onSignIn = location == Routes.signIn || location == Routes.verifyCode;
  final onWelcome = location == Routes.completeProfile;
  // The sign-in and welcome screens carry the destination in `?from=`.
  final from = onSignIn || onWelcome
      ? uri.queryParameters['from']
      : uri.toString();

  return switch (status) {
    AuthStatus.unknown => null,
    AuthStatus.signedOut when _needsAccount(location) => Routes.signInFrom(
      uri.toString(),
    ),
    AuthStatus.needsProfile when !onWelcome => Routes.completeProfileFrom(
      from,
    ),
    AuthStatus.signedIn when onSignIn || onWelcome => _safeFrom(from),
    _ => null,
  };
}

/// Only in-app paths, so a crafted link can't bounce the user elsewhere.
String _safeFrom(String? from) =>
    from != null && from.startsWith('/') && !from.startsWith('//')
    ? from
    : Routes.feed;
