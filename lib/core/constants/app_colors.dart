import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // JobNest Design System Colors (Light / Default)
  static const Color primary = Color(0xFF4F6DFF);
  static const Color primaryLight = Color(0xFFEEF2FF);
  static const Color secondaryPurple = Color(0xFF7C4DFF);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color background = Color(0xFFF8FAFC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFEDF2F7);

  // Shared backward compatibility mapping
  static const Color lightBackground = background;
  static const Color lightSurface = card;
  static const Color lightPrimary = primary;
  static const Color lightPrimaryText = textPrimary;
  static const Color lightSecondaryText = textSecondary;
  static const Color lightSuccess = success;
  static const Color lightDanger = danger;

  // Dark Theme Mapping (Cohesive with Enterprise theme)
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkSurface = darkCard; // Keep darkSurface for backward compatibility
  static const Color darkPrimary = Color(0xFF4F6DFF);
  static const Color darkPrimaryText = Color(0xFFF8FAFC);
  static const Color darkSecondaryText = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkDivider = Color(0xFF1E293B);
  static const Color darkSuccess = Color(0xFF22C55E);
  static const Color darkDanger = Color(0xFFEF4444);

  static const Color borderLight = border;
  static const Color borderDark = darkBorder;
}