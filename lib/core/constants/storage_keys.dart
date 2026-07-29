/// Defines all keys used for local storage to prevent typos.
///
/// SOLID: Single Responsibility - Centralized configuration for storage keys.
class StorageKeys {
  StorageKeys._();

  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userTheme = 'user_theme';
  static const String isFirstLaunch = 'is_first_launch';
}
