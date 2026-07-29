import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Provides access to environment variables loaded from the .env file.
/// 
/// SOLID: Single Responsibility Principle - Solely responsible for loading
/// and providing environment variables securely.
class EnvConfig {
  EnvConfig._();

  /// Loads the environment variables from the specified file.
  static Future<void> init({String fileName = '.env'}) async {
    await dotenv.load(fileName: fileName);
  }

  /// Retrieves a string value from the environment.
  /// Throws an exception if the key is not found and no default is provided.
  static String getString(String key, {String? defaultValue}) {
    final value = dotenv.env[key] ?? defaultValue;
    if (value == null) {
      throw Exception('Environment variable $key not found.');
    }
    return value;
  }
}
