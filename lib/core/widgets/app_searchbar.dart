import 'package:flutter/material.dart';
import '../constants/app_radius.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isAiSearch;

  const AppSearchBar({
    super.key,
    required this.hintText,
    this.icon = Icons.search,
    this.isAiSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.medium,
        border: Border.all(
          color: isAiSearch ? theme.colorScheme.primary.withValues(alpha: 0.3) : theme.dividerColor,
        ),
        boxShadow: isAiSearch
            ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: isAiSearch ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
          ),
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 13,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          filled: false,
        ),
      ),
    );
  }
}
