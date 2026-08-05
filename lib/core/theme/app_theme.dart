import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_text.dart';
import 'app_input_decoration.dart';
import 'app_card_styles.dart';
import 'app_chip_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.card,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        error: AppColors.danger,
        outline: AppColors.border,
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => const Icon(LucideIcons.arrowLeft),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.card,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: AppTypography.h3.copyWith(color: AppColors.textPrimary),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.h1.copyWith(color: AppColors.textPrimary),
        headlineMedium: AppTypography.h2.copyWith(color: AppColors.textPrimary),
        headlineSmall: AppTypography.h3.copyWith(color: AppColors.textPrimary),
        titleLarge: AppTypography.sectionTitle.copyWith(color: AppColors.textPrimary),
        titleMedium: AppTypography.cardTitle.copyWith(color: AppColors.textPrimary),
        bodyLarge: AppTypography.body.copyWith(color: AppColors.textPrimary),
        bodyMedium: AppTypography.body.copyWith(color: AppColors.textPrimary),
        bodySmall: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        labelLarge: AppTypography.button.copyWith(color: AppColors.textPrimary),
        labelSmall: AppTypography.small.copyWith(color: AppColors.textSecondary),
      ),
      inputDecorationTheme: AppInputDecoration.theme(isDark: false),
      dividerColor: AppColors.divider,
      cardTheme: AppCardStyles.theme(isDark: false),
      chipTheme: AppChipStyles.theme(isDark: false),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.floatingButton,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.card,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.dialog,
        ),
        titleTextStyle: AppTypography.h3.copyWith(color: AppColors.textPrimary),
        contentTextStyle: AppTypography.body.copyWith(color: AppColors.textSecondary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.card,
        elevation: 10,
        showDragHandle: true,
        dragHandleColor: AppColors.textSecondary.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.bottomSheetVal),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.card,
        elevation: 8,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTypography.small.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: AppTypography.small,
        type: BottomNavigationBarType.fixed,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        surface: AppColors.darkCard,
        onSurface: AppColors.darkPrimaryText,
        onSurfaceVariant: AppColors.darkSecondaryText,
        error: AppColors.darkDanger,
        outline: AppColors.darkBorder,
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => const Icon(LucideIcons.arrowLeft),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkCard,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.darkPrimaryText),
        titleTextStyle: AppTypography.h3.copyWith(color: AppColors.darkPrimaryText),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.h1.copyWith(color: AppColors.darkPrimaryText),
        headlineMedium: AppTypography.h2.copyWith(color: AppColors.darkPrimaryText),
        headlineSmall: AppTypography.h3.copyWith(color: AppColors.darkPrimaryText),
        titleLarge: AppTypography.sectionTitle.copyWith(color: AppColors.darkPrimaryText),
        titleMedium: AppTypography.cardTitle.copyWith(color: AppColors.darkPrimaryText),
        bodyLarge: AppTypography.body.copyWith(color: AppColors.darkPrimaryText),
        bodyMedium: AppTypography.body.copyWith(color: AppColors.darkPrimaryText),
        bodySmall: AppTypography.caption.copyWith(color: AppColors.darkSecondaryText),
        labelLarge: AppTypography.button.copyWith(color: AppColors.darkPrimaryText),
        labelSmall: AppTypography.small.copyWith(color: AppColors.darkSecondaryText),
      ),
      inputDecorationTheme: AppInputDecoration.theme(isDark: true),
      dividerColor: AppColors.darkDivider,
      cardTheme: AppCardStyles.theme(isDark: true),
      chipTheme: AppChipStyles.theme(isDark: true),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.floatingButton,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkCard,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.dialog,
        ),
        titleTextStyle: AppTypography.h3.copyWith(color: AppColors.darkPrimaryText),
        contentTextStyle: AppTypography.body.copyWith(color: AppColors.darkSecondaryText),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkCard,
        elevation: 10,
        showDragHandle: true,
        dragHandleColor: AppColors.darkSecondaryText.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.bottomSheetVal),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkCard,
        elevation: 8,
        selectedItemColor: AppColors.darkPrimary,
        unselectedItemColor: AppColors.darkSecondaryText,
        selectedLabelStyle: AppTypography.small.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: AppTypography.small,
        type: BottomNavigationBarType.fixed,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}