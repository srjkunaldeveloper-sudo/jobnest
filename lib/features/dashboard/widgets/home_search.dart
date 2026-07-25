import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: theme.dividerColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: () {
                  // ===== BACKEND TODO =====
                  // TODO: Yaha par Global Search screen open karna hai with AI filters.
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                      AppSpacing.w12,
                      Expanded(
                        child: Text(
                          "Search jobs, candidates, companies...",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSpacing.w8,
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mic_rounded,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          AppSpacing.h16,
          
          // Recent Searches
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildRecentSearchChip(context, "Senior Flutter Developer"),
                AppSpacing.w8,
                _buildRecentSearchChip(context, "Product Designer"),
                AppSpacing.w8,
                _buildRecentSearchChip(context, "NodeJS Backend"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchChip(BuildContext context, String label) {
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
          Icon(
            Icons.history_rounded,
            size: 14,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
