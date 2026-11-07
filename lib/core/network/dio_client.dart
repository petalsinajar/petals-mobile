import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/core/network/interceptors/auth_interceptor.dart';
import 'package:petalsinajar/core/network/interceptors/logging_interceptor.dart';
import 'package:petalsinajar/core/network/interceptors/retry_interceptor.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

BaseOptions _baseOptions(AppConfig config) => BaseOptions(
  baseUrl: config.apiV1Url,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 20),
  headers: {'Accept': 'application/json'},
  contentType: Headers.jsonContentType,
);

/// Fires when the token could not be refreshed. Auth listens and signs out.
@Riverpod(keepAlive: true)
Raw<StreamController<void>> sessionExpiredEvents(Ref ref) {
  final controller = StreamController<void>.broadcast();
  ref.onDispose(controller.close);
  return controller;
}

/// The Dio used by every remote data source.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final config = ref.watch(appConfigProvider);
  final options = _baseOptions(config);
  final dio = Dio(options);
  final bare = Dio(options);

  dio.interceptors.addAll([
    AuthInterceptor(
      tokens: ref.watch(tokenStorageProvider),
      refreshClient: bare,
      onSessionExpired: () => ref.read(sessionExpiredEventsProvider).add(null),
    ),
    RetryInterceptor(client: dio),
    if (kDebugMode) LoggingInterceptor(),
  ]);

  ref.onDispose(() {
    dio.close();
    bare.close();
  });
  return dio;
}
