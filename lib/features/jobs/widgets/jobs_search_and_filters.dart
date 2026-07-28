import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/jobs/providers/job_filter_provider.dart';

class JobsSearchAndFilters extends StatefulWidget {
  const JobsSearchAndFilters({super.key});

  @override
  State<JobsSearchAndFilters> createState() => _JobsSearchAndFiltersState();
}

class _JobsSearchAndFiltersState extends State<JobsSearchAndFilters> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final filterProvider = context.watch<JobFilterProvider>();
    if (filterProvider.searchQuery != _controller.text) {
      _controller.text = filterProvider.searchQuery;
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filterProvider = context.watch<JobFilterProvider>();
    final bool hasActiveFilters = filterProvider.filterCount > 0;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          // Search Field (Instant Local Filtering)
          // ===== BACKEND TODO =====
          // TODO: Search API connect karni hai (Debounce logic required).
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: theme.colorScheme.onSurfaceVariant),
                AppSpacing.w12,
                Expanded(
                  child: Semantics(
                    label: "Search Requisitions by title, location, or skill",
                    textField: true,
                    child: TextField(
                      controller: _controller,
                      onChanged: (val) => filterProvider.setSearchQuery(val),
                      decoration: InputDecoration(
                        hintText: "Search jobs, locations, skills...",
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                if (_controller.text.isNotEmpty)
                  Semantics(
                    label: "Clear Search Query",
                    button: true,
                    child: IconButton(
                      icon: Icon(Icons.close_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
                      onPressed: () {
                        _controller.clear();
                        filterProvider.setSearchQuery("");
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                      splashRadius: 20,
                    ),
                  ),
                AppSpacing.w12,
                Container(
                  width: 1,
                  height: 24,
                  color: theme.dividerColor,
                ),
                AppSpacing.w12,
                Semantics(
                  label: "Voice Search (Beta)",
                  button: true,
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Listening for ATS voice query... (Beta)")),
                      );
                    },
                    icon: Icon(Icons.mic_none_rounded, color: theme.colorScheme.primary),
                    constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    splashRadius: 24,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.h16,
          // Filters and Sorting
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildSortDropdown(context, filterProvider),
                AppSpacing.w12,
                Container(
                  width: 1,
                  height: 24,
                  color: theme.dividerColor,
                ),
                AppSpacing.w12,
                if (hasActiveFilters) ...[
                  _buildClearAllChip(context, filterProvider),
                  AppSpacing.w8,
                ],
                ...filterProvider.filters.map((filter) {
                  final isSelected = filterProvider.selectedFilter.toLowerCase() == filter.toLowerCase();
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildFilterChip(
                      context,
                      filter,
                      isSelected: isSelected,
                      onTap: () => filterProvider.setSelectedFilter(filter),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortDropdown(BuildContext context, JobFilterProvider filterProvider) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: "Sort Requisitions by ${filterProvider.selectedSort}",
      button: true,
      child: PopupMenuButton<String>(
        onSelected: (newValue) => filterProvider.setSelectedSort(newValue),
        tooltip: "Sort Jobs",
        constraints: const BoxConstraints(minWidth: 200),
        itemBuilder: (context) => filterProvider.sortOptions.map((option) {
          final isSelected = filterProvider.selectedSort == option;
          return PopupMenuItem<String>(
            value: option,
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
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
              color: filterProvider.selectedSort != "Newest"
                  ? theme.colorScheme.primary
                  : theme.dividerColor.withValues(alpha: 0.5),
              width: filterProvider.selectedSort != "Newest" ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sort_rounded,
                size: 16,
                color: filterProvider.selectedSort != "Newest" ? theme.colorScheme.primary : theme.colorScheme.onSurface,
              ),
              AppSpacing.w8,
              Text(
                filterProvider.selectedSort,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: filterProvider.selectedSort != "Newest" ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: filterProvider.selectedSort != "Newest" ? theme.colorScheme.primary : theme.colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClearAllChip(BuildContext context, JobFilterProvider filterProvider) {
    final theme = Theme.of(context);
    return Semantics(
      label: "Clear All Filters and Search",
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _controller.clear();
            filterProvider.clearFilters();
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
                Icon(Icons.refresh_rounded, size: 14, color: theme.colorScheme.error),
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
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.5),
                width: isSelected ? 1.5 : 1.0,
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
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
