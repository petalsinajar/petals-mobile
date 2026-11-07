import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/router/auth_redirect.dart';
import 'package:petalsinajar/app/router/routes.dart';

String? _redirect(AuthStatus status, String location) =>
    authRedirect(status: status, location: location, uri: Uri.parse(location));

void main() {
  group('signed out', () {
    test('can browse public screens', () {
      for (final location in [
        Routes.feed,
        Routes.discover,
        Routes.event('e1'),
        Routes.user('ama'),
      ]) {
        expect(
          _redirect(AuthStatus.signedOut, location),
          isNull,
          reason: location,
        );
      }
    });

    test('is sent to sign in for account screens, remembering where', () {
      for (final location in [
        Routes.create,
        Routes.myEvents,
        Routes.profile,
        Routes.createEvent,
        Routes.vendorToday,
      ]) {
        expect(
          _redirect(AuthStatus.signedOut, location),
          Routes.signInFrom(location),
          reason: location,
        );
      }
    });

    test('keeps the query string in `from`', () {
      expect(
        authRedirect(
          status: AuthStatus.signedOut,
          location: Routes.createEvent,
          uri: Uri.parse('${Routes.createEvent}?type=wedding'),
        ),
        Routes.signInFrom('${Routes.createEvent}?type=wedding'),
      );
    });

    test('stays on the sign-in screens', () {
      expect(_redirect(AuthStatus.signedOut, Routes.signIn), isNull);
      expect(_redirect(AuthStatus.signedOut, Routes.verifyCode), isNull);
    });
  });

  group('signed in', () {
    test('leaves sign in for where they were going', () {
      expect(
        authRedirect(
          status: AuthStatus.signedIn,
          location: Routes.verifyCode,
          uri: Uri.parse(Routes.signInFrom(Routes.myEvents)),
        ),
        Routes.myEvents,
      );
    });

    test('leaves sign in for the feed when there was nowhere to go', () {
      expect(_redirect(AuthStatus.signedIn, Routes.signIn), Routes.feed);
    });

    test('ignores a `from` that is not an in-app path', () {
      expect(
        authRedirect(
          status: AuthStatus.signedIn,
          location: Routes.signIn,
          uri: Uri.parse('${Routes.signIn}?from=https://evil.example'),
        ),
        Routes.feed,
      );
    });

    test('reaches account screens', () {
      expect(_redirect(AuthStatus.signedIn, Routes.myEvents), isNull);
    });
  });

  test('does nothing while the session is still being restored', () {
    expect(_redirect(AuthStatus.unknown, Routes.myEvents), isNull);
    expect(_redirect(AuthStatus.unknown, Routes.signIn), isNull);
  });
}
