// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Who is signed in: `null` when signed out. Restored from stored tokens
/// on launch; signs out by itself when the API reports the session expired.

@ProviderFor(AuthSession)
final authSessionProvider = AuthSessionProvider._();

/// Who is signed in: `null` when signed out. Restored from stored tokens
/// on launch; signs out by itself when the API reports the session expired.
final class AuthSessionProvider
    extends $AsyncNotifierProvider<AuthSession, Me?> {
  /// Who is signed in: `null` when signed out. Restored from stored tokens
  /// on launch; signs out by itself when the API reports the session expired.
  AuthSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionHash();

  @$internal
  @override
  AuthSession create() => AuthSession();
}

String _$authSessionHash() => r'4af0956120c47d9e2dbac13619ad10642a148b2c';

/// Who is signed in: `null` when signed out. Restored from stored tokens
/// on launch; signs out by itself when the API reports the session expired.

abstract class _$AuthSession extends $AsyncNotifier<Me?> {
  FutureOr<Me?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Me?>, Me?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Me?>, Me?>,
              AsyncValue<Me?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
