import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

enum AppFlavor { dev, staging, prod }

/// Build-time configuration, read from `--dart-define`s — usually supplied as a
/// whole file: `--dart-define-from-file=.env.dev` (template: `.env.example`).
///
/// * `USE_MOCKS` (default `false`) — `true` swaps every repository for seed
///   JSON held in memory (demo data, reset on restart, shown with a DEMO
///   ribbon).
/// * `API_BASE_URL` — Laravel host, without `/v1` (default
///   [liveApiBaseUrl]).
/// * `FLAVOR` — `dev` | `staging` | `prod` (default `dev`).
///
/// The defaults are the live API, so a build made without an .env file —
/// a plain `flutter run`, or the app reopened from the home screen — never
/// quietly shows demo data.
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
    const useMocks = bool.fromEnvironment('USE_MOCKS');
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: liveApiBaseUrl,
    );
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    return AppConfig(
      useMocks: useMocks,
      apiBaseUrl: apiBaseUrl,
      flavor: AppFlavor.values.asNameMap()[flavor] ?? AppFlavor.dev,
    );
  }

  /// The production API host, used when no `API_BASE_URL` is given.
  static const liveApiBaseUrl = 'https://petalsinajar.com';

  final bool useMocks;
  final String apiBaseUrl;
  final AppFlavor flavor;

  /// Every remote call lives under `/v1` (see API contract in CLAUDE.md).
  String get apiV1Url => '$apiBaseUrl/v1';

  void _validate() {
    if (!useMocks && apiBaseUrl.isEmpty) {
      throw StateError(
        'USE_MOCKS=false requires API_BASE_URL — set it in your .env file '
        'or pass --dart-define=API_BASE_URL=<host>.',
      );
    }
    // TODO(you): reject insecure base URLs for builds that ship to devices.
    // Release builds block cleartext http, so e.g. FLAVOR=prod with an
    // http:// API_BASE_URL compiles fine but every request fails at runtime.
    // Decide which flavors must use https (prod only? staging too?) and
    // throw a StateError naming the offending value.
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
