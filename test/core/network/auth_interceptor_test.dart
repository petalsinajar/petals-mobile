import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/interceptors/auth_interceptor.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';

import '../../helpers/fake_http_adapter.dart';

const _old = AuthTokens(access: 'old', refresh: 'refresh-old');

void main() {
  late InMemoryTokenStorage tokens;
  late FakeHttpAdapter adapter;
  late Dio dio;
  late int expiredCount;
  late bool refreshSucceeds;

  setUp(() {
    tokens = InMemoryTokenStorage(_old);
    expiredCount = 0;
    refreshSucceeds = true;
    adapter = FakeHttpAdapter((o) async {
      if (o.path == AuthInterceptor.refreshPath) {
        // The backend rejects a bad refresh token with a 422, not a 401.
        return refreshSucceeds
            ? jsonBody(200, {
                'token_type': 'Bearer',
                'access_token': 'new',
                'refresh_token': 'refresh-new',
                'expires_at': '2026-11-07T13:00:00+00:00',
              })
            : jsonBody(422, {'message': 'Session expired.'});
      }
      return o.headers['Authorization'] == 'Bearer new'
          ? jsonBody(200, {'ok': true})
          : jsonBody(401, {'message': 'Unauthenticated.'});
    });
    final options = BaseOptions(baseUrl: 'https://api.test/v1');
    final bare = Dio(options)..httpClientAdapter = adapter;
    dio = Dio(options)
      ..httpClientAdapter = adapter
      ..interceptors.add(
        AuthInterceptor(
          tokens: tokens,
          refreshClient: bare,
          onSessionExpired: () => expiredCount++,
        ),
      );
  });

  test('adds the access token as the bearer', () async {
    await tokens.write(const AuthTokens(access: 'new', refresh: 'r'));
    await dio.get<dynamic>('/me');
    expect(adapter.requests.single.headers['Authorization'], 'Bearer new');
  });

  test(
    'on 401 refreshes with the refresh token, stores the pair, retries',
    () async {
      final response = await dio.get<Map<String, dynamic>>('/me');

      expect(response.data, {'ok': true});
      final refresh = adapter.requests.firstWhere(
        (r) => r.path == AuthInterceptor.refreshPath,
      );
      expect(refresh.data, {'refresh_token': 'refresh-old'});
      expect(refresh.headers['Authorization'], isNull);
      expect(
        await tokens.read(),
        const AuthTokens(access: 'new', refresh: 'refresh-new'),
      );
      expect(adapter.countPath(AuthInterceptor.refreshPath), 1);
      expect(expiredCount, 0);
    },
  );

  test('concurrent 401s share a single refresh', () async {
    await Future.wait([
      dio.get<dynamic>('/a'),
      dio.get<dynamic>('/b'),
      dio.get<dynamic>('/c'),
    ]);
    expect(adapter.countPath(AuthInterceptor.refreshPath), 1);
  });

  test('failed refresh clears the tokens and expires the session', () async {
    refreshSucceeds = false;

    await expectLater(
      dio.get<dynamic>('/me'),
      throwsA(
        isA<DioException>().having(
          (e) => e.response?.statusCode,
          'status',
          401,
        ),
      ),
    );
    expect(await tokens.read(), isNull);
    expect(expiredCount, 1);
  });

  test('signed-out requests are not refreshed', () async {
    await tokens.clear();
    await expectLater(dio.get<dynamic>('/me'), throwsA(isA<DioException>()));
    expect(adapter.countPath(AuthInterceptor.refreshPath), 0);
    expect(expiredCount, 1);
  });
}
