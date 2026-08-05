class AppConfig {
  static const String appName = 'JobNest';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Smart Hiring. Better Teams.';

  // ===== FRONTEND MODE =====
  // Abhi ke liye ye true rahega taaki UI testing bina backend ke ho sake.
  // Jab Firebase/APIs integrate ho jayen, toh isko false kar dena.
  static const bool kFrontendMode = false;

  // ===== DEVELOPMENT AUTH BYPASS =====
  // True to bypass authentication screens and go straight to MainDashboard.
  static const bool kSkipAuth = true;
}
