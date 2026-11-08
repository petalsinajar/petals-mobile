import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('mock mode does not need a base URL', () {
      final config = AppConfig(useMocks: true, apiBaseUrl: '');
      expect(config.useMocks, isTrue);
      expect(config.flavor, AppFlavor.dev);
    });

    test('remote mode without a base URL fails fast', () {
      expect(
        () => AppConfig(useMocks: false, apiBaseUrl: ''),
        throwsStateError,
      );
    });

    test('trims trailing slash and builds the /v1 URL', () {
      final config = AppConfig(
        useMocks: false,
        apiBaseUrl: 'http://10.0.2.2:8000/',
      );
      expect(config.apiBaseUrl, 'http://10.0.2.2:8000');
      expect(config.apiV1Url, 'http://10.0.2.2:8000/v1');
    });

    test('with no defines, a build talks to the live API', () {
      // A plain `flutter run`, or reopening an app built without an .env
      // file, must not silently fall back to demo data.
      final config = AppConfig.fromEnvironment();
      expect(config.useMocks, isFalse);
      expect(config.apiBaseUrl, AppConfig.liveApiBaseUrl);
      expect(config.apiV1Url, 'https://petalsinajar.com/v1');
    });
  });
}
