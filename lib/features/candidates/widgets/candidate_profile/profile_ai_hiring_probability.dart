import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileAiHiringProbability extends StatelessWidget {
  const ProfileAiHiringProbability({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.psychology_rounded, color: Colors.deepPurpleAccent, size: 24),
            const SizedBox(width: 12),
            Text(
              "Hiring Probability",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Hiring Probability ML service se aayegi.
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildMetric(context, "Hiring Success", "88%", Colors.green),
                        const SizedBox(height: 16),
                        _buildMetric(context, "Interview Probability", "92%", Colors.blue),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        _buildMetric(context, "Culture Fit", "High", Colors.deepPurpleAccent),
                        const SizedBox(height: 16),
                        _buildMetric(context, "Technical Fit", "Excellent", Colors.orange),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              Text(
                "Overall Recommendation",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildRecommendationChip(context, "Hire", Colors.green, isSelected: true),
                  const SizedBox(width: 12),
                  _buildRecommendationChip(context, "Consider", Colors.orange),
                  const SizedBox(width: 12),
                  _buildRecommendationChip(context, "Reject", Colors.redAccent),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetric(BuildContext context, String label, String value, Color valueColor) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationChip(BuildContext context, String label, Color color, {bool isSelected = false}) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : theme.dividerColor.withValues(alpha: 0.5),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
