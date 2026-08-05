import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class RecommendationData {
  final String title;
  final String description;
  final String? type;

  const RecommendationData({
    required this.title,
    required this.description,
    this.type,
  });
}

class DetailsAiInsights extends StatelessWidget {
  final int? matchScore;
  final List<String>? healthIndicators;
  final List<RecommendationData>? recommendations;
  final List<String>? risks;
  final List<String>? suggestedActions;
  final VoidCallback? onGenerateAnalysis;

  const DetailsAiInsights({
    super.key,
    this.matchScore,
    this.healthIndicators,
    this.recommendations,
    this.risks,
    this.suggestedActions,
    this.onGenerateAnalysis,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool hasData = (matchScore != null && matchScore! > 0) ||
        (healthIndicators != null && healthIndicators!.isNotEmpty) ||
        (recommendations != null && recommendations!.isNotEmpty) ||
        (risks != null && risks!.isNotEmpty) ||
        (suggestedActions != null && suggestedActions!.isNotEmpty);

    if (!hasData) {
      return _buildEmptyState(context);
    }

    String ratingLabel = "--";
    Color scoreColor = Colors.grey;

    if (matchScore != null) {
      if (matchScore! >= 85) {
        ratingLabel = "Excellent";
        scoreColor = Colors.green;
      } else if (matchScore! >= 70) {
        ratingLabel = "Good";
        scoreColor = Colors.blue;
      } else if (matchScore! >= 50) {
        ratingLabel = "Average";
        scoreColor = Colors.orange;
      } else if (matchScore! > 0) {
        ratingLabel = "Needs Attention";
        scoreColor = Colors.red;
      }
    }

    final activeIndicators = healthIndicators ?? const [];
    final activeRecommendations = recommendations ?? const [];
    final activeRisks = risks ?? const [];
    final activeActions = suggestedActions ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SECTION 1: Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.auto_awesome, size: 20, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Hiring Insights",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "AI-powered recommendations for this requisition.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // SECTION 2: Overall AI Match Score Card
        if (matchScore != null) ...[
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Large circular score indicator
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: scoreColor.withValues(alpha: 0.3),
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "$matchScore%",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overall Requisition Match",
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: scoreColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          ratingLabel.toUpperCase(),
                          style: TextStyle(
                            color: scoreColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // SECTION 3: AI Health Indicators
        if (activeIndicators.isNotEmpty) ...[
          Text(
            "AI Health Indicators",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: activeIndicators.map((indicator) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, size: 14, color: Colors.green),
                    const SizedBox(width: 6),
                    Text(
                      indicator,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.green[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],

        // SECTION 5: Risk Analysis Warnings
        if (activeRisks.isNotEmpty) ...[
          Text(
            "Identified Risks & Gaps",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: activeRisks.map((risk) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.redAccent.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, size: 18, color: Colors.redAccent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          risk,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],

        // SECTION 4: AI Recommendations
        if (activeRecommendations.isNotEmpty) ...[
          Text(
            "AI Recommendations",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: activeRecommendations.map((rec) {
              IconData icon = Icons.lightbulb_outline_rounded;
              if (rec.type == "salary") {
                icon = Icons.payments_outlined;
              } else if (rec.type == "specs") {
                icon = Icons.fact_check_outlined;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: AppCard(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rec.title,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              rec.description,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],

        // SECTION 6: Suggested Actions
        if (activeActions.isNotEmpty) ...[
          Text(
            "Suggested Actions",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: activeActions.map((action) {
              return ActionChip(
                label: Text(action),
                onPressed: () {},
                backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                labelStyle: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(),
          ),
        ],

        // SECTION 7: Bottom CTA
        if (onGenerateAnalysis != null) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onGenerateAnalysis,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text("Generate AI Analysis"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 48,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "No AI Insights Available",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "AI recommendations will appear once sufficient recruitment data is available.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
