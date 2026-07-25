import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_config.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';

class CreateNewPasswordContent extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onSuccess;

  const CreateNewPasswordContent({
    super.key,
    required this.onBack,
    required this.onSuccess,
  });

  @override
  State<CreateNewPasswordContent> createState() => _CreateNewPasswordContentState();
}

class _CreateNewPasswordContentState extends State<CreateNewPasswordContent> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;
  bool _hasSpecial = false;

  bool get _isPasswordValid =>
      _hasMinLength && _hasUppercase && _hasLowercase && _hasDigit && _hasSpecial;

  bool get _canContinue {
    // ===== FRONTEND MODE =====
    // Abhi frontend mode me password validation bypass kar rahe hain taaki flow test ho sake.
    // ===== BACKEND TODO =====
    // TODO: Yaha par password reset API call hogi.
    if (AppConfig.kFrontendMode) return true;
    
    return _isPasswordValid &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _confirmController.text;
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _confirmController.addListener(() => setState(() {}));
  }

  void _validatePassword() {
    final pass = _passwordController.text;
    setState(() {
      _hasMinLength = pass.length >= 8;
      _hasUppercase = pass.contains(RegExp(r'[A-Z]'));
      _hasLowercase = pass.contains(RegExp(r'[a-z]'));
      _hasDigit = pass.contains(RegExp(r'[0-9]'));
      _hasSpecial = pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Widget _buildValidationRow(String text, bool isValid, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: isValid ? Colors.green : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          AppSpacing.w8,
          Text(
            text,
            style: AppText.caption.copyWith(
              color: isValid ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
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
          "Create New Password",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            letterSpacing: -0.3,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.h8,
        Text(
          "Your new password must be unique from those previously used.",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        AppSpacing.h32,

        AppTextField(
          controller: _passwordController,
          hint: "New Password",
          isPassword: true,
        ),
        AppSpacing.h16,
        AppTextField(
          controller: _confirmController,
          hint: "Confirm Password",
          isPassword: true,
        ),
        
        AppSpacing.h24,
        Text(
          "Password must contain at least:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        AppSpacing.h12,
        _buildValidationRow("8 characters", _hasMinLength, theme),
        _buildValidationRow("1 uppercase letter", _hasUppercase, theme),
        _buildValidationRow("1 lowercase letter", _hasLowercase, theme),
        _buildValidationRow("1 number", _hasDigit, theme),
        _buildValidationRow("1 special character", _hasSpecial, theme),
        
        AppSpacing.h24,
        AppButton(
          text: "Continue",
          onPressed: _canContinue ? widget.onSuccess : null,
        ),
      ],
    );
  }
}
