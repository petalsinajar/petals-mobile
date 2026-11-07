import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';

/// The line to show under a sign-in input: the server's message for
/// [field] when it rejected it, otherwise a short general one.
String authErrorText(Object error, {required String field}) {
  if (error is ApiException) {
    if (error.fieldError(field) case final message?) return message;
    if (error.type == ApiErrorType.rateLimited) {
      return 'Too many attempts. Wait a minute and try again.';
    }
    if (error.type == ApiErrorType.validation) return error.message;
    // The SMS gateway didn't take the code; the server words the retry hint.
    if (error.statusCode == 503) return error.message;
  }
  final (_, title, message) = ErrorState.describe(error);
  return '$title. $message';
}
