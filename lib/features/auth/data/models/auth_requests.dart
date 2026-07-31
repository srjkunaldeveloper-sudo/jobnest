import 'package:flutter/foundation.dart';

/// Request payload for logging in.
@immutable
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  LoginRequest copyWith({String? email, String? password}) {
    return LoginRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginRequest && other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}

/// Request payload for refreshing an access token.
@immutable
class RefreshTokenRequest {
  final String refreshToken;

  const RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRequest(
      refreshToken: json['refreshToken'] as String,
    );
  }

  RefreshTokenRequest copyWith({String? refreshToken}) {
    return RefreshTokenRequest(
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RefreshTokenRequest && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => refreshToken.hashCode;
}

/// Request payload for requesting a password reset email/OTP.
@immutable
class ForgotPasswordRequest {
  final String email;

  const ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequest(email: json['email'] as String);
  }

  ForgotPasswordRequest copyWith({String? email}) {
    return ForgotPasswordRequest(email: email ?? this.email);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ForgotPasswordRequest && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

/// Request payload for resetting a password using an OTP.
@immutable
class ResetPasswordRequest {
  final String email;
  final String otp;
  final String newPassword;

  const ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      };

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequest(
      email: json['email'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
    );
  }

  ResetPasswordRequest copyWith({String? email, String? otp, String? newPassword}) {
    return ResetPasswordRequest(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResetPasswordRequest &&
        other.email == email &&
        other.otp == otp &&
        other.newPassword == newPassword;
  }

  @override
  int get hashCode => email.hashCode ^ otp.hashCode ^ newPassword.hashCode;
}

/// Request payload for verifying an email OTP.
@immutable
class VerifyOtpRequest {
  final String email;
  final String otp;

  const VerifyOtpRequest({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequest(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );
  }

  VerifyOtpRequest copyWith({String? email, String? otp}) {
    return VerifyOtpRequest(
      email: email ?? this.email,
      otp: otp ?? this.otp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VerifyOtpRequest && other.email == email && other.otp == otp;
  }

  @override
  int get hashCode => email.hashCode ^ otp.hashCode;
}

/// Request payload for an authenticated user changing their password.
@immutable
class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequest(
      oldPassword: json['oldPassword'] as String,
      newPassword: json['newPassword'] as String,
    );
  }

  ChangePasswordRequest copyWith({String? oldPassword, String? newPassword}) {
    return ChangePasswordRequest(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChangePasswordRequest &&
        other.oldPassword == oldPassword &&
        other.newPassword == newPassword;
  }

  @override
  int get hashCode => oldPassword.hashCode ^ newPassword.hashCode;
}
