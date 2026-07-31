import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

class CandidatesFilters extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String>? onFilterChanged;
  final String selectedSort;
  final ValueChanged<String>? onSortChanged;
  final VoidCallback? onClearAll;

  const CandidatesFilters({
    super.key,
    this.selectedFilter = "All",
    this.onFilterChanged,
    this.selectedSort = "Newest",
    this.onSortChanged,
    this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filters = ["All", "Shortlisted", "Interview", "Offer", "Hired", "Remote"];
    final bool hasActiveFilters = selectedFilter != "All" || selectedSort != "Newest";

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildSortDropdown(context),
            const SizedBox(width: 12),
            Container(
              width: 1,
              height: 24,
              color: theme.dividerColor,
            ),
            const SizedBox(width: 12),
            if (hasActiveFilters) ...[
              _buildClearAllChip(context),
              const SizedBox(width: 8),
            ],
            ...filters.map((filter) {
              final isSelected = selectedFilter.toLowerCase() == filter.toLowerCase();
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _buildFilterChip(
                  context,
                  filter,
                  isSelected: isSelected,
                  onTap: () => onFilterChanged?.call(filter),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown(BuildContext context) {
    final theme = Theme.of(context);
    final sortOptions = [
      "Newest",
      "Oldest",
      "Highest Experience",
      "Lowest Experience",
      "Highest Rating",
      "Recently Updated",
    ];
    
    return Semantics(
      label: "Sort candidates by $selectedSort",
      button: true,
      child: PopupMenuButton<String>(
        onSelected: (newValue) => onSortChanged?.call(newValue),
        tooltip: "Sort Candidates",
        constraints: const BoxConstraints(minWidth: 200),
        itemBuilder: (context) => sortOptions.map((option) {
          final isSelected = selectedSort == option;
          return PopupMenuItem<String>(
            value: option,
            child: Row(
              children: [
                Icon(
                  isSelected ? AppIcons.radio_button_checked_rounded : AppIcons.radio_button_unchecked_rounded,
                  size: 18,
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Text(
                  option,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selectedSort != "Newest"
                  ? theme.colorScheme.primary
                  : theme.dividerColor.withValues(alpha: 0.5),
              width: selectedSort != "Newest" ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                AppIcons.sort_rounded,
                size: 16,
                color: selectedSort != "Newest" ? theme.colorScheme.primary : theme.colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                selectedSort,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: selectedSort != "Newest" ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                AppIcons.keyboard_arrow_down_rounded,
                size: 16,
                color: selectedSort != "Newest" ? theme.colorScheme.primary : theme.colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClearAllChip(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: "Clear All Filters and Search",
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onClearAll?.call();
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(AppIcons.refresh_rounded, size: 14, color: theme.colorScheme.error),
                const SizedBox(width: 6),
                Text(
                  "Clear All",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: "Filter by $label, ${isSelected ? 'Selected' : 'Not selected'}",
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.5),
                width: 1.0,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 13,
                    color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
