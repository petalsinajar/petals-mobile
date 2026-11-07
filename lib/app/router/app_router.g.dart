// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's single [GoRouter]. Signing in or out, and switching
/// [activeActorProvider], re-run the redirects: the auth gate first, then
/// the one that keeps the user in the matching shell.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// The app's single [GoRouter]. Signing in or out, and switching
/// [activeActorProvider], re-run the redirects: the auth gate first, then
/// the one that keeps the user in the matching shell.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// The app's single [GoRouter]. Signing in or out, and switching
  /// [activeActorProvider], re-run the redirects: the auth gate first, then
  /// the one that keeps the user in the matching shell.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'7b88dc56bade0d22f4d1b161b102082d60e5e49b';
