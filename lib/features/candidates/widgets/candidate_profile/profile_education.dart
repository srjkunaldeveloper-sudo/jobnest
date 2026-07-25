import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileEducation extends StatelessWidget {
  const ProfileEducation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Education",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildEducationItem(
                context,
                degree: "B.Tech in Computer Science",
                college: "Indian Institute of Technology (IIT), Delhi",
                year: "2015 - 2019",
                grade: "CGPA: 8.5/10",
                isLast: true, // Only one item for now
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEducationItem(
    BuildContext context, {
    required String degree,
    required String college,
    required String year,
    required String grade,
    required bool isLast,
  }) {
    final theme = Theme.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary,
                  border: Border.all(color: theme.colorScheme.surface, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: theme.dividerColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    degree,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          college,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "•",
                        style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        year,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      grade,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
