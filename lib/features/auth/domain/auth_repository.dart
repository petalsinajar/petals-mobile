import 'package:petalsinajar/features/auth/domain/me.dart';

/// Phone sign-in: request a one-time code by SMS, then trade it for tokens.
/// The first successful sign-in for a number creates the account.
abstract interface class AuthRepository {
  Future<OtpChallenge> requestOtp(String phone);

  /// Signs in and stores the tokens.
  Future<Me> verify({required String phone, required String code});

  /// The stored session's user, or null when signed out. Drops tokens the
  /// server rejects; rethrows other failures (e.g. offline) and keeps them.
  Future<Me?> restore();

  /// Signs this device out. Always clears local tokens, even offline.
  Future<void> signOut();
}
