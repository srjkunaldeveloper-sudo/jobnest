import 'package:flutter/material.dart';

/// Centralized responsive breakpoints for JobNest UI Architecture.
/// Follows enterprise standard breakpoints (e.g., Tailwind/Bootstrap inspired).
class AppBreakpoints {
  AppBreakpoints._();

  // Mobile: < 600
  static const double mobileMax = 599.9;

  // Tablet: >= 600 and < 1024
  static const double tabletMin = 600.0;
  static const double tabletMax = 1023.9;

  // Desktop: >= 1024
  static const double desktopMin = 1024.0;

  /// Returns true if the screen width is considered Mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= mobileMax;
  }

  /// Returns true if the screen width is considered Tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletMin && width <= tabletMax;
  }

  /// Returns true if the screen width is considered Desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopMin;
  }
}
