import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/interceptors/retry_interceptor.dart';

import '../../helpers/fake_http_adapter.dart';

void main() {
  late FakeHttpAdapter adapter;
  late Dio dio;
  late List<int> statuses;

  setUp(() {
    statuses = [];
    adapter = FakeHttpAdapter((o) async {
      final status = statuses.isEmpty ? 200 : statuses.removeAt(0);
      return jsonBody(status, {'status': status});
    });
    dio = Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(
      RetryInterceptor(client: dio, delay: (_) => Duration.zero),
    );
  });

  test('retries a GET on 503 and succeeds', () async {
    statuses = [503, 200];
    final response = await dio.get<dynamic>('/feed');
    expect(response.statusCode, 200);
    expect(adapter.requests, hasLength(2));
  });

  test('gives up after maxRetries', () async {
    statuses = [503, 503, 503, 200];
    await expectLater(dio.get<dynamic>('/feed'), throwsA(isA<DioException>()));
    expect(adapter.requests, hasLength(3));
  });

  test('never retries a POST', () async {
    statuses = [503, 200];
    await expectLater(
      dio.post<dynamic>('/bookings'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.requests, hasLength(1));
  });

  test('does not retry client errors', () async {
    statuses = [404];
    await expectLater(dio.get<dynamic>('/x'), throwsA(isA<DioException>()));
    expect(adapter.requests, hasLength(1));
  });
}
