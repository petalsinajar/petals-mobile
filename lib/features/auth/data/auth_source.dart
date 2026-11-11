import 'package:petalsinajar/core/mock/seed_loader.dart';

/// Raw API calls for auth. Both sources return the same JSON shapes, which
/// the repository parses with the DTOs in `auth_dtos.dart`.
abstract interface class AuthSource {
  /// `POST /v1/auth/otp` `{ phone }` → `{ message, phone, expires_in }`.
  Future<Json> requestOtp(String phone);

  /// `POST /v1/auth/verify` `{ phone, code, device_name }` →
  /// `{ access_token, refresh_token, expires_at, is_new, user: me }`.
  Future<Json> verify({
    required String phone,
    required String code,
    required String deviceName,
  });

  /// `GET /v1/me` → me.
  Future<Json> me();

  /// `PATCH /v1/me` with only the fields to change → me. A taken or invalid
  /// `handle` is a 422 on `handle`.
  Future<Json> updateMe(Json fields);

  /// `PUT /v1/me/dashboard-credentials` `{ email, password }` → `{ message }`.
  Future<Json> setDashboardCredentials(String email, String password);

  /// `GET /v1/handles/{handle}/available` → `{ handle, available }`. The
  /// caller's own handle counts as taken.
  Future<Json> handleAvailable(String handle);

  /// `POST /v1/auth/logout` — revokes this device's tokens.
  Future<void> logout();
}
