import 'package:dio/dio.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';

/// Adds `Authorization: Bearer <access token>` and handles 401s per the API
/// contract: trade the refresh token for a new pair once via
/// `POST /auth/refresh` `{ refresh_token }`, retry the request, and if that
/// fails clear the tokens and report the session as expired.
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
    final tokens = await _tokens.read();
    if (tokens != null) {
      options.headers['Authorization'] = 'Bearer ${tokens.access}';
    }
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
    final fresh = (current != null && current.access != usedToken)
        ? current.access
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

  /// Returns the new access token, or null when the session can't continue.
  /// The server rotates the pair, so the old refresh token is now dead.
  Future<String?> _refresh(AuthTokens? tokens) async {
    if (tokens == null) return null;
    try {
      final response = await _refreshClient.post<Map<String, dynamic>>(
        refreshPath,
        data: {'refresh_token': tokens.refresh},
      );
      final access = response.data?['access_token'] as String?;
      final refresh = response.data?['refresh_token'] as String?;
      if (access == null || refresh == null) return null;
      await _tokens.write(AuthTokens(access: access, refresh: refresh));
      return access;
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
