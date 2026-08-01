import '../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

import 'package:jobnest/core/services/preferences_manager.dart';
import 'package:jobnest/features/auth/auth_flow_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    // ===== BACKEND TODO =====
    // TODO: Future me onboarding completion backend profile se sync hogi.
    // TODO: Remote onboarding content backend se load ho sakta hai.
    await PreferencesManager.instance.setFirstLaunchCompleted();

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AuthFlowScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              children: [
                // Top Bar with optional Skip on mobile/tablet
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              AppIcons.work_rounded,
                              color: theme.colorScheme.onPrimary,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "JobNest",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      if (_currentPage < 2)
                        TextButton(
                          onPressed: _completeOnboarding,
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.onSurfaceVariant,
                          ),
                          child: const Text(
                            "Skip",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      else
                        const SizedBox(height: 48), // Spacer to maintain alignment
                    ],
                  ),
                ),

                // Main PageView Content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildPage(
                        theme: theme,
                        index: 0,
                        headline: "Smart Hiring Starts Here",
                        subtitle:
                            "Manage jobs, candidates and interviews from one professional platform.",
                        illustration: _buildHiringIllustration(theme),
                      ),
                      _buildPage(
                        theme: theme,
                        index: 1,
                        headline: "AI Powered Recruitment",
                        subtitle:
                            "Analyze resumes, shortlist candidates and streamline hiring with intelligent tools.",
                        illustration: _buildAiIllustration(theme),
                      ),
                      _buildPage(
                        theme: theme,
                        index: 2,
                        headline: "Hire Faster Together",
                        subtitle:
                            "Collaborate with your hiring team and make better recruitment decisions.",
                        illustration: _buildTeamIllustration(theme),
                      ),
                    ],
                  ),
                ),

                // Bottom Section (Page Indicator & Action Buttons)
                _buildBottomSection(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required ThemeData theme,
    required int index,
    required String headline,
    required String subtitle,
    required Widget illustration,
  }) {
    final bool isActive = _currentPage == index;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        opacity: isActive ? 1.0 : 0.4,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          scale: isActive ? 1.0 : 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              // SaaS Graphic / Illustration Card
              illustration,
              const SizedBox(height: 48),
              // Headline
              Text(
                headline,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  subtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(ThemeData theme) {
    final isLastPage = _currentPage == 2;

    return Container(
      padding: const EdgeInsets.only(
          left: 24.0, right: 24.0, top: 16.0, bottom: 24.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Animated Page Indicator Dots
          Row(
            children: List.generate(3, (index) {
              final isSelected = _currentPage == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.only(right: 8.0),
                height: 8,
                width: isSelected ? 28 : 8,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),

          // Action Buttons
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: isLastPage
                ? ElevatedButton(
                    key: const ValueKey('getStartedBtn'),
                    onPressed: _completeOnboarding,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Get Started",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                : Row(
                    key: const ValueKey('nextBtn'),
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(width: 6),
                            Icon(AppIcons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ===== PAGE 1: ENTERPRISE HIRING PIPELINE GRAPHIC =====
  Widget _buildHiringIllustration(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "ACTIVE PIPELINE",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Icon(AppIcons.more_horiz_rounded,
                  color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Senior Product Designer",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Design • Remote • Full-time",
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          Divider(color: theme.dividerColor, height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildAvatarCircle(theme, "RS", Colors.blue),
                  Transform.translate(
                      offset: const Offset(-8, 0),
                      child: _buildAvatarCircle(theme, "AP", Colors.purple)),
                  Transform.translate(
                      offset: const Offset(-16, 0),
                      child: _buildAvatarCircle(theme, "PS", Colors.teal)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(AppIcons.check_circle_rounded,
                        color: Colors.green, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "18 Shortlisted",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== PAGE 2: AI RECRUITMENT DASHBOARD GRAPHIC =====
  Widget _buildAiIllustration(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(AppIcons.auto_awesome_rounded,
                    color: theme.colorScheme.onPrimary, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("AI Resume Match",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text("Instant candidate scoring",
                      style: theme.textTheme.bodySmall),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "98% Match",
                  style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Skills Assessment",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const Icon(AppIcons.verified_rounded,
                        color: Colors.blue, size: 16),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.94,
                    minHeight: 6,
                    backgroundColor:
                        theme.colorScheme.primary.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildSkillTag(theme, "Flutter • Expert"),
                    _buildSkillTag(theme, "System Architecture"),
                    _buildSkillTag(theme, "Dart"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== PAGE 3: TEAM COLLABORATION GRAPHIC =====
  Widget _buildTeamIllustration(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(AppIcons.groups_rounded,
                  color: theme.colorScheme.primary, size: 24),
              const SizedBox(width: 10),
              Text("Hiring Consensus",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Ready to Offer",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCommentRow(
              theme,
              "RS",
              "Rahul Sharma",
              "Brilliant architecture interview. Definitely hire!",
              "2m ago",
              Colors.blue),
          const SizedBox(height: 12),
          _buildCommentRow(theme, "AP", "Amit Patel",
              "Great cultural fit and communication skills.", "15m ago", Colors.purple),
        ],
      ),
    );
  }

  // ===== HELPER WIDGETS =====
  Widget _buildAvatarCircle(ThemeData theme, String initials, Color color) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: theme.colorScheme.surface, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSkillTag(ThemeData theme, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildCommentRow(ThemeData theme, String initials, String name,
      String comment, String time, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatarCircle(theme, initials, color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(time,
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 10)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                comment,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
