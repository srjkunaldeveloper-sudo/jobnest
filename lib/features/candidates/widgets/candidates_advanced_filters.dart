import 'package:flutter/material.dart';

class CandidatesAdvancedFilters extends StatelessWidget {
  const CandidatesAdvancedFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Advanced Filters backend query use karenge.
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advanced Filters",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterSection(
                      context,
                      "Sort By",
                      ["Best Match", "Newest", "Highest Score"],
                      selected: "Best Match",
                    ),
                    const SizedBox(height: 24),
                    _buildFilterSection(
                      context,
                      "Experience",
                      ["Fresher", "1-3 Years", "3-5 Years", "5+ Years"],
                      selected: "3-5 Years",
                    ),
                    const SizedBox(height: 24),
                    _buildFilterSection(
                      context,
                      "Availability",
                      ["Immediate", "15 Days", "1 Month", "2+ Months"],
                      selected: "Immediate",
                    ),
                    const SizedBox(height: 24),
                    _buildFilterSection(
                      context,
                      "Profile Status",
                      ["Verified Profiles Only", "With Portfolio", "Willing to Relocate"],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Reset"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Apply Filters"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, String title, List<String> options, {String? selected}) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = option == selected;
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) {},
              showCheckmark: false,
              backgroundColor: theme.colorScheme.surface,
              selectedColor: theme.colorScheme.primaryContainer,
              labelStyle: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
