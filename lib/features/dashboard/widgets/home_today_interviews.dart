import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomeTodayInterviews extends StatelessWidget {
  const HomeTodayInterviews({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();
    final todayInterviews = provider.interviews.where((i) => i.isToday).toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Interviews",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              if (todayInterviews.isNotEmpty)
                Text(
                  "${todayInterviews.length} Scheduled",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          AppSpacing.h16,
          AppCard(
            borderRadius: 18,
            padding: const EdgeInsets.all(16),
            child: todayInterviews.isEmpty
                ? _buildEmptyState(theme)
                : Column(
                    children: [
                      for (int idx = 0; idx < todayInterviews.length; idx++) ...[
                        _buildInterviewRow(context, todayInterviews[idx], idx, provider),
                        if (idx < todayInterviews.length - 1)
                          const Divider(height: 24, thickness: 0.5),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_busy_rounded,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              size: 40,
            ),
            AppSpacing.h12,
            Text(
              "No interviews scheduled today.",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterviewRow(
    BuildContext context,
    InterviewModel interview,
    int index,
    DashboardProvider provider,
  ) {
    final theme = Theme.of(context);
    
    // Lookup candidate model to retrieve potential avatar URL
    final candidate = provider.candidates.firstWhere(
      (c) => c.name == interview.candidateName,
      orElse: () => const CandidateModel(
        id: '',
        name: '',
        role: '',
        location: '',
        experience: '',
        skills: [],
        matchPercentage: 0,
        score: 0,
      ),
    );

    // Mock properties derived deterministically from index to avoid hardcoded mock datasets
    final isOnline = index % 2 == 0;
    final isConfirmed = index % 3 != 1;
    final typeText = isOnline ? "Online" : "Offline";
    final statusText = isConfirmed ? "Confirmed" : "Scheduled";
    final typeColor = isOnline ? Colors.blue : Colors.blueGrey;
    final statusColor = isConfirmed ? Colors.green : Colors.orange;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Candidate Avatar
        CircleAvatar(
          radius: 22,
          backgroundColor: theme.colorScheme.primaryContainer,
          backgroundImage: candidate.avatarUrl.isNotEmpty ? NetworkImage(candidate.avatarUrl) : null,
          child: candidate.avatarUrl.isEmpty
              ? Text(
                  interview.candidateName.isNotEmpty
                      ? interview.candidateName[0].toUpperCase()
                      : "?",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        AppSpacing.w16,
        
        // 2. Candidate Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                interview.candidateName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "${interview.role} • ${interview.company}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        
        // 3. Interview Details & Status badges
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              interview.time,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSmallBadge(theme, typeText, typeColor),
                const SizedBox(width: 6),
                _buildSmallBadge(theme, statusText, statusColor),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallBadge(ThemeData theme, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}
