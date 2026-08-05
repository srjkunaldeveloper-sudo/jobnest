import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomePipelineSnapshot extends StatelessWidget {
  const HomePipelineSnapshot({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();

    // Calculate dynamic counts from the collections inside DashboardProvider
    final int appliedCount = provider.candidates.where((c) => c.stage.toLowerCase() == 'applied').length;
    final int screeningCount = provider.candidates.where((c) => c.stage.toLowerCase() == 'screening').length;
    final int shortlistedCount = provider.shortlistedCount;
    final int interviewCount = provider.interviewsCount;
    final int selectedCount = provider.selectedCount;

    final List<_PipelineStageData> stages = [
      _PipelineStageData(
        label: "Applied",
        icon: Icons.post_add_rounded,
        countText: "$appliedCount",
        color: theme.colorScheme.primary,
      ),
      _PipelineStageData(
        label: "Screening",
        icon: Icons.filter_list_rounded,
        countText: "$screeningCount",
        color: Colors.orange,
      ),
      _PipelineStageData(
        label: "Shortlisted",
        icon: Icons.bookmark_added_rounded,
        countText: "$shortlistedCount",
        color: Colors.purple,
      ),
      _PipelineStageData(
        label: "Interview",
        icon: Icons.rate_review_rounded,
        countText: "$interviewCount",
        color: Colors.blue,
      ),
      _PipelineStageData(
        label: "Selected",
        icon: Icons.verified_user_rounded,
        countText: "$selectedCount",
        color: Colors.green,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pipeline Snapshot",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          AppSpacing.h16,
          AppCard(
            borderRadius: 18,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: stages.map((stage) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 130,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: stage.color.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: stage.color.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            stage.icon,
                            color: stage.color,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            stage.countText,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stage.label,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelineStageData {
  final String label;
  final IconData icon;
  final String countText;
  final Color color;

  const _PipelineStageData({
    required this.label,
    required this.icon,
    required this.countText,
    required this.color,
  });
}
