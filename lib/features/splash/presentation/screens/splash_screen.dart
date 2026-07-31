import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_logo.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  final SplashProvider provider;
  final VoidCallback onNavigateToLogin;
  final VoidCallback onNavigateToDashboard;
  final VoidCallback onNavigateToOnboarding;

  const SplashScreen({
    super.key,
    required this.provider,
    required this.onNavigateToLogin,
    required this.onNavigateToDashboard,
    required this.onNavigateToOnboarding,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    widget.provider.addListener(_onProviderStateChanged);
    // Start session check on the next frame to avoid state updates during build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.checkSession();
    });
  }

  @override
  void dispose() {
    widget.provider.removeListener(_onProviderStateChanged);
    super.dispose();
  }

  void _onProviderStateChanged() {
    final status = widget.provider.state.status;
    switch (status) {
      case SplashStatus.authenticated:
        widget.onNavigateToDashboard();
        break;
      case SplashStatus.unauthenticated:
        widget.onNavigateToLogin();
        break;
      case SplashStatus.onboarding:
        widget.onNavigateToOnboarding();
        break;
      default:
        // Do nothing for initial, checking, or error states in the listener
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.provider,
          builder: (context, _) {
            final state = widget.provider.state;

            if (state.status == SplashStatus.error) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        AppIcons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage ?? 'An error occurred during initialization.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: 200,
                        child: AppPrimaryButton(
                          text: 'Retry',
                          icon: AppIcons.refresh,
                          onPressed: widget.provider.checkSession,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Default visual state for checking / initial
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogo(size: 120),
                  SizedBox(height: 48),
                  CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
