import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppText {
  AppText._();

  static TextStyle h1 = GoogleFonts.manrope(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.lightPrimaryText,
  );

  static TextStyle h2 = GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.lightPrimaryText,
  );

  static TextStyle h3 = GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.lightPrimaryText,
  );

  static TextStyle body = GoogleFonts.manrope(
    fontSize: 15,
    color: AppColors.lightSecondaryText,
  );

  static TextStyle button = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle caption = GoogleFonts.manrope(
    fontSize: 12,
    color: AppColors.lightSecondaryText,
  );
}