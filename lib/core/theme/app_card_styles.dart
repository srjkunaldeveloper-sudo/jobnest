import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import 'app_shadows.dart';

class AppCardStyles {
  AppCardStyles._();

  static CardThemeData theme({bool isDark = false}) {
    return CardThemeData(
      color: isDark ? AppColors.darkCard : Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.04),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.card,
        side: BorderSide(
          color: isDark ? AppColors.darkBorder.withValues(alpha: 0.5) : AppColors.border.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
    );
  }

  static BoxDecoration decoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return BoxDecoration(
      color: isDark ? AppColors.darkCard : Colors.white,
      borderRadius: AppRadius.card,
      border: Border.all(
        color: isDark ? AppColors.darkBorder.withValues(alpha: 0.3) : AppColors.border.withValues(alpha: 0.3),
        width: 1.0,
      ),
      boxShadow: const [
        AppShadows.soft,
      ],
    );
  }
}
