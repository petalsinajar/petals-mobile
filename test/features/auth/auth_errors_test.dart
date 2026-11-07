import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/auth/presentation/auth_errors.dart';

void main() {
  test('a field error wins', () {
    const e = ApiException(
      type: ApiErrorType.validation,
      message: 'The given data was invalid.',
      statusCode: 422,
      fieldErrors: {
        'phone': ['Enter a valid phone number.'],
      },
    );
    expect(authErrorText(e, field: 'phone'), 'Enter a valid phone number.');
  });

  test("SMS delivery failures show the server's retry hint", () {
    const e = ApiException(
      type: ApiErrorType.server,
      message: "We couldn't send the text message. Please try again.",
      statusCode: 503,
    );
    expect(
      authErrorText(e, field: 'phone'),
      "We couldn't send the text message. Please try again.",
    );
  });

  test('other server errors stay generic', () {
    const e = ApiException(
      type: ApiErrorType.server,
      message: 'SQLSTATE[HY000] something internal',
      statusCode: 500,
    );
    expect(authErrorText(e, field: 'phone'), isNot(contains('SQLSTATE')));
  });
}
