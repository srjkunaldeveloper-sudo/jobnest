import 'package:flutter/foundation.dart';
import 'user_model.dart';

/// Response payload received after a successful login.
@immutable
class LoginResponse {
  // TODO: TEMPORARY PLACEHOLDER FIELDS - DO NOT ASSUME BACKEND SCHEMA
  // Wait for the exact POST /api-recruiter/login/ response structure.
  
  // TODO: Verify exact token field name (e.g. 'access_token', 'token', 'jwt').
  // Maintained as 'accessToken' for backward compatibility with MockAuthRepository.
  final String accessToken;
  
  // TODO: Verify if a refresh token is returned and its exact JSON key.
  final String refreshToken;
  
  // TODO: Verify user model fields and JSON structure.
  final UserModel user;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  // TODO: The backend response schema is missing from the OpenAPI contract and must be verified before final mapping.
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      // TODO: BACKEND CONTRACT REQUIRED - Do not assume 'accessToken' or 'refreshToken' keys.
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      // TODO: BACKEND CONTRACT REQUIRED - Do not assume 'user' object structure.
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }

  LoginResponse copyWith({
    String? accessToken,
    String? refreshToken,
    UserModel? user,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginResponse &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.user == user;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode ^ user.hashCode;
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
