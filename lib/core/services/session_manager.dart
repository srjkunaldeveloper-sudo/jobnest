import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SessionManager._();
  static final SessionManager instance = SessionManager._();

  static const String _keyIsLoggedIn = 'isLoggedIn';

  // Dummy login state for frontend prototyping
  bool _isLoggedIn = false;

  Future<void> init() async {
    // ===== FRONTEND MODE =====
    // ===== BACKEND TODO =====
    // TODO:
    // Replace local session with backend authentication token.
    // TODO:
    // Add token refresh mechanism.
    // TODO:
    // Validate session on app launch.
    // TODO:
    // Handle token expiration.

    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  bool isLoggedIn() => _isLoggedIn;

  Future<void> setLoginState(bool status) async {
    _isLoggedIn = status;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, status);
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    // Note: Only clear authentication/session data. Onboarding completion flag remains unchanged.
  }
}

