import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileInterviewSummary extends StatelessWidget {
  const ProfileInterviewSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.rate_review_rounded, color: Colors.deepPurpleAccent, size: 24),
            const SizedBox(width: 12),
            Text(
              "Interview Summary",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Interview Summary backend se generate hogi.
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overall Performance",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "8.5",
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            Text(
                              " / 10",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRatingRow(context, "Technical Rating", 9.0),
                        const SizedBox(height: 8),
                        _buildRatingRow(context, "Communication", 8.0),
                        const SizedBox(height: 8),
                        _buildRatingRow(context, "Confidence", 8.5),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    "AI Recommendation",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "HIRE",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow(BuildContext context, String label, double rating) {
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
        Row(
          children: [
            const Icon(Icons.star_rounded, size: 16, color: Colors.orangeAccent),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
