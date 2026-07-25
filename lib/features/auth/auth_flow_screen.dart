import 'package:flutter/material.dart';

import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/auth/login_screen.dart';
import 'package:jobnest/features/auth/forgot_password_screen.dart';
import 'package:jobnest/features/auth/otp_screen.dart';
import 'package:jobnest/features/auth/create_new_password_screen.dart';
import 'package:jobnest/features/auth/password_success_screen.dart';
import 'package:jobnest/main.dart';

enum AuthStep {
  login,
  forgotPassword,
  verifyMobileOtp,
  verifyEmailOtp,
  newPassword,
  success,
}

class AuthFlowScreen extends StatefulWidget {
  const AuthFlowScreen({super.key});

  @override
  State<AuthFlowScreen> createState() => _AuthFlowScreenState();
}

class _AuthFlowScreenState extends State<AuthFlowScreen> {
  AuthStep _currentStep = AuthStep.login;
  String _contactInfo = "";

  void _navigateTo(AuthStep step, {String? contactInfo}) {
    setState(() {
      _currentStep = step;
      if (contactInfo != null) {
        _contactInfo = contactInfo;
      }
    });
  }

  void _goBack() {
    setState(() {
      switch (_currentStep) {
        case AuthStep.forgotPassword:
        case AuthStep.verifyMobileOtp:
          _currentStep = AuthStep.login;
          break;
        case AuthStep.verifyEmailOtp:
          _currentStep = AuthStep.forgotPassword;
          break;
        case AuthStep.newPassword:
          _currentStep = AuthStep.verifyEmailOtp;
          break;
        case AuthStep.success:
          _currentStep = AuthStep.login;
          break;
        default:
          break;
      }
    });
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case AuthStep.login:
        return LoginContent(
          key: const ValueKey('login'),
          onForgotPassword: () => _navigateTo(AuthStep.forgotPassword),
          onSendMobileOtp: (mobile) => _navigateTo(AuthStep.verifyMobileOtp, contactInfo: mobile),
        );
      case AuthStep.forgotPassword:
        return ForgotPasswordContent(
          key: const ValueKey('forgotPassword'),
          onBack: _goBack,
          onSendOtp: (email) => _navigateTo(AuthStep.verifyEmailOtp, contactInfo: email),
        );
      case AuthStep.verifyMobileOtp:
        return OtpContent(
          key: const ValueKey('verifyMobileOtp'),
          title: "Verify OTP",
          subtitlePrefix: "Enter the 6-digit code sent to\n",
          contactInfo: _contactInfo,
          buttonText: "Verify & Login",
          onBack: _goBack,
          onVerify: () {
            // End of mobile flow
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainDashboard()),
            );
          },
        );
      case AuthStep.verifyEmailOtp:
        return OtpContent(
          key: const ValueKey('verifyEmailOtp'),
          title: "Verify Email OTP",
          subtitlePrefix: "Enter the 6-digit code sent to\n",
          contactInfo: _contactInfo,
          buttonText: "Verify",
          onBack: _goBack,
          onVerify: () => _navigateTo(AuthStep.newPassword),
        );
      case AuthStep.newPassword:
        return CreateNewPasswordContent(
          key: const ValueKey('newPassword'),
          onBack: _goBack,
          onSuccess: () => _navigateTo(AuthStep.success),
        );
      case AuthStep.success:
        return PasswordSuccessContent(
          key: const ValueKey('success'),
          onBackToLogin: () => _navigateTo(AuthStep.login),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: AppCard(
                padding: EdgeInsets.zero, // Padding will be handled inside AnimatedSize wrapper
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  alignment: Alignment.topCenter,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: _buildCurrentStep(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
