import 'package:flutter/foundation.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/data/models/auth_requests.dart';

/// Defines the possible states during the splash/startup sequence.
enum SplashStatus {
  initial,
  checking,
  authenticated,
  unauthenticated,
  onboarding,
  error,
}

/// Represents the state of the splash screen logic.
class SplashState {
  final SplashStatus status;
  final String? errorMessage;

  const SplashState({
    this.status = SplashStatus.initial,
    this.errorMessage,
  });

  SplashState copyWith({
    SplashStatus? status,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Provider responsible for checking the user's session on app startup.
class SplashProvider extends ChangeNotifier {
  final AuthRepository _repository;
  final SecureStorage _secureStorage;

  SplashState _state = const SplashState();

  SplashProvider(this._repository, this._secureStorage);

  SplashState get state => _state;

  void _setState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Validates the existing session by checking for a refresh token and attempting a refresh.
  Future<void> checkSession() async {
    _setState(_state.copyWith(status: SplashStatus.checking, errorMessage: null));

    try {
      final refreshToken = await _secureStorage.read(StorageKeys.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        _setState(const SplashState(status: SplashStatus.unauthenticated));
        return;
      }

      final request = RefreshTokenRequest(refreshToken: refreshToken);
      final result = await _repository.refreshToken(request);

      if (result.isSuccess) {
        _setState(const SplashState(status: SplashStatus.authenticated));
      } else {
        _setState(const SplashState(status: SplashStatus.unauthenticated));
      }
    } catch (e) {
      _setState(const SplashState(
        status: SplashStatus.error,
        errorMessage: 'An error occurred while verifying the session.',
      ));
    }
  }
}
