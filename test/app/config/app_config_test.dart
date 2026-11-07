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

    test('fromEnvironment defaults to mocks when no defines are passed', () {
      expect(AppConfig.fromEnvironment().useMocks, isTrue);
    });
  });
}
