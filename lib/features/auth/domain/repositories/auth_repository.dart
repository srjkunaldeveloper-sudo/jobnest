import '../../../../core/repositories/repository_result.dart';
import '../../data/models/auth_requests.dart';
import '../../data/models/auth_responses.dart';

/// Abstract interface for the Authentication Repository.
///
/// Defines the contract for authentication operations, independent of the
/// underlying data source (e.g., API, Mock, Local DB).
abstract class AuthRepository {
  /// Authenticates a user with email and password.
  Future<RepositoryResult<LoginResponse>> login(LoginRequest request);

  /// Refreshes an expired access token using a valid refresh token.
  Future<RepositoryResult<RefreshTokenResponse>> refreshToken(RefreshTokenRequest request);

  /// Logs the user out, invalidating tokens on the server.
  Future<RepositoryResult<void>> logout(String refreshToken);

  /// Requests a password reset OTP/link for the provided email.
  Future<RepositoryResult<void>> forgotPassword(ForgotPasswordRequest request);

  /// Resets the user's password using an OTP and the new password.
  Future<RepositoryResult<void>> resetPassword(ResetPasswordRequest request);

  /// Verifies a user's email address using an OTP.
  Future<RepositoryResult<void>> verifyEmail(VerifyOtpRequest request);

  /// Changes the authenticated user's password.
  Future<RepositoryResult<void>> changePassword(ChangePasswordRequest request);
}
