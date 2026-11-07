import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/api_exception.dart';

DioException _badResponse(int status, Object? body) {
  final options = RequestOptions(path: '/x');
  return DioException.badResponse(
    statusCode: status,
    requestOptions: options,
    response: Response(requestOptions: options, statusCode: status, data: body),
  );
}

void main() {
  test('422 maps Laravel field errors', () {
    final e = ApiException.fromDioException(
      _badResponse(422, {
        'message': 'The given data was invalid.',
        'errors': {
          'phone': ['The phone has already been taken.'],
          'name': ['Too short.', 'Has emoji.'],
        },
      }),
    );
    expect(e.type, ApiErrorType.validation);
    expect(e.statusCode, 422);
    expect(e.message, 'The given data was invalid.');
    expect(e.fieldError('phone'), 'The phone has already been taken.');
    expect(e.fieldErrors['name'], hasLength(2));
    expect(e.fieldError('email'), isNull);
  });

  test('status codes map to types', () {
    expect(
      ApiException.fromDioException(_badResponse(401, null)).type,
      ApiErrorType.unauthorized,
    );
    expect(
      ApiException.fromDioException(_badResponse(404, null)).type,
      ApiErrorType.notFound,
    );
    expect(
      ApiException.fromDioException(_badResponse(503, 'oops')).type,
      ApiErrorType.server,
    );
  });

  test('connection problems are network/timeout', () {
    final options = RequestOptions(path: '/x');
    expect(
      ApiException.fromDioException(
        DioException.connectionError(requestOptions: options, reason: 'down'),
      ).type,
      ApiErrorType.network,
    );
    expect(
      ApiException.fromDioException(
        DioException.receiveTimeout(
          timeout: const Duration(seconds: 1),
          requestOptions: options,
        ),
      ).type,
      ApiErrorType.timeout,
    );
  });

  test('guardApi converts Dio failures', () async {
    await expectLater(
      guardApi<void>(() async => throw _badResponse(409, {'message': 'Taken'})),
      throwsA(
        isA<ApiException>()
            .having((e) => e.type, 'type', ApiErrorType.conflict)
            .having((e) => e.message, 'message', 'Taken'),
      ),
    );
  });

  test('ApiException.from wraps unknown errors', () {
    expect(ApiException.from(StateError('x')).type, ApiErrorType.unknown);
  });
}
