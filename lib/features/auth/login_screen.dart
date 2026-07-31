import '../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jobnest/core/constants/app_config.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/services/session_manager.dart';
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';
import 'package:jobnest/features/auth/signup_screen.dart';
import 'package:jobnest/main.dart';

class LoginContent extends StatefulWidget {
  final VoidCallback onForgotPassword;
  final Function(String) onSendMobileOtp;

  const LoginContent({
    super.key,
    required this.onForgotPassword,
    required this.onSendMobileOtp,
  });

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  bool isMobileLogin = true;
  final TextEditingController _mobileController = TextEditingController();
  String? _mobileError;

  void _handleSendOtp() {
    final number = _mobileController.text.trim();
    if (number.length != 10) {
      setState(() {
        _mobileError = "Please enter a valid 10-digit mobile number";
      });
      return;
    }
    setState(() {
      _mobileError = null;
    });
    widget.onSendMobileOtp(number);
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      key: const ValueKey('login_content'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Header Section
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              AppIcons.work_rounded,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        AppSpacing.h24,
        Text(
          AppConfig.appName,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        AppSpacing.h4,
        Text(
          "Manage jobs, candidates & interviews",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        AppSpacing.h32,

        /// Toggle Tabs
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    isMobileLogin = true;
                    _mobileError = null;
                  }),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isMobileLogin ? theme.colorScheme.surface : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isMobileLogin
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      "Mobile OTP",
                      style: TextStyle(
                        fontWeight: isMobileLogin ? FontWeight.bold : FontWeight.normal,
                        color: isMobileLogin ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    isMobileLogin = false;
                    _mobileError = null;
                  }),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !isMobileLogin ? theme.colorScheme.surface : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: !isMobileLogin
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      "Work Email",
                      style: TextStyle(
                        fontWeight: !isMobileLogin ? FontWeight.bold : FontWeight.normal,
                        color: !isMobileLogin ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.h32,

        /// Form Fields
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
          child: isMobileLogin
              ? Column(
                  key: const ValueKey('mobile_form'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      controller: _mobileController,
                      hint: "Mobile Number",
                      icon: AppIcons.phone_outlined,
                      keyboardType: TextInputType.number,
                      prefixText: "+91 ",
                      maxLength: 10,
                      errorText: _mobileError,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    AppSpacing.h24,
                    AppButton(
                      text: "Send OTP",
                      onPressed: _handleSendOtp,
                    ),
                  ],
                )
              : Column(
                  key: const ValueKey('email_form'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppTextField(
                      hint: "Work Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    AppSpacing.h16,
                    const AppTextField(
                      hint: "Password",
                      isPassword: true,
                    ),
                    AppSpacing.h8,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        onPressed: widget.onForgotPassword,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    AppSpacing.h16,
                    AppButton(
                      text: "Login",
                      onPressed: () async {
                        // ===== FRONTEND MODE =====
                        // ===== BACKEND TODO =====
                        // TODO: Login API trigger karni hai. Error response ko Snackbar me show karna.
                        // TODO: Future authentication backend yaha connect hoga.
                        // TODO: Session token validation backend se hogi.
                        await SessionManager.instance.setLoginState(true);
                        if (!context.mounted) return;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const MainDashboard()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
        ),
        AppSpacing.h24,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                );
              },
              child: Text(
                "Sign Up",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
