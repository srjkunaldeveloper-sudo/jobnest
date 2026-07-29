import 'package:dio/dio.dart';
import '../../utils/app_logger.dart';

/// Interceptor to log incoming responses and outgoing requests.
///
/// SOLID: Single Responsibility - Handles only HTTP traffic logging.
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}', err);
    super.onError(err, handler);
  }
}
