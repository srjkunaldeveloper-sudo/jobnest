import 'package:flutter/material.dart';
import '../responsive_layout.dart';
import '../../constants/app_breakpoints.dart';

/// A standard page scaffold that enforces maximum width and responsive padding.
/// Use this for inner screens (e.g., Settings, Job Details, Forms) to maintain
/// a consistent enterprise SaaS look.
class AppPageScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool showBackButton;
  final double maxWidth;

  const AppPageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.showBackButton = true,
    this.maxWidth = 800.0, // Standard readable width for forms/settings
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: showBackButton,
        actions: actions,
        centerTitle: false,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= AppBreakpoints.desktopMin;
            final isTablet = constraints.maxWidth >= AppBreakpoints.tabletMin && !isDesktop;
            
            final double horizontalPadding = isDesktop ? 32.0 : (isTablet ? 24.0 : 16.0);

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 24.0,
                  ),
                  child: body,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
