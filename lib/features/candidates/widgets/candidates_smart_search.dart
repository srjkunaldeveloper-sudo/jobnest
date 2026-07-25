import 'package:flutter/material.dart';

class CandidatesSmartSearch extends StatelessWidget {
  const CandidatesSmartSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== BACKEND TODO =====
          // TODO: Search backend API connect hogi.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                const Icon(Icons.auto_awesome_rounded, color: Colors.deepPurpleAccent),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Try 'Python Developer Delhi' or 'Sales Executive Fresher'",
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
                const SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 24,
                  color: theme.dividerColor,
                ),
                const SizedBox(width: 12),
                Icon(Icons.mic_none_rounded, color: theme.colorScheme.primary),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "Recent:",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  children: [
                    _buildRecentChip(context, "Flutter Developer Remote"),
                    _buildRecentChip(context, "Sales Executive"),
                    _buildRecentChip(context, "UI/UX Designer"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
