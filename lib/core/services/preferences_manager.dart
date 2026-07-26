import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  PreferencesManager._();
  static final PreferencesManager instance = PreferencesManager._();

  SharedPreferences? _prefs;

  static const String _keyOnboardingCompleted = 'onboardingCompleted';
  static const String _keySeenOnboardingLegacy = 'seen_onboarding';
  static const String _keyLanguage = 'app_language';
  static const String _keyThemeMode = 'app_theme_mode';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool isFirstLaunch() {
    if (_prefs == null) return true;
    final seen = _prefs!.getBool(_keyOnboardingCompleted) ?? 
                 _prefs!.getBool(_keySeenOnboardingLegacy);
    // If the completion flag is missing (fresh install) or false, show onboarding.
    if (seen == null || seen == false) {
      return true;
    }
    return false;
  }

  Future<void> setFirstLaunchCompleted() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_keyOnboardingCompleted, true);
    await _prefs!.setBool(_keySeenOnboardingLegacy, true);
    // ===== BACKEND TODO =====
    // TODO: Sync onboarding completion status with backend profile / database.
    // TODO: Send onboarding completion event to analytics / telemetry service.
  }

  String getLanguage() {
    return _prefs?.getString(_keyLanguage) ?? 'en';
  }

  Future<void> setLanguage(String languageCode) async {
    await _prefs?.setString(_keyLanguage, languageCode);
  }

  String getThemePreference() {
    return _prefs?.getString(_keyThemeMode) ?? 'system';
  }
}
