import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/features/dashboard/home_screen.dart';
import 'package:jobnest/features/jobs/jobs_screen.dart';
import 'package:jobnest/features/candidates/candidates_screen.dart';
import 'package:jobnest/features/services/services_screen.dart';
import 'package:jobnest/features/profile/profile_screen.dart';
import 'package:jobnest/features/services/tools/interview_assistant_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/recruitment_data_provider.dart';
import 'features/jobs/providers/job_form_provider.dart';
import 'features/jobs/providers/job_provider.dart';
import 'features/jobs/providers/job_filter_provider.dart';
import 'features/dashboard/providers/dashboard_provider.dart';
import 'features/profile/providers/profile_data_provider.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => RecruitmentDataProvider()),
        ChangeNotifierProvider(create: (_) => ProfileDataProvider()),
        ChangeNotifierProvider(create: (_) => JobFormProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProxyProvider<JobProvider, JobFilterProvider>(
          create: (_) => JobFilterProvider(),
          update: (_, jobProvider, filterProvider) =>
              (filterProvider ?? JobFilterProvider())..updateJobs(jobProvider.jobs),
        ),
        ChangeNotifierProxyProvider2<JobProvider, RecruitmentDataProvider, DashboardProvider>(
          create: (_) => DashboardProvider(),
          update: (_, jobProvider, recruitmentProvider, dashboardProvider) =>
              (dashboardProvider ?? DashboardProvider())..updateDependencies(jobProvider, recruitmentProvider),
        ),
      ],
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
          home: const SplashScreen(),
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
          onNavigateToJobs: () {
            setState(() {
              _currentIndex = 1;
            });
          },
          onNavigateToCandidates: () {
            setState(() {
              _currentIndex = 2;
            });
          },
          onNavigateToInterviews: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InterviewAssistantScreen()),
            );
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