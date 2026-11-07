import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// One concise line per request/response. Never logs the bearer token.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor([Logger? logger])
    : _log = logger ?? Logger(printer: SimplePrinter());

  static const _startedKey = 'log_started_at';
  final Logger _log;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedKey] = DateTime.now();
    _log.d('→ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _log.d(
      '← ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.uri} (${_elapsed(response.requestOptions)})',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.w(
      '✕ ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.method} ${err.requestOptions.uri} '
      '(${_elapsed(err.requestOptions)})',
    );
    handler.next(err);
  }

  String _elapsed(RequestOptions options) {
    final started = options.extra[_startedKey];
    return started is DateTime
        ? '${DateTime.now().difference(started).inMilliseconds} ms'
        : '-';
  }
}
