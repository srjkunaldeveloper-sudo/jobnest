import 'package:flutter/foundation.dart';
import 'user_model.dart';

/// Response payload received after a successful login.
@immutable
class LoginResponse {
  /// The access token to be used for authentication.
  final String accessToken;

  /// The refresh token to be used to obtain a new access token.
  final String refreshToken;

  /// The authenticated recruiter user details.
  final UserModel user;

  /// Whether the user needs to complete their profile setup.
  final bool requiresProfileCompletion;

  /// The redirect URL path (e.g. '/dashboard') after login.
  final String? redirectTo;

  /// Flag indicating if this is a newly registered user.
  final bool isNewUser;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    this.requiresProfileCompletion = false,
    this.redirectTo,
    this.isNewUser = false,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      requiresProfileCompletion: json['requires_profile_completion'] as bool? ?? false,
      redirectTo: json['redirect_to'] as String?,
      isNewUser: json['is_new_user'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': accessToken,
      'refresh': refreshToken,
      'user': user.toJson(),
      'requires_profile_completion': requiresProfileCompletion,
      'redirect_to': redirectTo,
      'is_new_user': isNewUser,
    };
  }

  LoginResponse copyWith({
    String? accessToken,
    String? refreshToken,
    UserModel? user,
    bool? requiresProfileCompletion,
    String? redirectTo,
    bool? isNewUser,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      requiresProfileCompletion: requiresProfileCompletion ?? this.requiresProfileCompletion,
      redirectTo: redirectTo ?? this.redirectTo,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginResponse &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.user == user &&
        other.requiresProfileCompletion == requiresProfileCompletion &&
        other.redirectTo == redirectTo &&
        other.isNewUser == isNewUser;
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^
      refreshToken.hashCode ^
      user.hashCode ^
      requiresProfileCompletion.hashCode ^
      (redirectTo?.hashCode ?? 0) ^
      isNewUser.hashCode;
}

/// Response payload received after a successful token refresh.
@immutable
class RefreshTokenResponse {
  final String accessToken;
  final String refreshToken;

  const RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  RefreshTokenResponse copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return RefreshTokenResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RefreshTokenResponse &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
