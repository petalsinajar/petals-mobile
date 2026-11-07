// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appThemes)
final appThemesProvider = AppThemesProvider._();

final class AppThemesProvider
    extends $FunctionalProvider<AppThemes, AppThemes, AppThemes>
    with $Provider<AppThemes> {
  AppThemesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemesHash();

  @$internal
  @override
  $ProviderElement<AppThemes> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppThemes create(Ref ref) {
    return appThemes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemes value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemes>(value),
    );
  }
}

String _$appThemesHash() => r'0f1da893e986149a0c5f87444fd8350649dbd195';
