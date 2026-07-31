import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';

class CandidatesEmptyState extends StatelessWidget {
  final VoidCallback onClearFilters;
  final VoidCallback onAddDummyCandidate;

  const CandidatesEmptyState({
    super.key,
    required this.onClearFilters,
    required this.onAddDummyCandidate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            Icon(AppIcons.inbox_rounded, size: 80, color: theme.dividerColor),
            AppSpacing.h16,
            Text(
              "No candidates found.",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            AppSpacing.h8,
            Text(
              "Try adjusting your advanced filters, pipeline stages, or search terms.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            AppSpacing.h24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: onClearFilters,
                  icon: const Icon(AppIcons.refresh_rounded, size: 18),
                  label: const Text("Clear Filters"),
                ),
                AppSpacing.w12,
                ElevatedButton.icon(
                  onPressed: onAddDummyCandidate,
                  icon: const Icon(AppIcons.person_add_rounded, size: 18),
                  label: const Text("Add Dummy Candidate"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
