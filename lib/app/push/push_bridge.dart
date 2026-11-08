import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/notifications/onesignal_service.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

/// Connects pushes to the signed-in user and the screens they point to:
///
/// * Signing in links this device to the user id (OneSignal's external_id),
///   which is how the backend targets a person; signing out unlinks it.
/// * Tapping a push opens its in-app route (e.g. `/events/{id}` for vendor
///   suggestions), through the router, so sign-in redirects still apply.
///   Vendor routes switch to that business first.
class PushBridge extends ConsumerStatefulWidget {
  const PushBridge({required this.router, required this.child, super.key});

  final GoRouter router;
  final Widget child;

  @override
  ConsumerState<PushBridge> createState() => _PushBridgeState();
}

class _PushBridgeState extends ConsumerState<PushBridge> {
  /// Kept for the widget's lifetime: the listener must stay referenced.
  PushWatch? _taps;

  @override
  void initState() {
    super.initState();
    final push = ref.read(oneSignalServiceProvider);
    ref.listenManual<String?>(viewerIdProvider, (previous, next) {
      if (next != null) {
        unawaited(push.login(next));
      } else if (previous != null) {
        // Only on a real sign-out: launch starts with no user while the
        // session is restored.
        unawaited(push.logout());
      }
    }, fireImmediately: true);
    _taps = push.watchNotificationTaps(_open);
  }

  @override
  void dispose() {
    _taps?.cancel();
    super.dispose();
  }

  void _open(String? route) {
    // In-app paths only, so a crafted payload can't send the user elsewhere.
    if (route == null || !route.startsWith('/') || route.startsWith('//')) {
      return;
    }
    final uri = Uri.parse(route);
    if (uri.path.startsWith(Routes.vendorShellPrefix)) return _openVendor(uri);
    unawaited(widget.router.push<void>(route));
  }

  /// Vendor tabs (`/vendor/requests?vendor={id}`) only show in vendor mode:
  /// act as that business first, if the user belongs to it.
  void _openVendor(Uri uri) {
    final vendorId = uri.queryParameters['vendor'];
    final vendor = ref
        .read(authSessionProvider)
        .value
        ?.vendors
        .where((v) => v.id == vendorId)
        .firstOrNull;
    if (vendor == null) return;
    ref
        .read(activeActorProvider.notifier)
        .actAsVendor(
          vendorId: vendor.id,
          name: vendor.name,
          logoUrl: vendor.logoUrl,
        );
    // A tab, not a page on top: go, not push.
    widget.router.go(uri.path);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
