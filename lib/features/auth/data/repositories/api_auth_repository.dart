import '../../../../core/network/api_client.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_requests.dart';
import '../models/auth_responses.dart';

/// The real API implementation of [AuthRepository].
///
/// Uses [ApiClient] for network requests and inherits [BaseRepository]
/// to leverage safe execution and unified error mapping.
class ApiAuthRepository extends BaseRepository implements AuthRepository {
  final ApiClient _apiClient;

  /// Constructor injection of the abstract ApiClient to maintain decoupleability.
  ApiAuthRepository(this._apiClient);

  @override
  Future<RepositoryResult<LoginResponse>> login(LoginRequest request) {
    // Skeleton: Real API call goes here wrapped in executeSafe()
    throw UnimplementedError('API login is not yet implemented.');
  }

  @override
  Future<RepositoryResult<RefreshTokenResponse>> refreshToken(RefreshTokenRequest request) {
    throw UnimplementedError('API refresh token is not yet implemented.');
  }

  @override
  Future<RepositoryResult<void>> logout(String refreshToken) {
    throw UnimplementedError('API logout is not yet implemented.');
  }

  @override
  Future<RepositoryResult<void>> forgotPassword(ForgotPasswordRequest request) {
    throw UnimplementedError('API forgot password is not yet implemented.');
  }

  @override
  Future<RepositoryResult<void>> resetPassword(ResetPasswordRequest request) {
    throw UnimplementedError('API reset password is not yet implemented.');
  }

  @override
  Future<RepositoryResult<void>> verifyEmail(VerifyOtpRequest request) {
    throw UnimplementedError('API verify email is not yet implemented.');
  }

  @override
  Future<RepositoryResult<void>> changePassword(ChangePasswordRequest request) {
    throw UnimplementedError('API change password is not yet implemented.');
  }
}
