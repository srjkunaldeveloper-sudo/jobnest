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

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            // Sort Dropdown Chip (Section 7)
            _buildSortDropdown(context),
            const SizedBox(width: 12),
            Container(width: 1, height: 24, color: theme.dividerColor),
            const SizedBox(width: 12),

            // Quick Filter Chips (Section 6)
            _buildFilterChip(context, "All"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Shortlisted"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Interview"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Offer"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Hired"),
            const SizedBox(width: 8),
            _buildFilterChip(context, "Remote"),
            const SizedBox(width: 12),
            Container(width: 1, height: 24, color: theme.dividerColor),
            const SizedBox(width: 12),

            // Dummy Enterprise ATS Dropdowns (Section 6)
            _buildDropdownChip(context, "Experience", ["All", "1-3 Years", "3-5 Years", "5+ Years"]),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Location", ["All", "Bangalore", "Delhi", "Mumbai", "Remote"]),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Status", ["All", "Applied", "Screening", "Interview", "Offer"]),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Skills", ["All", "Flutter", "Python", "React", "AWS"]),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Expected Salary", ["All", "₹ 10-15 LPA", "₹ 15-25 LPA", "₹ 25+ LPA"]),
            const SizedBox(width: 8),
            _buildDropdownChip(context, "Availability", ["All", "Immediate", "15 Days", "30 Days"]),
            const SizedBox(width: 12),

            // Clear All Button (if any filter or custom sort is active)
            if (selectedFilter != "All" || selectedSort != "Newest")
              TextButton.icon(
                onPressed: onClearAll,
                icon: Icon(Icons.refresh_rounded, size: 16, color: theme.colorScheme.error),
                label: Text("Reset Filters", style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
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
        tooltip: "Sort Candidates",
        onSelected: (value) => onSortChanged?.call(value),
        itemBuilder: (context) {
          return sortOptions.map((opt) {
            final isCur = opt == selectedSort;
            return PopupMenuItem<String>(
              value: opt,
              child: Row(
                children: [
                  Icon(
                    isCur ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    size: 18,
                    color: isCur ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Text(opt, style: TextStyle(fontWeight: isCur ? FontWeight.bold : FontWeight.normal)),
                ],
              ),
            );
          }).toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sort_rounded, size: 16, color: theme.colorScheme.onPrimaryContainer),
              const SizedBox(width: 6),
              Text(
                "Sort: $selectedSort",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_drop_down_rounded, size: 18, color: theme.colorScheme.onPrimaryContainer),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    final isSelected = selectedFilter.toLowerCase() == label.toLowerCase();

    return Semantics(
      label: "Filter by $label",
      button: true,
      child: InkWell(
        onTap: () => onFilterChanged?.call(isSelected ? "All" : label),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.5),
            ),
            boxShadow: isSelected
                ? [BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.25), blurRadius: 6, offset: const Offset(0, 2))]
                : null,
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownChip(BuildContext context, String label, List<String> options) {
    final theme = Theme.of(context);
    final isSelected = selectedFilter.toLowerCase().contains(label.toLowerCase());

    return Semantics(
      label: "Filter by $label dropdown",
      button: true,
      child: PopupMenuButton<String>(
        tooltip: "Filter by $label",
        onSelected: (val) {
          if (val == "All") {
            onFilterChanged?.call("All");
          } else {
            onFilterChanged?.call(val);
          }
        },
        itemBuilder: (ctx) => options.map((opt) => PopupMenuItem(value: opt, child: Text(opt))).toList(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.secondaryContainer : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? theme.colorScheme.secondary : theme.dividerColor.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isSelected ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: isSelected ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
