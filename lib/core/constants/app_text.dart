import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppText {
  AppText._();

  // ── Headings ──────────────────────────────────────────────────────────────
  static TextStyle h1 = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.lightPrimaryText,
  );

  static TextStyle h2 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.3,
    color: AppColors.lightPrimaryText,
  );

  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.2,
    color: AppColors.lightPrimaryText,
  );

  // ── Section titles (dashboard widget headers) ─────────────────────────────
  static TextStyle sectionTitle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.1,
    color: AppColors.lightPrimaryText,
  );

  // ── Body ──────────────────────────────────────────────────────────────────
  static TextStyle body = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.lightSecondaryText,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.lightSecondaryText,
  );

  // ── Labels & Chips ────────────────────────────────────────────────────────
  static TextStyle label = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.lightPrimaryText,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.lightSecondaryText,
  );

  // ── Button ────────────────────────────────────────────────────────────────
  static TextStyle button = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.1,
    color: Colors.white,
  );

  // ── Caption / hint ────────────────────────────────────────────────────────
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.lightSecondaryText,
  );

  // ── Responsive greeting size helper ──────────────────────────────────────
  /// Returns greeting font size based on screen width:
  ///   Desktop (>800px): 28 | Tablet (480–800px): 22 | Mobile (<480px): 18
  static double greetingFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return 28.0;
    if (width > 480) return 22.0;
    return 18.0;
  }

  /// Company subtitle size per breakpoint: 14 / 13 / 12
  static double companyFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return 14.0;
    if (width > 480) return 13.0;
    return 12.0;
  }
}