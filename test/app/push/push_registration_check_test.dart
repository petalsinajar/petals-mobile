import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/push/push_registration_check.dart';
import 'package:petalsinajar/core/notifications/onesignal_service.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stands in for the native OneSignal SDK.
class _FakePush implements OneSignalService {
  _FakePush([this.id]);

  String? id;
  void Function(String? id)? observer;
  int permissionRequests = 0;
  int cancelled = 0;

  /// What the SDK's observer would report.
  void emit(String? newId) {
    id = newId;
    observer?.call(newId);
  }

  @override
  String? get pushSubscriptionId => id;

  @override
  PushWatch watchPushSubscriptionId(void Function(String?) onId) {
    observer = onId;
    return PushWatch(() {
      cancelled++;
      observer = null;
    });
  }

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _title = 'Your OneSignal SDK integration is complete!';

Future<SharedPreferences> _pump(
  WidgetTester tester,
  _FakePush push, {
  bool alreadyShown = false,
}) async {
  SharedPreferences.setMockInitialValues({
    if (alreadyShown) PushRegistrationCheck.shownKey: true,
  });
  final prefs = await SharedPreferences.getInstance();
  final navigatorKey = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        oneSignalServiceProvider.overrideWithValue(push),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        builder: (context, child) =>
            PushRegistrationCheck(navigatorKey: navigatorKey, child: child!),
        home: const Scaffold(body: Text('home')),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return prefs;
}

void main() {
  test('only a server-assigned id counts as registered', () {
    expect(isRegisteredPushSubscription(null), isFalse);
    expect(isRegisteredPushSubscription(''), isFalse);
    expect(isRegisteredPushSubscription('local-1234'), isFalse);
    expect(isRegisteredPushSubscription('a1b2c3d4-uuid'), isTrue);
  });

  testWidgets('waits out the local placeholder, then shows the dialog once', (
    tester,
  ) async {
    final push = _FakePush('local-placeholder');
    final prefs = await _pump(tester, push);
    expect(find.text(_title), findsNothing);
    expect(push.permissionRequests, 0, reason: 'never asked at launch');

    push.emit('a1b2c3d4-uuid');
    await tester.pumpAndSettle();
    expect(find.text(_title), findsOneWidget);
    expect(prefs.getBool(PushRegistrationCheck.shownKey), isTrue);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(find.text(_title), findsNothing);
    expect(push.permissionRequests, 1, reason: 'asked only on tap');

    push.emit('e5f6-another-uuid');
    await tester.pumpAndSettle();
    expect(find.text(_title), findsNothing, reason: 'only once');
  });

  testWidgets('an id assigned before the observer attached still counts', (
    tester,
  ) async {
    await _pump(tester, _FakePush('a1b2c3d4-uuid'));
    expect(find.text(_title), findsOneWidget);
  });

  testWidgets('once shown on this device, it never shows again', (
    tester,
  ) async {
    final push = _FakePush('a1b2c3d4-uuid');
    await _pump(tester, push, alreadyShown: true);

    expect(find.text(_title), findsNothing);
    expect(push.observer, isNull, reason: 'no observer needed');
  });

  testWidgets('the observer is released with the widget', (tester) async {
    final push = _FakePush('local-placeholder');
    await _pump(tester, push);

    await tester.pumpWidget(const SizedBox());
    expect(push.cancelled, 1);
  });
}
