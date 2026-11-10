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

  /// Saves the name (and, if given, a new handle) a new account picks.
  Future<Me> updateProfile({required String displayName, String? handle});

  /// Saves an edit to the profile and returns the updated user. A taken or
  /// invalid handle is an `ApiException` with a `handle` field error.
  Future<Me> updateMe(ProfileChanges changes);

  /// Email and password for the vendors' web dashboard
  /// (petalsinajar.com/vendor). The app itself signs in by phone. An email
  /// already in use is an `ApiException` with an `email` field error.
  Future<void> setDashboardSignIn({
    required String email,
    required String password,
  });

  /// Whether [handle] is free to claim. The user's own handle counts as taken.
  Future<bool> isHandleAvailable(String handle);

  /// Signs this device out. Always clears local tokens, even offline.
  Future<void> signOut();
}
