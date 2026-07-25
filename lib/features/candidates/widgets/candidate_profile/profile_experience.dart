import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileExperience extends StatelessWidget {
  const ProfileExperience({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Experience",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildExperienceItem(
                context,
                role: "Senior Flutter Developer",
                company: "TechCorp India",
                duration: "Jan 2022 - Present (2 yrs 6 mos)",
                description: "Lead the mobile team in migrating a legacy app to Flutter. Improved app performance by 40% and reduced crash rate to < 0.1%. Integrated complex animations and state management using BLoC.",
                isLast: false,
              ),
              _buildExperienceItem(
                context,
                role: "Mobile App Developer",
                company: "Innovate Solutions",
                duration: "Mar 2019 - Dec 2021 (2 yrs 9 mos)",
                description: "Developed and maintained multiple cross-platform applications using Flutter and React Native. Worked closely with the UI/UX team to implement pixel-perfect designs.",
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceItem(
    BuildContext context, {
    required String role,
    required String company,
    required String duration,
    required String description,
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
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        company,
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "•",
                        style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        duration,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
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
