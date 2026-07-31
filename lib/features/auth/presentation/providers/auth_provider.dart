import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/models/auth_requests.dart';
import 'auth_state.dart';

/// Provider responsible for managing Authentication State.
/// 
/// Strictly acts as a state manager, delegating business logic and token
/// management directly to the injected [AuthRepository].
class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;
  AuthState _state = const AuthState();

  AuthProvider(this._repository);

  /// Exposes the current authentication state.
  AuthState get state => _state;

  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Attempts to log the user in using their credentials.
  Future<void> login(LoginRequest request) async {
    _setState(_state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _repository.login(request);

    if (result.isSuccess && result.data != null) {
      _setState(_state.copyWith(
        status: AuthStatus.authenticated,
        user: result.data!.user,
      ));
    } else {
      _setState(_state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? 'Login failed.',
      ));
    }
  }

  /// Refreshes the access token using the stored refresh token.
  Future<void> refreshToken(RefreshTokenRequest request) async {
    _setState(_state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _repository.refreshToken(request);

    if (result.isSuccess) {
      // Revert to authenticated without dropping user data
      _setState(_state.copyWith(status: AuthStatus.authenticated));
    } else {
      _setState(const AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Session expired. Please log in again.',
      ));
    }
  }

  /// Logs the user out and clears the session.
  Future<void> logout(String refreshToken) async {
    _setState(_state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _repository.logout(refreshToken);

    if (result.isSuccess) {
      _setState(const AuthState(status: AuthStatus.unauthenticated));
    } else {
      // Even if API call fails, we forcefully unauthenticate locally.
      _setState(AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: result.errorMessage ?? 'Logout failed on server.',
      ));
    }
  }

  /// Requests a password reset link/OTP to be sent to the user's email.
  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    _setState(_state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _repository.forgotPassword(request);

    if (result.isSuccess) {
      _setState(_state.copyWith(status: AuthStatus.initial));
    } else {
      _setState(_state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to request password reset.',
      ));
    }
  }

  /// Resets the user's password using the provided OTP.
  Future<void> resetPassword(ResetPasswordRequest request) async {
    _setState(_state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _repository.resetPassword(request);

    if (result.isSuccess) {
      _setState(_state.copyWith(status: AuthStatus.initial));
    } else {
      _setState(_state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? 'Password reset failed.',
      ));
    }
  }

  /// Verifies the user's email address using an OTP.
  Future<void> verifyEmail(VerifyOtpRequest request) async {
    _setState(_state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _repository.verifyEmail(request);

    if (result.isSuccess) {
      _setState(_state.copyWith(status: AuthStatus.initial));
    } else {
      _setState(_state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? 'Email verification failed.',
      ));
    }
  }

  /// Changes the password of an already authenticated user.
  Future<void> changePassword(ChangePasswordRequest request) async {
    _setState(_state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _repository.changePassword(request);

    if (result.isSuccess) {
      _setState(_state.copyWith(status: AuthStatus.authenticated));
    } else {
      _setState(_state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to change password.',
      ));
    }
  }
}
