/// Represents an error returned by an API or thrown during a network request.
///
/// SOLID: Single Responsibility - Encapsulates HTTP failure data cleanly.
class ApiException implements Exception {
  /// HTTP status code, if applicable.
  final int? statusCode;

  /// Error message describing what went wrong.
  final String message;

  /// Optional underlying exception for tracing.
  final dynamic originalError;

  const ApiException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() {
    return 'ApiException(statusCode: $statusCode, message: $message)';
  }
}
