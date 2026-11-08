import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/core/notifications/onesignal_service.dart';
import 'package:petalsinajar/core/storage/preferences.dart';

/// OneSignal's integration check: once the device has a real push
/// subscription, say so once and ask for push permission when the user
/// taps "Got it". This is the only place the app asks for push permission.
///
/// Sits above the router's Navigator (in `MaterialApp.builder`), so it shows
/// the dialog through [navigatorKey].
class PushRegistrationCheck extends ConsumerStatefulWidget {
  const PushRegistrationCheck({
    required this.navigatorKey,
    required this.child,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  /// Remembers on the device that the dialog has been shown.
  static const shownKey = 'onesignal_registration_dialog_shown';

  @override
  ConsumerState<PushRegistrationCheck> createState() =>
      _PushRegistrationCheckState();
}

class _PushRegistrationCheckState extends ConsumerState<PushRegistrationCheck> {
  /// Kept for the widget's lifetime: the observer must stay referenced.
  PushWatch? _watch;
  late bool _shown;

  @override
  void initState() {
    super.initState();
    _shown =
        ref
            .read(sharedPreferencesProvider)
            .getBool(
              PushRegistrationCheck.shownKey,
            ) ??
        false;
    if (_shown) return;

    final push = ref.read(oneSignalServiceProvider);
    _watch = push.watchPushSubscriptionId(_check);
    // The id may already be assigned before the observer attached.
    _check(push.pushSubscriptionId);
  }

  @override
  void dispose() {
    _watch?.cancel();
    super.dispose();
  }

  void _check(String? subscriptionId) {
    if (_shown || !isRegisteredPushSubscription(subscriptionId)) return;
    _shown = true;
    unawaited(
      ref
          .read(sharedPreferencesProvider)
          .setBool(PushRegistrationCheck.shownKey, true),
    );
    _watch?.cancel();
    _watch = null;
    // After a frame, so the Navigator exists (the id can arrive at launch).
    // Ask for that frame too: an idle app wouldn't draw one by itself.
    WidgetsBinding.instance
      ..addPostFrameCallback((_) => _showDialog())
      ..ensureVisualUpdate();
  }

  Future<void> _showDialog() async {
    final context = widget.navigatorKey.currentContext;
    if (context == null || !mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Your OneSignal SDK integration is complete!'),
        content: const Text(
          'You can now send Push Notifications & In-App Messages through '
          'OneSignal. Tap below to enable push notifications.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              unawaited(ref.read(oneSignalServiceProvider).requestPermission());
            },
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
