import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_requests.dart';
import '../models/auth_responses.dart';
import '../models/permission_model.dart';
import '../models/role_model.dart';
import '../models/user_model.dart';

/// A mock implementation of [AuthRepository] for testing and development.
///
/// Returns hardcoded fake data with simulated network delays.
class MockAuthRepository implements AuthRepository {
  @override
  Future<RepositoryResult<LoginResponse>> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    if (request.email == 'admin@jobnest.com' && request.password == 'password') {
      return RepositoryResult.success(
        LoginResponse(
          accessToken: 'mock_access_token_12345',
          refreshToken: 'mock_refresh_token_67890',
          user: const UserModel(
            id: 'usr_1',
            email: 'admin@jobnest.com',

            firstName: 'Admin',
            lastName: 'User',
            isEmailVerified: true,
            role: RoleModel(
              id: 'role_admin',
              name: 'Administrator',
              permissions: [
                PermissionModel(id: 'perm_1', action: 'manage', resource: 'all'),
              ],
            ),
          ),
        ),
      );
    }
    return RepositoryResult.failure('Invalid email or password.');
  }

  @override
  Future<RepositoryResult<RefreshTokenResponse>> refreshToken(RefreshTokenRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return RepositoryResult.success(
      const RefreshTokenResponse(
        accessToken: 'new_mock_access_token',
        refreshToken: 'new_mock_refresh_token',
      ),
    );
  }

  @override
  Future<RepositoryResult<void>> logout(String refreshToken) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return RepositoryResult.success(null);
  }

  @override
  Future<RepositoryResult<void>> forgotPassword(ForgotPasswordRequest request) async {
    await Future.delayed(const Duration(seconds: 1));
    return RepositoryResult.success(null);
  }

  @override
  Future<RepositoryResult<void>> resetPassword(ResetPasswordRequest request) async {
    await Future.delayed(const Duration(seconds: 1));
    return RepositoryResult.success(null);
  }

  @override
  Future<RepositoryResult<void>> verifyEmail(VerifyOtpRequest request) async {
    await Future.delayed(const Duration(seconds: 1));
    return RepositoryResult.success(null);
  }

  @override
  Future<RepositoryResult<void>> changePassword(ChangePasswordRequest request) async {
    await Future.delayed(const Duration(seconds: 1));
    return RepositoryResult.success(null);
  }
}
