import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_text.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightPrimaryText,
        onSurfaceVariant: AppColors.lightSecondaryText,
        error: AppColors.lightDanger,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.lightPrimaryText),
        titleTextStyle: AppText.h3.copyWith(color: AppColors.lightPrimaryText),
      ),
      textTheme: TextTheme(
        headlineLarge: AppText.h1.copyWith(color: AppColors.lightPrimaryText),
        headlineMedium: AppText.h2.copyWith(color: AppColors.lightPrimaryText),
        headlineSmall: AppText.h3.copyWith(color: AppColors.lightPrimaryText),
        bodyLarge: AppText.body.copyWith(color: AppColors.lightPrimaryText),
        bodyMedium: AppText.body.copyWith(color: AppColors.lightPrimaryText),
        bodySmall: AppText.caption.copyWith(color: AppColors.lightSecondaryText),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        hintStyle: AppText.body.copyWith(color: AppColors.lightSecondaryText),
        border: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2.0),
        ),
      ),
      dividerColor: AppColors.borderLight,
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
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
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkPrimaryText,
        onSurfaceVariant: AppColors.darkSecondaryText,
        error: AppColors.darkDanger,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.darkPrimaryText),
        titleTextStyle: AppText.h3.copyWith(color: AppColors.darkPrimaryText),
      ),
      textTheme: TextTheme(
        headlineLarge: AppText.h1.copyWith(color: AppColors.darkPrimaryText),
        headlineMedium: AppText.h2.copyWith(color: AppColors.darkPrimaryText),
        headlineSmall: AppText.h3.copyWith(color: AppColors.darkPrimaryText),
        bodyLarge: AppText.body.copyWith(color: AppColors.darkPrimaryText),
        bodyMedium: AppText.body.copyWith(color: AppColors.darkPrimaryText),
        bodySmall: AppText.caption.copyWith(color: AppColors.darkSecondaryText),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        hintStyle: AppText.body.copyWith(color: AppColors.darkSecondaryText),
        border: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2.0),
        ),
      ),
      dividerColor: AppColors.borderDark,
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 1, // Material 3 uses elevation overlays automatically
        shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
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