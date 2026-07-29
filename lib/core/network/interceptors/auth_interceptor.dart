import 'package:dio/dio.dart';
import '../../storage/secure_storage.dart';
import '../../constants/storage_keys.dart';

/// Interceptor to automatically inject authentication tokens into requests.
///
/// SOLID: Single Responsibility - Handles only token injection.
/// Dependency Inversion - Depends on abstractions (SecureStorage).
class AuthInterceptor extends Interceptor {
  final SecureStorage _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(StorageKeys.authToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
