/// Defines the environment mode of the application.
enum Environment { dev, staging, prod }

/// Global application configuration settings.
/// 
/// SOLID: Single Responsibility - Holds static app-wide configuration data.
class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final String aiBaseUrl;
  final int connectionTimeout;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.aiBaseUrl,
    this.connectionTimeout = 30000,
  });

  /// Check if the current environment is development.
  bool get isDevelopment => environment == Environment.dev;
}
