import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';

class CandidatesSimulationPanel extends StatelessWidget {
  final RecruitmentDataProvider provider;

  const CandidatesSimulationPanel({
    super.key,
    required this.provider,
  });

  Widget _buildSimButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color sideColor,
    Color? foregroundColor,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 14),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        foregroundColor: foregroundColor,
        side: BorderSide(color: sideColor.withValues(alpha: 0.5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: AppRadius.medium,
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(Icons.science_outlined, size: 18, color: theme.colorScheme.primary),
            AppSpacing.w8,
            Text(
              "QA State Test:",
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            AppSpacing.w12,
            _buildSimButton(
              onPressed: () => provider.simulateCandidatesLoading(),
              icon: Icons.hourglass_empty_rounded,
              label: "Loading Skeleton",
              sideColor: theme.colorScheme.primary,
            ),
            AppSpacing.w8,
            _buildSimButton(
              onPressed: () => provider.simulateCandidatesError(),
              icon: Icons.error_outline_rounded,
              label: "Error State",
              sideColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.error,
            ),
            AppSpacing.w8,
            _buildSimButton(
              onPressed: () => provider.simulateCandidatesEmpty(),
              icon: Icons.inbox_rounded,
              label: "Empty State",
              sideColor: theme.colorScheme.primary,
            ),
            AppSpacing.w8,
            _buildSimButton(
              onPressed: () => provider.restoreCandidatesDefault(),
              icon: Icons.restore_rounded,
              label: "Restore Data",
              sideColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
