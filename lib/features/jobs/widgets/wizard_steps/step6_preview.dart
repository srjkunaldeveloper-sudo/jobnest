import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class Step6Preview extends StatelessWidget {
  const Step6Preview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review & Publish",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.h8,
          Text(
            "Please review the job details before making it live.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h32,

          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Senior Frontend Developer",
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          AppSpacing.h4,
                          Text(
                            "JobNest Inc. • Bangalore, India",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, size: 16, color: Colors.redAccent),
                          const SizedBox(width: 4),
                          Text(
                            "Urgent",
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppSpacing.h24,
                
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildIconLabel(context, Icons.work_rounded, "Full Time"),
                    _buildIconLabel(context, Icons.laptop_mac_rounded, "Hybrid"),
                    _buildIconLabel(context, Icons.monetization_on_rounded, "₹4L - ₹6L / Yr"),
                  ],
                ),
                AppSpacing.h24,
                const Divider(),
                AppSpacing.h24,
                
                Text(
                  "Requirements",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                AppSpacing.h12,
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildChip(context, "Flutter"),
                    _buildChip(context, "Dart"),
                    _buildChip(context, "3-5 Years Exp."),
                    _buildChip(context, "Immediate Joiner"),
                  ],
                ),
                AppSpacing.h24,
                
                Text(
                  "Responsibilities",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                AppSpacing.h8,
                Text(
                  "• Identify and prospect new sales leads.\n• Maintain relationships with existing clients.\n• Achieve monthly sales targets.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildIconLabel(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        AppSpacing.w8,
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
