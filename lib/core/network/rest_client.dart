import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'api_client.dart';

/// Core REST client for making standard backend API calls.
///
/// SOLID: Single Responsibility Principle - Responsible solely for 
/// instantiating and configuring the base HTTP client for core APIs.
/// Dependency Inversion - Implements ApiClient to be injected into repositories.
class RestClient implements ApiClient {
  final Dio _dio;

  /// Injects AppConfig to decouple hardcoded URLs and timeouts.
  RestClient(AppConfig config) : _dio = Dio() {
    _dio.options
      ..baseUrl = config.apiBaseUrl
      ..connectTimeout = Duration(milliseconds: config.connectionTimeout)
      ..receiveTimeout = Duration(milliseconds: config.connectionTimeout)
      ..headers = {'Content-Type': 'application/json'};
  }

  /// Exposes the underlying Dio instance for injecting interceptors.
  Dio get dio => _dio;

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(path, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future<dynamic> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.post(path, data: data, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future<dynamic> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.put(path, data: data, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future<dynamic> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.delete(path, data: data, queryParameters: queryParameters);
    return response.data;
  }
}
