import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session.g.dart';

/// Who is signed in: `null` when signed out. Restored from stored tokens
/// on launch; signs out by itself when the API reports the session expired.
@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  Future<Me?> build() {
    final expired = ref
        .read(sessionExpiredEventsProvider)
        .stream
        .listen((_) => _signedOut());
    ref.onDispose(expired.cancel);
    return ref.watch(authRepositoryProvider).restore();
  }

  /// Signs in with the code sent to [phone]. Throws on a wrong code, leaving
  /// the session as it was.
  Future<void> verify({required String phone, required String code}) async {
    final me = await ref
        .read(authRepositoryProvider)
        .verify(phone: phone, code: code);
    state = AsyncData(me);
  }

  /// Saves a new account's name (and handle, if they chose one). Throws on
  /// a rejected value, leaving the session as it was.
  Future<void> completeProfile({
    required String displayName,
    String? handle,
  }) async {
    final me = await ref
        .read(authRepositoryProvider)
        .updateProfile(displayName: displayName, handle: handle);
    state = AsyncData(me);
  }

  /// Saves a profile edit, uploading [photoPath] first when the user picked
  /// a new picture. Throws on a rejected value, leaving the session as it was.
  Future<void> updateProfile(
    ProfileChanges changes, {
    String? photoPath,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    final avatarUrl = photoPath == null
        ? null
        : await repo.uploadPhoto(photoPath);
    final me = await repo.updateMe(
      avatarUrl == null ? changes : changes.copyWith(avatarUrl: avatarUrl),
    );
    state = AsyncData(me);
  }

  /// Re-reads the signed-in user, e.g. after starting a business so its
  /// vendor shows up. Keeps the current user on screen meanwhile.
  Future<void> refresh() async {
    final me = await ref.read(authRepositoryProvider).restore();
    if (ref.mounted) state = AsyncData(me);
  }

  /// Email and password for the vendors' web dashboard.
  Future<void> setDashboardSignIn({
    required String email,
    required String password,
  }) => ref
      .read(authRepositoryProvider)
      .setDashboardSignIn(email: email, password: password);

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    _signedOut();
  }

  void _signedOut() {
    ref.read(activeActorProvider.notifier).actAsSelf();
    state = const AsyncData(null);
  }
}
