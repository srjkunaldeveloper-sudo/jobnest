import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_text.dart';

class AppInputDecoration {
  AppInputDecoration._();

  static InputDecorationTheme theme({bool isDark = false}) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isDark ? AppColors.darkCard : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      hintStyle: AppTypography.body.copyWith(
        color: isDark ? AppColors.darkSecondaryText : AppColors.textSecondary,
      ),
      labelStyle: AppTypography.body.copyWith(
        color: isDark ? AppColors.darkSecondaryText : AppColors.textSecondary,
      ),
      errorStyle: AppTypography.small.copyWith(
        color: AppColors.danger,
      ),
      border: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: 2.0,
        ),
      ),
    );
  }

  static InputDecoration style(BuildContext context, {
    String? hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      errorText: errorText,
      filled: true,
      fillColor: isDark ? AppColors.darkCard : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      hintStyle: AppTypography.body.copyWith(
        color: isDark ? AppColors.darkSecondaryText : AppColors.textSecondary,
      ),
      labelStyle: AppTypography.body.copyWith(
        color: isDark ? AppColors.darkSecondaryText : AppColors.textSecondary,
      ),
      errorStyle: AppTypography.small.copyWith(
        color: AppColors.danger,
      ),
      border: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: 2.0,
        ),
      ),
    );
  }
}
