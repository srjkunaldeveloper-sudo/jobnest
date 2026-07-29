/// Core abstraction for any API Client in the application.
///
/// SOLID: Dependency Inversion / Interface Segregation Principle
/// Defines a contract for HTTP methods to allow swapping implementations (e.g., Dio, Http).
abstract class ApiClient {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path, {dynamic data, Map<String, dynamic>? queryParameters});
  Future<dynamic> put(String path, {dynamic data, Map<String, dynamic>? queryParameters});
  Future<dynamic> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters});
}
