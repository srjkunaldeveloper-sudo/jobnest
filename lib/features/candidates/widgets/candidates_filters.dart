import 'package:flutter/material.dart';

class CandidatesFilters extends StatelessWidget {
  const CandidatesFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip(context, "All", isSelected: true),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Shortlisted"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Interview"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Selected"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Rejected"),
            const SizedBox(width: 16),
            Container(width: 1, height: 24, color: Theme.of(context).dividerColor),
            const SizedBox(width: 16),
            _buildDropdownChip(context, "Experience"),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Location"),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Skills"),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Salary"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Remote"),
            const SizedBox(width: 8),
            _buildIconChip(context, Icons.tune_rounded, "More Filters"),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, {bool isSelected = false}) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildDropdownChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _buildIconChip(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSurface),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
