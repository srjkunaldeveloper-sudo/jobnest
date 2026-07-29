/// Generic wrapper for API responses.
///
/// SOLID: Open/Closed Principle - This wrapper handles any data model type `T`
/// without needing modification. It supports optional metadata and validation errors.
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? meta;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errors,
    this.meta,
  });

  factory ApiResponse.success(T data, {String? message, Map<String, dynamic>? meta}) {
    return ApiResponse(
      success: true,
      data: data,
      message: message,
      meta: meta,
    );
  }

  factory ApiResponse.error(String message, {Map<String, dynamic>? errors}) {
    return ApiResponse(
      success: false,
      message: message,
      errors: errors,
    );
  }
}
