import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/stat_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomeQuickStats extends StatelessWidget {
  const HomeQuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();
    
    final int jobsCount = provider.jobsCount;
    final int candidatesCount = provider.candidatesCount;
    final int shortlistedCount = provider.shortlistedCount;
    final int interviewsCount = provider.interviewsCount;
    final int selectedCount = provider.selectedCount;

    final bool isEmpty = jobsCount == 0 && candidatesCount == 0 && interviewsCount == 0;
    final bool isLoading = provider.isDashboardLoading;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Stats",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          AppSpacing.h16,
          
          // ===== BACKEND TODO =====
          // TODO: API se actual dashboard stats aayenge, ye abhi dummy UI hai.
          LayoutBuilder(
            builder: (context, constraints) {
              double cardWidth;
              if (constraints.maxWidth > 800) {
                cardWidth = (constraints.maxWidth - 48) / 4;
              } else if (constraints.maxWidth > 500) {
                cardWidth = (constraints.maxWidth - 32) / 3;
              } else {
                cardWidth = (constraints.maxWidth - 16) / 2;
              }

              if (isLoading) {
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    5,
                    (index) => SizedBox(
                      width: cardWidth,
                      child: const AppShimmerLoading(
                        width: double.infinity,
                        height: 120,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                );
              }

              if (isEmpty) {
                return AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insights_rounded,
                          size: 56,
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No recruitment analytics available yet",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "As soon as you publish job requisitions and source applicant resumes, real-time pipeline conversion metrics will appear here.",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: cardWidth,
                    child: StatCard(
                      title: "Active Jobs", 
                      count: "$jobsCount", 
                      icon: Icons.work_outline_rounded, 
                      color: Colors.blueAccent, 
                      trend: jobsCount > 0 ? "+12%" : "0%", 
                      isPositiveTrend: jobsCount > 0,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: StatCard(
                      title: "Candidates", 
                      count: "$candidatesCount", 
                      icon: Icons.groups_rounded, 
                      color: Colors.orangeAccent, 
                      trend: candidatesCount > 0 ? "+5%" : "0%", 
                      isPositiveTrend: candidatesCount > 0,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: StatCard(
                      title: "Shortlisted", 
                      count: "$shortlistedCount", 
                      icon: Icons.task_alt_rounded, 
                      color: Colors.greenAccent, 
                      trend: shortlistedCount > 0 ? "-2%" : "0%", 
                      isPositiveTrend: false,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: StatCard(
                      title: "Interviews", 
                      count: "$interviewsCount", 
                      icon: Icons.calendar_today_rounded, 
                      color: Colors.purpleAccent, 
                      trend: interviewsCount > 0 ? "+20%" : "0%", 
                      isPositiveTrend: interviewsCount > 0,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: StatCard(
                      title: "Selected", 
                      count: "$selectedCount", 
                      icon: Icons.verified_rounded, 
                      color: Colors.tealAccent, 
                      trend: selectedCount > 0 ? "+1" : "0", 
                      isPositiveTrend: selectedCount > 0,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: StatCard(
                      title: "Today's Interviews", 
                      count: "${provider.todayInterviewsCount}", 
                      icon: Icons.event_available_rounded, 
                      color: Colors.pinkAccent, 
                      trend: provider.todayInterviewsCount > 0 ? "+2" : "0", 
                      isPositiveTrend: provider.todayInterviewsCount > 0,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
