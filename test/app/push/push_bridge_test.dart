import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/push/push_bridge.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/notifications/onesignal_service.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/auth_repository.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

/// Stands in for the native OneSignal SDK.
class _FakePush implements OneSignalService {
  final List<String> calls = [];
  void Function(String? route)? onTap;

  @override
  Future<void> login(String externalId) async => calls.add('login $externalId');

  @override
  Future<void> logout() async => calls.add('logout');

  @override
  PushWatch watchNotificationTaps(void Function(String?) onTap) {
    this.onTap = onTap;
    return PushWatch(() => this.onTap = null);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Who's signed in, settable from the test.
class _Viewer extends Notifier<String?> {
  @override
  String? build() => null;

  // A method, not a setter: notifiers keep their API on `state`.
  // ignore: use_setters_to_change_properties
  void signIn(String? id) => state = id;
}

final _viewer = NotifierProvider<_Viewer, String?>(_Viewer.new);

/// The signed-in user, who belongs to one business.
class _Auth implements AuthRepository {
  @override
  Future<Me?> restore() async => const Me(
    id: 'u1',
    handle: 'ama',
    phone: '+233240000001',
    vendors: [
      MeVendor(
        id: 'v1',
        handle: 'royal',
        name: 'Royal Canopies',
        role: 'owner',
      ),
    ],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<(_FakePush, ProviderContainer)> _pump(WidgetTester tester) async {
  final push = _FakePush();
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => const Text('home')),
      GoRoute(
        path: '/events/:id',
        builder: (_, state) => Text('event ${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: '/vendor/requests',
        builder: (_, _) => const Text('vendor requests'),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        oneSignalServiceProvider.overrideWithValue(push),
        viewerIdProvider.overrideWith((ref) => ref.watch(_viewer)),
        authRepositoryProvider.overrideWithValue(_Auth()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        builder: (context, child) => PushBridge(router: router, child: child!),
      ),
    ),
  );
  await tester.pumpAndSettle();
  final container = ProviderScope.containerOf(
    tester.element(find.byType(PushBridge)),
  );
  // Load the session, as the app does at launch.
  await container.read(authSessionProvider.future);
  return (push, container);
}

void main() {
  testWidgets('signing in links the device; signing out unlinks it', (
    tester,
  ) async {
    final (push, container) = await _pump(tester);
    expect(push.calls, isEmpty, reason: 'no user yet at launch');

    container.read(_viewer.notifier).signIn('u1');
    await tester.pump();
    expect(push.calls, ['login u1']);

    container.read(_viewer.notifier).signIn(null);
    await tester.pump();
    expect(push.calls, ['login u1', 'logout']);
  });

  testWidgets('tapping a push opens its route', (tester) async {
    final (push, _) = await _pump(tester);

    push.onTap!('/events/e42');
    await tester.pumpAndSettle();

    expect(find.text('event e42'), findsOneWidget);
  });

  testWidgets('a push without a route, or with an outside one, stays put', (
    tester,
  ) async {
    final (push, _) = await _pump(tester);

    push.onTap!(null);
    push.onTap!('https://evil.example/phish');
    push.onTap!('//evil.example');
    await tester.pumpAndSettle();

    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('a booking push switches to that business and opens Requests', (
    tester,
  ) async {
    final (push, container) = await _pump(tester);

    push.onTap!('/vendor/requests?vendor=v1');
    await tester.pumpAndSettle();

    expect(find.text('vendor requests'), findsOneWidget);
    expect(
      container.read(activeActorProvider),
      const Actor.vendor(vendorId: 'v1', name: 'Royal Canopies'),
    );
  });

  testWidgets("a push for someone else's business is ignored", (tester) async {
    final (push, container) = await _pump(tester);

    push.onTap!('/vendor/requests?vendor=v-not-mine');
    await tester.pumpAndSettle();

    expect(find.text('home'), findsOneWidget);
    expect(container.read(activeActorProvider), const Actor.self());
  });
}
