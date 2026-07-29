/// Centralized API endpoint paths.
///
/// SOLID: Single Responsibility - Contains only endpoint definitions.
class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';

  // Users
  static const String currentUser = '/users/me';
  
  // Jobs
  static const String getJobs = '/jobs';
}
