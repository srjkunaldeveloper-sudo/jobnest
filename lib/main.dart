import 'core/constants/app_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
import 'features/jobs/providers/job_form_provider.dart';
import 'features/jobs/providers/job_provider.dart';
import 'features/jobs/providers/job_filter_provider.dart';
import 'features/dashboard/providers/dashboard_provider.dart';
import 'features/profile/providers/profile_data_provider.dart';
import 'package:jobnest/features/candidates/providers/candidate_provider.dart';
import 'package:jobnest/features/candidates/providers/candidate_filter_provider.dart';
import 'package:jobnest/features/companies/providers/company_provider.dart';
import 'package:jobnest/features/interviews/providers/interview_provider.dart';
import 'package:jobnest/features/notifications/providers/notification_provider.dart';
import 'package:jobnest/features/search/providers/search_provider.dart';
import 'package:jobnest/features/splash/splash_screen.dart';
import 'package:jobnest/core/widgets/responsive_layout.dart';
import 'package:jobnest/core/constants/app_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileDataProvider()),
        ChangeNotifierProvider(create: (_) => JobFormProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => CandidateProvider()),
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
        ChangeNotifierProvider(create: (_) => InterviewProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProxyProvider<JobProvider, JobFilterProvider>(
          create: (_) => JobFilterProvider(),
          update: (_, jobProvider, filterProvider) =>
              (filterProvider ?? JobFilterProvider())..updateJobs(jobProvider.jobs),
        ),
        ChangeNotifierProxyProvider<CandidateProvider, CandidateFilterProvider>(
          create: (_) => CandidateFilterProvider(),
          update: (_, candidateProvider, filterProvider) =>
              (filterProvider ?? CandidateFilterProvider())..updateCandidates(candidateProvider.candidates),
        ),
        ChangeNotifierProxyProvider5<JobProvider, CandidateProvider, InterviewProvider, NotificationProvider, SearchProvider, DashboardProvider>(
          create: (_) => DashboardProvider(),
          update: (_, jobProvider, candidateProvider, interviewProvider, notificationProvider, searchProvider, dashboardProvider) =>
              (dashboardProvider ?? DashboardProvider())..updateDependencies(jobProvider, candidateProvider, interviewProvider, notificationProvider, searchProvider),
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

  Widget _buildNavItem(int index, IconData icon, String label, ThemeData theme) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              height: 2,
              width: isSelected ? 24 : 0,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(2)),
              ),
            ),
            Icon(
              icon,
              size: isSelected ? 24 : 22,
              color: color,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2,
                color: color,
              ),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final railDestinations = [
      const NavigationRailDestination(
        icon: Icon(AppIcons.home_outlined),
        selectedIcon: Icon(AppIcons.home),
        label: Text('Home'),
      ),
      const NavigationRailDestination(
        icon: Icon(AppIcons.work_outline),
        selectedIcon: Icon(AppIcons.work),
        label: Text('Jobs'),
      ),
      const NavigationRailDestination(
        icon: Icon(AppIcons.people_outline),
        selectedIcon: Icon(AppIcons.people),
        label: Text('Candidates'),
      ),
      const NavigationRailDestination(
        icon: Icon(AppIcons.auto_awesome_outlined),
        selectedIcon: Icon(AppIcons.auto_awesome),
        label: Text('Services'),
      ),
      const NavigationRailDestination(
        icon: Icon(AppIcons.person_outline),
        selectedIcon: Icon(AppIcons.person),
        label: Text('Profile'),
      ),
    ];

    Widget mobileLayout = Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 72,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          border: Border(
            top: BorderSide(
              color: theme.dividerColor.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withValues(alpha: 0.16) : Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, LucideIcons.home, 'Home', theme),
              _buildNavItem(1, LucideIcons.briefcase, 'Jobs', theme),
              _buildNavItem(2, LucideIcons.users, 'Candidates', theme),
              _buildNavItem(3, LucideIcons.sparkles, 'Services', theme),
              _buildNavItem(4, LucideIcons.user, 'Profile', theme),
            ],
          ),
        ),
      ),
    );

    Widget desktopLayout = Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            selectedIconTheme: IconThemeData(color: theme.colorScheme.primary),
            selectedLabelTextStyle: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelTextStyle: TextStyle(color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText, fontSize: 12),
            indicatorColor: theme.colorScheme.primary.withValues(alpha: 0.12),
            destinations: railDestinations,
          ),
          VerticalDivider(thickness: 1, width: 1, color: isDark ? AppColors.borderDark : AppColors.borderLight),
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
    );

    return ResponsiveLayout(
      mobile: mobileLayout,
      tablet: desktopLayout,
      desktop: desktopLayout,
    );
  }
}