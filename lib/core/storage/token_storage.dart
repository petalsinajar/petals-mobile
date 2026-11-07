import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_storage.freezed.dart';
part 'token_storage.g.dart';

/// The Sanctum token pair. [access] calls the API for an hour; [refresh]
/// only buys a new pair (`POST /v1/auth/refresh`) and lasts 60 days.
@freezed
abstract class AuthTokens with _$AuthTokens {
  const factory AuthTokens({required String access, required String refresh}) =
      _AuthTokens;
}

/// Persists the signed-in user's [AuthTokens].
abstract interface class TokenStorage {
  Future<AuthTokens?> read();
  Future<void> write(AuthTokens tokens);
  Future<void> clear();
}

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  static const _accessKey = 'auth_access_token';
  static const _refreshKey = 'auth_refresh_token';
  final FlutterSecureStorage _storage;

  @override
  Future<AuthTokens?> read() async {
    final [access, refresh] = await Future.wait([
      _storage.read(key: _accessKey),
      _storage.read(key: _refreshKey),
    ]);
    if (access == null || refresh == null) return null;
    return AuthTokens(access: access, refresh: refresh);
  }

  @override
  Future<void> write(AuthTokens tokens) async {
    await _storage.write(key: _accessKey, value: tokens.access);
    await _storage.write(key: _refreshKey, value: tokens.refresh);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}

/// For tests.
class InMemoryTokenStorage implements TokenStorage {
  InMemoryTokenStorage([this._tokens]);

  AuthTokens? _tokens;

  @override
  Future<AuthTokens?> read() async => _tokens;

  @override
  Future<void> write(AuthTokens tokens) async => _tokens = tokens;

  @override
  Future<void> clear() async => _tokens = null;
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => SecureTokenStorage();
