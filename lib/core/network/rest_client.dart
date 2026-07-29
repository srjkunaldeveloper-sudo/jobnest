import 'package:dio/dio.dart';
import '../config/app_config.dart';

/// Core REST client for making standard backend API calls.
///
/// SOLID: Single Responsibility Principle - Responsible solely for 
/// instantiating and configuring the base HTTP client for core APIs.
class RestClient {
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
}
