import '../storage/secure_storage.dart';
import '../constants/storage_keys.dart';
import 'preferences_manager.dart';
import 'session_manager.dart';

class InitializationResult {
  final bool isFirstLaunch;
  final bool isLoggedIn;
  final String language;
  final String themePreference;

  const InitializationResult({
    required this.isFirstLaunch,
    required this.isLoggedIn,
    required this.language,
    required this.themePreference,
  });
}

class AppInitializationService {
  AppInitializationService._();
  static final AppInitializationService instance = AppInitializationService._();

  bool _isInitialized = false;
  InitializationResult? _result;

  bool get isInitialized => _isInitialized;
  InitializationResult? get result => _result;

  Future<InitializationResult> initializeApp(SecureStorage secureStorage) async {
    try {
      // ===== FUTURE BACKEND INITIALIZATION TODOs =====
      // TODO: Remote Config.
      // TODO: Feature Flags.
      // TODO: Analytics initialization.
      // TODO: Firebase initialization.
      // TODO: Push Notification registration.

      // 1. Load SharedPreferences & App Preferences via PreferencesManager
      await PreferencesManager.instance.init();

      // 2. Check First Launch, Language, and Theme preferences
      final isFirstLaunch = PreferencesManager.instance.isFirstLaunch();
      final language = PreferencesManager.instance.getLanguage();
      final themePref = PreferencesManager.instance.getThemePreference();

      // 3. Initialize SessionManager & Check Login State
      await SessionManager.instance.init();
      
      // Determine session state from SecureStorage token presence
      // TODO: Current validation only checks token presence. 
      // JWT expiry validation must be implemented after the refresh token flow becomes available.
      final token = await secureStorage.read(StorageKeys.authToken);
      final hasToken = token != null && token.isNotEmpty;
      
      final isLoggedInBefore = SessionManager.instance.isLoggedIn();
      if (isLoggedInBefore != hasToken) {
        await SessionManager.instance.setLoginState(hasToken);
      }
      final isLoggedIn = SessionManager.instance.isLoggedIn();

      // Prepare final initialization state
      _result = InitializationResult(
        isFirstLaunch: isFirstLaunch,
        isLoggedIn: isLoggedIn,
        language: language,
        themePreference: themePref,
      );
      _isInitialized = true;

      return _result!;
    } catch (e) {
      _isInitialized = false;
      rethrow;
    }
  }
}
