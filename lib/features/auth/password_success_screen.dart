import '../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_button.dart';

class PasswordSuccessContent extends StatelessWidget {
  final VoidCallback onBackToLogin;

  const PasswordSuccessContent({
    super.key,
    required this.onBackToLogin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withValues(alpha: 0.1),
          ),
          child: const Icon(
            AppIcons.check_circle_rounded,
            color: Colors.green,
            size: 48,
          ),
        ),
        AppSpacing.h32,
        Text(
          "Password Reset Successfully",
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            letterSpacing: -0.3,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.h16,
        Text(
          "Your password has been changed successfully. You can now log in with your new password.",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        AppSpacing.h48,
        AppButton(
          text: "Return to Login",
          onPressed: onBackToLogin,
        ),
      ],
    );
  }
}
