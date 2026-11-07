import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

enum AppFlavor { dev, staging, prod }

/// Build-time configuration, read from `--dart-define`s.
///
/// * `USE_MOCKS` (default `true`) — repositories use seed JSON instead of Dio.
/// * `API_BASE_URL` — Laravel host, without `/v1`. Required when not mocking.
/// * `FLAVOR` — `dev` | `staging` | `prod` (default `dev`).
class AppConfig {
  AppConfig({
    required this.useMocks,
    required String apiBaseUrl,
    this.flavor = AppFlavor.dev,
  }) : apiBaseUrl = _trimTrailingSlash(apiBaseUrl) {
    _validate();
  }

  /// Reads the dart-defines. They are compile-time constants, so they must be
  /// read in a const context — which is why they live in this factory.
  factory AppConfig.fromEnvironment() {
    const useMocks = bool.fromEnvironment('USE_MOCKS', defaultValue: true);
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    return AppConfig(
      useMocks: useMocks,
      apiBaseUrl: apiBaseUrl,
      flavor: AppFlavor.values.asNameMap()[flavor] ?? AppFlavor.dev,
    );
  }

  final bool useMocks;
  final String apiBaseUrl;
  final AppFlavor flavor;

  /// Every remote call lives under `/v1` (see API contract in CLAUDE.md).
  String get apiV1Url => '$apiBaseUrl/v1';

  void _validate() {
    if (!useMocks && apiBaseUrl.isEmpty) {
      throw StateError(
        'USE_MOCKS=false requires --dart-define=API_BASE_URL=<host>.',
      );
    }
  }

  static String _trimTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  @override
  String toString() =>
      'AppConfig(flavor: ${flavor.name}, useMocks: $useMocks, '
      'apiBaseUrl: ${apiBaseUrl.isEmpty ? '-' : apiBaseUrl})';
}

/// Overridden in `bootstrap` with the real config; tests override it freely.
@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => throw UnimplementedError(
  'appConfigProvider must be overridden in bootstrap().',
);
