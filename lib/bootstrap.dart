import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/core/notifications/onesignal_service.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _log = Logger();

/// Sets up error handling and the root [ProviderScope], then runs the app.
Future<void> bootstrap(
  Widget Function() builder, {
  required AppConfig config,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    _log.e(
      details.exceptionAsString(),
      error: details.exception,
      stackTrace: details.stack,
    );
    if (kDebugMode) FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    _log.e('Uncaught platform error', error: error, stackTrace: stack);
    return true;
  };

  _log.i('Starting $config');

  // Firebase (project petalsinajar-d782d) before anything that may use it.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Push and in-app messages. Permission is asked later, not at launch.
  await const OneSignalService().initialize();

  // Loaded before the first frame so the saved theme applies without a flash.
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      // Retries belong to the network layer (RetryInterceptor). Riverpod's
      // automatic retry would stack on top and delay error states.
      retry: (_, _) => null,
      overrides: [
        appConfigProvider.overrideWithValue(config),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: builder(),
    ),
  );
}
