import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/constants/app_spacing.dart';

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
            const Icon(AppIcons.rate_review_rounded, color: Colors.deepPurpleAccent, size: 24),
            AppSpacing.w12,
            Text(
              "Interview Summary",
              style: AppText.h3,
            ),
          ],
        ),
        AppSpacing.h16,
        // ===== BACKEND TODO =====
        // TODO: Interview Summary backend se generate hogi.
        AppCard(
          padding: AppSpacing.edgeInsetsAll24,
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
                          style: AppText.label.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        AppSpacing.h8,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "8.5",
                              style: AppText.h1.copyWith(
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            Text(
                              " / 10",
                              style: AppText.h3.copyWith(
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
                        AppSpacing.h8,
                        _buildRatingRow(context, "Communication", 8.0),
                        AppSpacing.h8,
                        _buildRatingRow(context, "Confidence", 8.5),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.h24,
              const Divider(),
              AppSpacing.h24,
              Row(
                children: [
                  Text(
                    "AI Recommendation",
                    style: AppText.h3.copyWith(
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
                      style: AppText.label.copyWith(
                        color: Colors.white,
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
          style: AppText.label.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Row(
          children: [
            const Icon(AppIcons.star_rounded, size: 16, color: Colors.orangeAccent),
            AppSpacing.w4,
            Text(
              rating.toStringAsFixed(1),
              style: AppText.label,
            ),
          ],
        ),
      ],
    );
  }
}
