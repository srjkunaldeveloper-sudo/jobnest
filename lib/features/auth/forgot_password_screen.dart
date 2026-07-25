import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_config.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';

class ForgotPasswordContent extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onSendOtp;

  const ForgotPasswordContent({
    super.key,
    required this.onBack,
    required this.onSendOtp,
  });

  @override
  State<ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<ForgotPasswordContent> {
  final TextEditingController _emailController = TextEditingController();

  void _handleSendOtp() {
    final email = _emailController.text.trim();
    
    // ===== FRONTEND MODE =====
    // Abhi frontend mode me email validation bypass kar rahe hain taaki flow test ho sake.
    // ===== BACKEND TODO =====
    // TODO: Yaha Forgot Password / OTP send karne wali API call hogi.
    if (!AppConfig.kFrontendMode) {
      if (email.isEmpty || !email.contains('@')) return;
    }

    widget.onSendOtp(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: widget.onBack,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surfaceContainerHighest,
            ),
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        AppSpacing.h24,
        Text(
          "Forgot Password",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            letterSpacing: -0.3,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.h8,
        Text(
          "Enter your registered email address.\nWe'll send you a verification code.",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        AppSpacing.h32,

        AppTextField(
          controller: _emailController,
          hint: "Email Address",
          keyboardType: TextInputType.emailAddress,
        ),
        
        AppSpacing.h24,
        AppButton(
          text: "Send OTP",
          onPressed: _handleSendOtp,
        ),
        AppSpacing.h16,
        
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurfaceVariant,
            ),
            onPressed: widget.onBack,
            child: const Text(
              "Back to Login",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
