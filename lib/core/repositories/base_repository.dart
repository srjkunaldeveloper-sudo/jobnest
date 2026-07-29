import 'dart:async';
import '../network/api_exception_mapper.dart';
import 'repository_result.dart';

/// Abstract reusable repository for safely executing API calls.
///
/// SOLID: Open/Closed Principle - Extended by feature repositories.
/// Dependency Inversion - Abstractions protect upper layers from Dio details.
abstract class BaseRepository {
  /// Safely executes an asynchronous API call, catches network exceptions, 
  /// and translates them into a standardized [RepositoryResult].
  Future<RepositoryResult<T>> executeSafe<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return RepositoryResult.success(result);
    } catch (e) {
      final apiException = ApiExceptionMapper.map(e);
      return RepositoryResult.failure(
        apiException.message,
        exception: apiException,
      );
    }
  }
}
