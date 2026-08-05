import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_text.dart';

class AppButtonStyles {
  AppButtonStyles._();

  static ButtonStyle primary({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      shadowColor: AppColors.primary.withValues(alpha: 0.2),
      minimumSize: const Size(88, 56), // Large height
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.button,
      ),
      textStyle: AppTypography.button,
    );
  }

  static ButtonStyle secondary({bool isDark = false}) {
    return OutlinedButton.styleFrom(
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      foregroundColor: AppColors.primary,
      elevation: 0,
      side: const BorderSide(color: AppColors.border, width: 1.5),
      minimumSize: const Size(88, 56),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.button,
      ),
      textStyle: AppTypography.button,
    );
  }

  static ButtonStyle danger({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.danger,
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size(88, 56),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.button,
      ),
      textStyle: AppTypography.button,
    );
  }
}
