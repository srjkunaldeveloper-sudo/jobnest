import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/features/dashboard/home_screen.dart';
import 'package:jobnest/features/jobs/jobs_screen.dart';
import 'package:jobnest/features/candidates/candidates_screen.dart';
import 'package:jobnest/features/services/services_screen.dart';
import 'package:jobnest/features/profile/profile_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'features/auth/auth_flow_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const JobNestApp(),
    ),
  );
}

class JobNestApp extends StatelessWidget {
  const JobNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        if (!themeProvider.isInitialized) {
          return const SizedBox.shrink(); // or a splash screen
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JobNest',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const AuthFlowScreen(),
        );
      },
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
        HomeScreen(
          onProfileTap: () {
            setState(() {
              _currentIndex = 4;
            });
          },
        ),
        const JobsScreen(),
        const CandidatesScreen(),
        const ServicesScreen(),
        const ProfileScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Jobs',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Candidates',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}