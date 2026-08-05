import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 34,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle sectionTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle cardTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static TextStyle small = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle button = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

// Keep AppText for backward compatibility so existing code doesn't break
class AppText {
  AppText._();

  static TextStyle get h1 => AppTypography.h1;
  static TextStyle get h2 => AppTypography.h2;
  static TextStyle get h3 => AppTypography.h3;
  static TextStyle get sectionTitle => AppTypography.sectionTitle;
  static TextStyle get body => AppTypography.body;
  static TextStyle get bodyMedium => AppTypography.body; // Map to body (Medium, 15)
  static TextStyle get label => AppTypography.cardTitle;
  static TextStyle get labelSmall => AppTypography.small;
  static TextStyle get button => AppTypography.button;
  static TextStyle get caption => AppTypography.caption;

  static double greetingFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return 28.0;
    if (width > 480) return 22.0;
    return 18.0;
  }

  static double companyFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return 14.0;
    if (width > 480) return 13.0;
    return 12.0;
  }
}
