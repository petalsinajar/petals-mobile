import 'dart:io';

import 'package:dio/dio.dart';

enum ApiErrorType {
  network,
  timeout,
  cancelled,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  validation,
  rateLimited,
  server,
  unknown,
}

/// Every failure from a repository surfaces as an [ApiException], whether
/// it came from Dio or from a mock source, so screens handle one type.
///
/// Laravel errors look like
/// `{ "message": "...", "errors": { "field": ["..."] } }`.
class ApiException implements Exception {
  const ApiException({
    required this.type,
    required this.message,
    this.statusCode,
    this.fieldErrors = const {},
  });

  factory ApiException.fromDioException(DioException e) {
    final status = e.response?.statusCode;
    final body = e.response?.data;
    final message = body is Map && body['message'] is String
        ? body['message'] as String
        : null;
    final fieldErrors = <String, List<String>>{
      if (body is Map && body['errors'] is Map)
        for (final MapEntry(:key, :value) in (body['errors'] as Map).entries)
          '$key': [
            if (value is List) ...value.map((v) => '$v') else '$value',
          ],
    };

    final type = switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout => ApiErrorType.timeout,
      DioExceptionType.connectionError => ApiErrorType.network,
      DioExceptionType.cancel => ApiErrorType.cancelled,
      DioExceptionType.badResponse => _typeForStatus(status),
      DioExceptionType.badCertificate => ApiErrorType.network,
      DioExceptionType.unknown when e.error is SocketException =>
        ApiErrorType.network,
      DioExceptionType.unknown => ApiErrorType.unknown,
    };

    return ApiException(
      type: type,
      message: message ?? e.message ?? 'Request failed',
      statusCode: status,
      fieldErrors: fieldErrors,
    );
  }

  /// Wraps anything thrown into an [ApiException].
  factory ApiException.from(Object error) => switch (error) {
    final ApiException e => e,
    final DioException e => ApiException.fromDioException(e),
    _ => ApiException(type: ApiErrorType.unknown, message: '$error'),
  };

  final ApiErrorType type;
  final String message;
  final int? statusCode;
  final Map<String, List<String>> fieldErrors;

  /// First validation message for [field], for showing under an input.
  String? fieldError(String field) => fieldErrors[field]?.firstOrNull;

  static ApiErrorType _typeForStatus(int? status) => switch (status) {
    401 => ApiErrorType.unauthorized,
    403 => ApiErrorType.forbidden,
    404 => ApiErrorType.notFound,
    409 => ApiErrorType.conflict,
    422 => ApiErrorType.validation,
    429 => ApiErrorType.rateLimited,
    final int s when s >= 500 => ApiErrorType.server,
    _ => ApiErrorType.unknown,
  };

  @override
  String toString() => 'ApiException(${type.name}, $statusCode, $message)';
}

/// Runs a remote call and converts any Dio failure into an [ApiException].
Future<T> guardApi<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    throw ApiException.fromDioException(e);
  }
}
