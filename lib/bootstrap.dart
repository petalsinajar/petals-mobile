import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:petalsinajar/app/config/app_config.dart';

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

  runApp(
    ProviderScope(
      // Retries belong to the network layer (RetryInterceptor). Riverpod's
      // automatic retry would stack on top and delay error states.
      retry: (_, _) => null,
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: builder(),
    ),
  );
}
