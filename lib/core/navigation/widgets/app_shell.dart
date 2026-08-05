import 'package:flutter/material.dart';
import '../providers/navigation_provider.dart';
import 'app_bottom_navigation.dart';
import 'app_sidebar.dart';
import 'app_navigation_rail.dart';
import 'app_top_bar.dart';
import '../../constants/app_breakpoints.dart';

class AppShell extends StatefulWidget {
  final NavigationProvider provider;
  final List<Widget> screens;

  AppShell({
    super.key,
    required this.provider,
    required this.screens,
  }) {
    assert(
      screens.length == provider.items.length,
      'The number of screens must match the number of navigation items.',
    );
  }

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.provider,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= AppBreakpoints.desktopMin;
            final isTablet = constraints.maxWidth >= AppBreakpoints.tabletMin && !isDesktop;

            if (isDesktop) {
              return Scaffold(
                body: Row(
                  children: [
                    AppSidebar(provider: widget.provider),
                    Expanded(
                      child: Column(
                        children: [
                          const AppTopBar(),
                          Expanded(
                            child: IndexedStack(
                              index: widget.provider.currentIndex,
                              children: widget.screens,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (isTablet) {
              return Scaffold(
                body: Row(
                  children: [
                    AppNavigationRail(provider: widget.provider),
                    const VerticalDivider(width: 1, thickness: 1),
                    Expanded(
                      child: Column(
                        children: [
                          const AppTopBar(),
                          Expanded(
                            child: IndexedStack(
                              index: widget.provider.currentIndex,
                              children: widget.screens,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Mobile layout
              return Scaffold(
                appBar: const AppTopBar(),
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: Builder(
                        builder: (context) {
                          final mediaQuery = MediaQuery.of(context);
                          return MediaQuery(
                            data: mediaQuery.copyWith(
                              padding: mediaQuery.padding.copyWith(
                                bottom: mediaQuery.padding.bottom + 92,
                              ),
                            ),
                            child: IndexedStack(
                              index: widget.provider.currentIndex,
                              children: widget.screens,
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 16 + MediaQuery.of(context).padding.bottom,
                      child: AppBottomNavigation(
                        provider: widget.provider,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
