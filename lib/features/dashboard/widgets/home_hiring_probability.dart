import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class HomeHiringProbability extends StatelessWidget {
  const HomeHiringProbability({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hiring Probability",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              Icon(
                Icons.insights_rounded,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ],
          ),
          AppSpacing.h16,
          // ===== BACKEND TODO =====
          // TODO: Hiring probability AI backend calculate karega.
          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: 0.82,
                            strokeWidth: 8,
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                            color: theme.colorScheme.primary,
                            strokeCap: StrokeCap.round,
                          ),
                          Center(
                            child: Text(
                              "82%",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Overall Hiring Success",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppSpacing.h4,
                          Text(
                            "Based on recent candidate pipelines",
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppSpacing.h24,
                const Divider(),
                AppSpacing.h16,
                _buildLinearProgress(context, "Candidate Fit Score", 0.75, "75%", Colors.green),
                AppSpacing.h16,
                _buildLinearProgress(context, "Average Time To Hire", 0.60, "12 Days", Colors.orangeAccent),
                AppSpacing.h24,
                // AI Insight
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.deepPurpleAccent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.deepPurpleAccent,
                        size: 16,
                      ),
                      AppSpacing.w8,
                      Expanded(
                        child: Text(
                          "Your hiring success has increased by 8% this week.",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

  Widget _buildLinearProgress(BuildContext context, String label, double value, String trailing, Color color) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              trailing,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        AppSpacing.h8,
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
