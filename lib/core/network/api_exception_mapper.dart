import 'package:dio/dio.dart';
import '../../shared/api_exception.dart';

/// Mapper to convert raw Dio exceptions into generalized application exceptions.
///
/// SOLID: Single Responsibility - Solely handles HTTP error translation.
class ApiExceptionMapper {
  ApiExceptionMapper._();

  static ApiException map(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiException(
            message: 'Connection timed out. Please try again.',
            statusCode: 408,
            originalError: error,
          );
        case DioExceptionType.connectionError:
          return ApiException(
            message: 'No internet connection. Please check your network.',
            statusCode: 503,
            originalError: error,
          );
        case DioExceptionType.cancel:
          return ApiException(
            message: 'Request was cancelled.',
            statusCode: 499,
            originalError: error,
          );
        case DioExceptionType.badResponse:
          return _mapStatusCode(error);
        case DioExceptionType.unknown:
        default:
          return ApiException(
            message: 'An unexpected network error occurred.',
            statusCode: 0,
            originalError: error,
          );
      }
    }
    return ApiException(
      message: error.toString(),
      originalError: error,
    );
  }

  static ApiException _mapStatusCode(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    String message = 'An error occurred.';

    if (data is Map && data['message'] != null) {
      message = data['message'];
    }

    switch (statusCode) {
      case 400:
        return ApiException(message: message, statusCode: 400, originalError: error);
      case 401:
        return ApiException(message: 'Unauthorized access. Please login.', statusCode: 401, originalError: error);
      case 403:
        return ApiException(message: 'Forbidden access.', statusCode: 403, originalError: error);
      case 404:
        return ApiException(message: 'Requested resource not found.', statusCode: 404, originalError: error);
      case 422:
        return ApiException(message: 'Validation error occurred.', statusCode: 422, originalError: error);
      case 500:
      case 502:
      case 504:
        return ApiException(message: 'Internal server error.', statusCode: statusCode, originalError: error);
      default:
        return ApiException(message: message, statusCode: statusCode, originalError: error);
    }
  }
}
