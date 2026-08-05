import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jobnest/main.dart';
import 'package:jobnest/core/config/app_config.dart';
import 'package:jobnest/core/network/rest_client.dart';
import 'package:jobnest/core/storage/secure_storage.dart';
import 'package:jobnest/core/providers/theme_provider.dart';
import 'package:jobnest/features/auth/domain/repositories/auth_repository.dart';
import 'package:jobnest/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:jobnest/features/auth/presentation/providers/auth_provider.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';
import 'package:jobnest/features/jobs/providers/job_filter_provider.dart';
import 'package:jobnest/features/candidates/providers/candidate_provider.dart';
import 'package:jobnest/features/candidates/providers/candidate_filter_provider.dart';
import 'package:jobnest/features/companies/providers/company_provider.dart';
import 'package:jobnest/features/interviews/providers/interview_provider.dart';
import 'package:jobnest/features/notifications/providers/notification_provider.dart';
import 'package:jobnest/features/search/providers/search_provider.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';
import 'package:jobnest/features/profile/providers/profile_data_provider.dart';
import 'package:jobnest/features/splash/splash_screen.dart';
import 'package:jobnest/features/onboarding/onboarding_screen.dart';

void main() {
  testWidgets('JobNest startup flow smoke test', (WidgetTester tester) async {
    // Initialize SharedPreferences and FlutterSecureStorage with empty values for clean test
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});

    final appConfig = const AppConfig(
      environment: Environment.dev,
      apiBaseUrl: 'https://recruiter.api.jobnest.com',
      aiBaseUrl: 'https://ai.api.jobnest.com',
    );

    final restClient = RestClient(appConfig);
    final secureStorage = SecureStorage(const FlutterSecureStorage());
    final AuthRepository authRepository = MockAuthRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<SecureStorage>.value(value: secureStorage),
          Provider<RestClient>.value(value: restClient),
          Provider<AuthRepository>.value(value: authRepository),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => ProfileDataProvider()),
          ChangeNotifierProvider(
            create: (_) => AuthProvider(authRepository, secureStorage),
          ),
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
                (filterProvider ?? JobFilterProvider())
                  ..updateJobs(jobProvider.jobs),
          ),
          ChangeNotifierProxyProvider<CandidateProvider, CandidateFilterProvider>(
            create: (_) => CandidateFilterProvider(),
            update: (_, candidateProvider, filterProvider) =>
                (filterProvider ?? CandidateFilterProvider())
                  ..updateCandidates(candidateProvider.candidates),
          ),
          ChangeNotifierProxyProvider5<
            JobProvider,
            CandidateProvider,
            InterviewProvider,
            NotificationProvider,
            SearchProvider,
            DashboardProvider
          >(
            create: (_) => DashboardProvider(),
            update:
                (
                  _,
                  jobProvider,
                  candidateProvider,
                  interviewProvider,
                  notificationProvider,
                  searchProvider,
                  dashboardProvider,
                ) =>
                    (dashboardProvider ?? DashboardProvider())
                      ..updateDependencies(
                        jobProvider,
                        candidateProvider,
                        interviewProvider,
                        notificationProvider,
                        searchProvider,
                      ),
          ),
        ],
        child: const JobNestApp(),
      ),
    );

    // Pump once to allow async ThemeProvider._loadTheme() to complete
    await tester.pump();

    // Verify that our app starts at SplashScreen with JOBNEST logo text.
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('JOBNEST'), findsOneWidget);

    // Pump duration to complete animation and initialization timers (3.5 seconds)
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that on a clean install (first launch), app navigates to OnboardingScreen.
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('Smart Hiring Starts Here'), findsOneWidget);
  });
}
