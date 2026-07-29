import '../../shared/api_exception.dart';

/// Generic wrapper for repository responses representing either success or failure.
///
/// SOLID: Open/Closed Principle - Extensible generic state wrapper used across all repos.
class RepositoryResult<T> {
  final bool isSuccess;
  final T? data;
  final String? errorMessage;
  final ApiException? exception;

  const RepositoryResult({
    required this.isSuccess,
    this.data,
    this.errorMessage,
    this.exception,
  });

  factory RepositoryResult.success(T data) {
    return RepositoryResult(isSuccess: true, data: data);
  }

  factory RepositoryResult.failure(String message, {ApiException? exception}) {
    return RepositoryResult(
      isSuccess: false,
      errorMessage: message,
      exception: exception,
    );
  }
}
