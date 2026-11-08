import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onesignal_service.g.dart';

/// A real, server-assigned push subscription id: non-empty and not the
/// `local-` placeholder the SDK uses before the device registers.
bool isRegisteredPushSubscription(String? id) =>
    id != null && id.isNotEmpty && !id.startsWith('local-');

/// A live OneSignal observer or listener. Keep it for as long as you want
/// updates (e.g. in a `State` field) and [cancel] it when done.
class PushWatch {
  PushWatch(this._cancel);

  final VoidCallback _cancel;

  void cancel() => _cancel();
}

/// The one place the app talks to OneSignal (push notifications and in-app
/// messages). Nothing else imports `onesignal_flutter`.
class OneSignalService {
  const OneSignalService();

  /// Public app identifier from the OneSignal dashboard; not a secret.
  static const appId = '0a3e6f60-5b02-4338-8a89-edc6177108b6';

  /// Call once in `bootstrap()`, before `runApp`. Does not ask for push
  /// permission — that happens only from the registration dialog.
  Future<void> initialize() async {
    setLogLevel(kDebugMode ? OSLogLevel.verbose : OSLogLevel.none);
    await OneSignal.initialize(appId);
  }

  void setLogLevel(OSLogLevel level) => OneSignal.Debug.setLogLevel(level);

  /// Links this device to the app's user id, so pushes can target a person.
  Future<void> login(String externalId) => OneSignal.login(externalId);

  Future<void> logout() => OneSignal.logout();

  Future<void> addEmail(String email) => OneSignal.User.addEmail(email);

  Future<void> addSms(String phoneNumber) => OneSignal.User.addSms(phoneNumber);

  Future<void> setTag(String key, String value) =>
      OneSignal.User.addTagWithKey(key, value);

  Future<void> removeTag(String key) => OneSignal.User.removeTag(key);

  /// The current push subscription id; `local-…` until registered.
  String? get pushSubscriptionId => OneSignal.User.pushSubscription.id;

  /// Calls [onId] with the subscription id whenever it changes.
  PushWatch watchPushSubscriptionId(
    void Function(String? id) onId,
  ) {
    void observer(OSPushSubscriptionChangedState state) =>
        onId(state.current.id);
    OneSignal.User.pushSubscription.addObserver(observer);
    return PushWatch(
      () => OneSignal.User.pushSubscription.removeObserver(observer),
    );
  }

  /// Calls [onTap] with the push's in-app `route` (from the backend's
  /// `data.route`; null when it should just open the app) when tapped.
  PushWatch watchNotificationTaps(void Function(String? route) onTap) {
    void listener(OSNotificationClickEvent event) {
      final route = event.notification.additionalData?['route'];
      onTap(route is String ? route : null);
    }

    OneSignal.Notifications.addClickListener(listener);
    return PushWatch(
      () => OneSignal.Notifications.removeClickListener(listener),
    );
  }

  /// Shows the system prompt (with a link to Settings if already denied).
  Future<bool> requestPermission() =>
      OneSignal.Notifications.requestPermission(true);
}

/// Overridden in tests, where the native SDK isn't available.
@Riverpod(keepAlive: true)
OneSignalService oneSignalService(Ref ref) => const OneSignalService();
