import 'package:petalsinajar/app/router/routes.dart';

/// Where the session stands, as far as the router cares.
enum AuthStatus {
  /// Restoring on launch, or `/me` failed for a reason other than a rejected
  /// session (e.g. offline). Screens handle their own errors meanwhile.
  unknown,
  signedIn,
  signedOut,
}

/// Screens that need an account. Everything else can be browsed signed out.
const List<String> _accountPaths = [
  Routes.create,
  Routes.myEvents,
  Routes.profile,
  Routes.createEvent,
];

bool _needsAccount(String location) =>
    location.startsWith(Routes.vendorShellPrefix) ||
    _accountPaths.any((p) => location == p || location.startsWith('$p/'));

/// Sends signed-out users to sign in for account screens, and signed-in
/// users out of sign in to where they were headed.
///
/// [location] is the matched path; [uri] the full one with its query.
String? authRedirect({
  required AuthStatus status,
  required String location,
  required Uri uri,
}) {
  final onSignIn = location == Routes.signIn || location == Routes.verifyCode;

  return switch (status) {
    AuthStatus.unknown => null,
    AuthStatus.signedOut when _needsAccount(location) => Routes.signInFrom(
      uri.toString(),
    ),
    AuthStatus.signedIn when onSignIn => _safeFrom(
      uri.queryParameters['from'],
    ),
    _ => null,
  };
}

/// Only in-app paths, so a crafted link can't bounce the user elsewhere.
String _safeFrom(String? from) =>
    from != null && from.startsWith('/') && !from.startsWith('//')
    ? from
    : Routes.feed;
