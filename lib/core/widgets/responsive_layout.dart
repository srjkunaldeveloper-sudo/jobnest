import 'package:flutter/material.dart';
import '../constants/app_breakpoints.dart';

/// A wrapper widget that provides responsive layout capabilities
/// based on the [AppBreakpoints] system.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.desktopMin) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= AppBreakpoints.tabletMin) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
