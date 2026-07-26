import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';

import 'package:jobnest/core/services/app_initialization_service.dart';
import 'package:jobnest/core/services/preferences_manager.dart';
import 'package:jobnest/core/services/session_manager.dart';
import 'package:jobnest/features/auth/auth_flow_screen.dart';
import 'package:jobnest/features/onboarding/onboarding_screen.dart';
import 'package:jobnest/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _subtitleFadeAnimation;
  late Animation<double> _loaderFadeAnimation;

  bool _initError = false;
  bool _initCompleted = false;
  bool _animationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // 0.0–0.5 sec: Logo fades in (Interval 0.0 -> 0.1667)
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.1667, curve: Curves.easeIn),
      ),
    );

    // 0.5–1.2 sec: Logo scales from 90% to 100% (Interval 0.1667 -> 0.4000)
    _logoScaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1667, 0.4000, curve: Curves.easeOutCubic),
      ),
    );

    // 1.2–2.0 sec: Subtitle fades in (Interval 0.4000 -> 0.6667)
    _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4000, 0.6667, curve: Curves.easeIn),
      ),
    );

    // 2.0–2.5 sec: Small loading indicator appears (Interval 0.6667 -> 0.8333)
    _loaderFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6667, 0.8333, curve: Curves.easeIn),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationCompleted = true;
        _checkAndNavigate();
      }
    });

    _controller.forward();
    _initStartupFlow();
  }

  void _initStartupFlow() async {
    try {
      await AppInitializationService.instance.initializeApp();
      if (!mounted) return;
      setState(() {
        _initError = false;
        _initCompleted = true;
      });
      _checkAndNavigate();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _initError = true;
      });
    }
  }

  void _checkAndNavigate() async {
    if (_initCompleted && _animationCompleted && !_initError) {
      await PreferencesManager.instance.init();
      await SessionManager.instance.init();
      final isFirstLaunch = PreferencesManager.instance.isFirstLaunch();
      final isLoggedIn = SessionManager.instance.isLoggedIn();

      // ===== BACKEND TODO =====
      // TODO: Future session token validation with remote authentication backend.
      // TODO: Check if user session has expired or requires biometric re-auth.

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            if (isFirstLaunch) {
              return const OnboardingScreen();
            }
            return isLoggedIn ? const MainDashboard() : const AuthFlowScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _initError
                ? _buildErrorContent(theme)
                : _buildSplashContent(theme),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorContent(ThemeData theme) {
    return AppErrorState(
      title: "Unable to initialize application",
      message: "An unexpected error occurred during startup. Please check your system settings or restart the app.",
      primaryButtonText: "Retry",
      onRetry: () {
        setState(() {
          _initError = false;
          _initCompleted = false;
        });
        _controller.reset();
        _controller.forward();
        _initStartupFlow();
      },
      iconData: Icons.error_outline_rounded,
    );
  }

  Widget _buildSplashContent(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo & Brand Name (Animated Fade + Scale)
        FadeTransition(
          opacity: _logoFadeAnimation,
          child: ScaleTransition(
            scale: _logoScaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary
                            .withValues(alpha: 0.25),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.work_rounded,
                    color: theme.colorScheme.onPrimary,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  "JOBNEST",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Recruitment Platform",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Small Subtitle (Animated Fade)
        FadeTransition(
          opacity: _subtitleFadeAnimation,
          child: Text(
            "Smart Hiring. Better Teams.",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant
                  .withValues(alpha: 0.8),
              fontStyle: FontStyle.italic,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 36),

        // Minimal Loading Indicator (Animated Fade)
        FadeTransition(
          opacity: _loaderFadeAnimation,
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
              strokeCap: StrokeCap.round,
            ),
          ),
        ),
      ],
    );
  }
}
