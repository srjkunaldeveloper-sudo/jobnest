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
    
    final int activeJobsCount = provider.activeJobsCount;
    final int urgentJobsCount = provider.urgentJobsCount;
    final int candidatesCount = provider.candidatesCount;
    final int newCandidatesCount = provider.newCandidatesCount;
    final int shortlistedCount = provider.shortlistedCount;
    final int interviewsCount = provider.interviewsCount;
    final int selectedCount = provider.selectedCount;

    final bool isEmpty = provider.jobs.isEmpty && candidatesCount == 0 && interviewsCount == 0;
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
          
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = (constraints.maxWidth - 16) / 2;
              final double ratio = cardWidth / 156.0;

              if (isLoading) {
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: ratio,
                  children: List.generate(
                    10,
                    (index) => const AppShimmerLoading(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
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

              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: ratio,
                children: [
                  StatCard(
                    title: "Active Jobs", 
                    count: "$activeJobsCount", 
                    icon: Icons.work_outline_rounded, 
                    color: Colors.blueAccent, 
                    trend: activeJobsCount > 0 ? "+12%" : "0%", 
                    isPositiveTrend: activeJobsCount > 0,
                  ),
                  StatCard(
                    title: "Urgent Jobs", 
                    count: "$urgentJobsCount", 
                    icon: Icons.priority_high_rounded, 
                    color: Colors.redAccent, 
                    trend: urgentJobsCount > 0 ? "+2" : "0", 
                    isPositiveTrend: urgentJobsCount > 0,
                  ),
                  StatCard(
                    title: "Candidates", 
                    count: "$candidatesCount", 
                    icon: Icons.groups_rounded, 
                    color: Colors.orangeAccent, 
                    trend: candidatesCount > 0 ? "+5%" : "0%", 
                    isPositiveTrend: candidatesCount > 0,
                  ),
                  StatCard(
                    title: "New Candidates", 
                    count: "$newCandidatesCount", 
                    icon: Icons.person_add_alt_1_rounded, 
                    color: Colors.deepOrangeAccent, 
                    trend: newCandidatesCount > 0 ? "+3" : "0", 
                    isPositiveTrend: newCandidatesCount > 0,
                  ),
                  StatCard(
                    title: "Shortlisted", 
                    count: "$shortlistedCount", 
                    icon: Icons.task_alt_rounded, 
                    color: Colors.greenAccent, 
                    trend: shortlistedCount > 0 ? "-2%" : "0%", 
                    isPositiveTrend: false,
                  ),
                  StatCard(
                    title: "Interviews", 
                    count: "$interviewsCount", 
                    icon: Icons.calendar_today_rounded, 
                    color: Colors.purpleAccent, 
                    trend: interviewsCount > 0 ? "+20%" : "0%", 
                    isPositiveTrend: interviewsCount > 0,
                  ),
                  StatCard(
                    title: "Today's Interviews", 
                    count: "${provider.todayInterviewsCount}", 
                    icon: Icons.event_available_rounded, 
                    color: Colors.pinkAccent, 
                    trend: provider.todayInterviewsCount > 0 ? "+2" : "0", 
                    isPositiveTrend: provider.todayInterviewsCount > 0,
                  ),
                  StatCard(
                    title: "Selected", 
                    count: "$selectedCount", 
                    icon: Icons.verified_rounded, 
                    color: Colors.tealAccent, 
                    trend: selectedCount > 0 ? "+1" : "0", 
                    isPositiveTrend: selectedCount > 0,
                  ),
                  const StatCard(
                    title: "Time to Hire", 
                    count: "--", 
                    icon: Icons.hourglass_empty_rounded, 
                    color: Colors.blueGrey, 
                    trend: "", 
                    isPositiveTrend: true,
                  ),
                  const StatCard(
                    title: "Offer Acceptance", 
                    count: "--", 
                    icon: Icons.thumb_up_alt_rounded, 
                    color: Colors.grey, 
                    trend: "", 
                    isPositiveTrend: true,
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
