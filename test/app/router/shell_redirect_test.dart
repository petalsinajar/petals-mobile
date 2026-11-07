import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/router/shell_redirect.dart';
import 'package:petalsinajar/core/session/active_actor.dart';

void main() {
  const self = Actor.self();
  const vendor = Actor.vendor(vendorId: 'v1', name: 'Royal');

  String? go(Actor actor, String location) =>
      shellRedirect(actor: actor, location: location);

  test('root goes to the right home', () {
    expect(go(self, '/'), Routes.feed);
    expect(go(vendor, '/'), Routes.vendorToday);
  });

  test('vendor on a user tab moves to Today', () {
    expect(go(vendor, Routes.feed), Routes.vendorToday);
    expect(go(vendor, Routes.profile), Routes.vendorToday);
  });

  test('self inside the vendor shell moves to Feed', () {
    expect(go(self, Routes.vendorInventory), Routes.feed);
  });

  test('matching shells and shared screens are left alone', () {
    expect(go(self, Routes.discover), isNull);
    expect(go(vendor, Routes.vendorCalendar), isNull);
    // A vendor's public profile is not the vendor shell.
    expect(go(self, Routes.vendor('v1')), isNull);
    expect(go(vendor, Routes.event('e1')), isNull);
  });
}
