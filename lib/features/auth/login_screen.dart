import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jobnest/core/constants/app_config.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';

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
    
    // ===== FRONTEND MODE =====
    // Abhi frontend mode me validation skip kar rahe hain dummy testing ke liye.
    // ===== BACKEND TODO =====
    // TODO: Yaha par Firebase Phone Auth API call karni hai.
    // TODO: API se success response aane ke baad hi OTP screen par bhejna.
    if (!AppConfig.kFrontendMode) {
      if (number.length != 10) {
        setState(() {
          _mobileError = "Enter a valid 10-digit mobile number";
        });
        return;
      }
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Premium Logo Area
        Center(
          child: Column(
            children: [
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Icon(
                  Icons.work_rounded,
                  color: theme.colorScheme.onPrimary,
                  size: 32,
                ),
              ),
              AppSpacing.h24,
              Text(
                "JobNest",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 28,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.h8,
              Text(
                "Hire smarter with AI powered recruitment",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        AppSpacing.h48,
        Text(
          "Welcome Back 👋",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            letterSpacing: -0.3,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.h8,
        Text(
          "Login to continue to your dashboard",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        AppSpacing.h32,
        
        /// Segment Control
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.dividerColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    isMobileLogin = true;
                    _mobileError = null;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isMobileLogin
                          ? theme.colorScheme.surface
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isMobileLogin ? theme.dividerColor : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Mobile",
                        style: TextStyle(
                          color: isMobileLogin
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isMobileLogin = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: !isMobileLogin
                          ? theme.colorScheme.surface
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: !isMobileLogin ? theme.dividerColor : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: !isMobileLogin
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
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
                      icon: Icons.phone_outlined,
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
                      onPressed: () {
                        // ===== FRONTEND MODE =====
                        // Abhi yaha dummy navigation/logic nahi hai direct auth flow switch karenge.
                        // ===== BACKEND TODO =====
                        // TODO: Login API trigger karni hai. Error response ko Snackbar me show karna.
                      },
                    ),
                  ],
                ),
        ),
        
      ],
    );
  }
}
