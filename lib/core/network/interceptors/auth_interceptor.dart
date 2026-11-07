import 'package:dio/dio.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';

/// Adds `Authorization: Bearer <token>` and handles 401s per the API
/// contract: refresh once via `POST /auth/refresh`, retry the request, and if
/// that fails clear the token and report the session as expired.
///
/// It is a [QueuedInterceptor], so concurrent 401s wait for one refresh
/// instead of each triggering their own.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required TokenStorage tokens,
    required Dio refreshClient,
    required void Function() onSessionExpired,
  }) : _tokens = tokens,
       _refreshClient = refreshClient,
       _onSessionExpired = onSessionExpired;

  static const refreshPath = '/auth/refresh';
  static const _retriedKey = 'auth_retried';

  final TokenStorage _tokens;

  /// A bare client (no interceptors) used for the refresh call and the retry.
  final Dio _refreshClient;
  final void Function() _onSessionExpired;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokens.read();
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final isUnauthorized = err.response?.statusCode == 401;
    if (!isUnauthorized ||
        options.path == refreshPath ||
        options.extra[_retriedKey] == true) {
      return handler.next(err);
    }

    final usedToken = _bearerOf(options);
    final current = await _tokens.read();
    // Another queued request may already have refreshed the token.
    final fresh = (current != null && current != usedToken)
        ? current
        : await _refresh(current);

    if (fresh == null) {
      await _tokens.clear();
      _onSessionExpired();
      return handler.next(err);
    }

    try {
      final retry = options.copyWith(
        headers: {...options.headers, 'Authorization': 'Bearer $fresh'},
        extra: {...options.extra, _retriedKey: true},
      );
      handler.resolve(await _refreshClient.fetch<dynamic>(retry));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<String?> _refresh(String? token) async {
    if (token == null) return null;
    try {
      final response = await _refreshClient.post<Map<String, dynamic>>(
        refreshPath,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final fresh = response.data?['token'] as String?;
      if (fresh != null) await _tokens.write(fresh);
      return fresh;
    } on DioException {
      return null;
    }
  }

  static String? _bearerOf(RequestOptions options) {
    final header = options.headers['Authorization'];
    return header is String && header.startsWith('Bearer ')
        ? header.substring('Bearer '.length)
        : null;
  }
}
