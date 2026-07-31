import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';

class CandidatesGridHeader extends StatelessWidget {
  final int candidateCount;
  final int selectedCount;
  final bool isMultiSelectMode;
  final VoidCallback onSelectAllVisible;
  final VoidCallback onToggleMultiSelect;
  final VoidCallback onAddCandidate;

  const CandidatesGridHeader({
    super.key,
    required this.candidateCount,
    required this.selectedCount,
    required this.isMultiSelectMode,
    required this.onSelectAllVisible,
    required this.onToggleMultiSelect,
    required this.onAddCandidate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool hasSelection = selectedCount > 0;
    final bool isAllSelected = selectedCount == candidateCount && candidateCount > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "All Candidates ($candidateCount)",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              AppSpacing.w12,
              if (isMultiSelectMode || hasSelection)
                TextButton.icon(
                  onPressed: onSelectAllVisible,
                  icon: Icon(
                    isAllSelected ? AppIcons.check_box_rounded : AppIcons.select_all_rounded,
                    size: 18,
                  ),
                  label: Text(
                    isAllSelected ? "Deselect All" : "Select All Visible",
                  ),
                ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: onToggleMultiSelect,
                icon: Icon(isMultiSelectMode ? AppIcons.checklist_rtl_rounded : AppIcons.checklist_rounded, size: 18),
                label: Text(isMultiSelectMode ? "Exit Select" : "Multi Select"),
                style: TextButton.styleFrom(
                  foregroundColor: isMultiSelectMode ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              AppSpacing.w8,
              TextButton.icon(
                onPressed: onAddCandidate,
                icon: const Icon(AppIcons.person_add_rounded, size: 18),
                label: const Text("Add Candidate"),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
