import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_text.dart';

class AppChipStyles {
  AppChipStyles._();

  static ChipThemeData theme({bool isDark = false}) {
    return ChipThemeData(
      backgroundColor: isDark 
          ? AppColors.darkCard 
          : AppColors.primaryLight,
      disabledColor: isDark ? Colors.transparent : Colors.grey.shade100,
      selectedColor: AppColors.primary,
      secondarySelectedColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      labelStyle: AppTypography.small.copyWith(
        color: isDark ? AppColors.darkPrimaryText : AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: AppTypography.small.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.chip,
        side: BorderSide(
          color: isDark 
              ? AppColors.darkBorder 
              : AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
    );
  }
}
