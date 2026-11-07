import 'package:dio/dio.dart';

/// Retries idempotent requests on flaky-network failures and 502/503/504,
/// with exponential backoff. Mutations (POST/PATCH) are never retried, so a
/// booking can't be created twice.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required Dio client,
    this.maxRetries = 2,
    Duration Function(int attempt)? delay,
  }) : _client = client,
       _delay = delay ?? _backoff;

  static const _attemptKey = 'retry_attempt';
  static const _idempotent = {'GET', 'HEAD', 'OPTIONS', 'PUT', 'DELETE'};
  static const _retryableStatus = {502, 503, 504};

  final Dio _client;
  final int maxRetries;
  final Duration Function(int attempt) _delay;

  static Duration _backoff(int attempt) =>
      Duration(milliseconds: 400 * (1 << attempt));

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = options.extra[_attemptKey] as int? ?? 0;
    if (attempt >= maxRetries || !_shouldRetry(err)) {
      return handler.next(err);
    }

    await Future<void>.delayed(_delay(attempt));
    try {
      final response = await _client.fetch<dynamic>(
        options.copyWith(extra: {...options.extra, _attemptKey: attempt + 1}),
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _shouldRetry(DioException err) {
    if (!_idempotent.contains(err.requestOptions.method.toUpperCase())) {
      return false;
    }
    return switch (err.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout => true,
      DioExceptionType.badResponse => _retryableStatus.contains(
        err.response?.statusCode,
      ),
      _ => false,
    };
  }
}
