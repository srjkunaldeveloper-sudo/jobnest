import 'package:dio/dio.dart';
import '../config/app_config.dart';

/// Specialized REST client for making AI-related API calls.
///
/// SOLID: Single Responsibility - Distinct client preventing AI headers,
/// interceptors, or base URLs from mixing with the core standard backend traffic.
class AIClient {
  final Dio _dio;

  /// Injects AppConfig to abstract configurations.
  AIClient(AppConfig config) : _dio = Dio() {
    _dio.options
      ..baseUrl = config.aiBaseUrl
      ..connectTimeout = Duration(milliseconds: config.connectionTimeout)
      ..receiveTimeout = Duration(milliseconds: config.connectionTimeout)
      ..headers = {'Content-Type': 'application/json'};
  }

  /// Exposes the underlying Dio instance for injecting specialized AI interceptors.
  Dio get dio => _dio;
}
