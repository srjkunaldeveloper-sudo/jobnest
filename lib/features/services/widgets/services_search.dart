import 'package:flutter/material.dart';

class ServicesSearch extends StatelessWidget {
  const ServicesSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Search API connect hogi.
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search tools (e.g. Resume Analyzer, CRM...)",
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search_rounded, color: theme.colorScheme.primary),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        ),
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}
