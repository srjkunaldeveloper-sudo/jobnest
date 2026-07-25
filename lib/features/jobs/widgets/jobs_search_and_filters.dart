import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';

class JobsSearchAndFilters extends StatelessWidget {
  const JobsSearchAndFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          // Search Field
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
                  child: TextField(
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
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
                AppSpacing.w12,
                Container(
                  width: 1,
                  height: 24,
                  color: theme.dividerColor,
                ),
                AppSpacing.w12,
                Icon(Icons.mic_none_rounded, color: theme.colorScheme.primary),
              ],
            ),
          ),
          AppSpacing.h16,
          // Filters and Sorting
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSortDropdown(context),
                AppSpacing.w12,
                Container(
                  width: 1,
                  height: 24,
                  color: theme.dividerColor,
                ),
                AppSpacing.w12,
                _buildFilterChip(context, "All", isSelected: true),
                AppSpacing.w8,
                _buildFilterChip(context, "Active"),
                AppSpacing.w8,
                _buildFilterChip(context, "Closed"),
                AppSpacing.w8,
                _buildFilterChip(context, "Remote"),
                AppSpacing.w8,
                _buildFilterChip(context, "Full Time"),
                AppSpacing.w8,
                _buildFilterChip(context, "Part Time"),
                AppSpacing.w8,
                _buildFilterChip(context, "Internship"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortDropdown(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          Icon(Icons.sort_rounded, size: 16, color: theme.colorScheme.onSurface),
          AppSpacing.w8,
          Text(
            "Latest",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: theme.colorScheme.onSurface),
        ],
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
}
