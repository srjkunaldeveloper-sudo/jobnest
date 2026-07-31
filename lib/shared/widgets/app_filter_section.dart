import 'package:flutter/material.dart';

/// A reusable, responsive filter section widget.
/// 
/// Organizes a collection of filter widgets into a responsive [Wrap] layout
/// and provides an optional clear button and leading widget (typically a title).
class AppFilterSection extends StatelessWidget {
  /// The list of individual filter widgets (e.g., dropdowns, switches).
  final List<Widget> filters;
  
  /// An optional leading widget, usually displaying a title like "Filters".
  /// If null, a default "Filters" text widget is used.
  final Widget? leading;
  
  /// Callback triggered when the "Clear All" button is pressed.
  /// If null, the button is not displayed.
  final VoidCallback? onClear;

  const AppFilterSection({
    super.key,
    required this.filters,
    this.leading,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: 'Filter Section',
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row with Leading Widget and Clear Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null)
                DefaultTextStyle(
                  style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ) ??
                      const TextStyle(),
                  child: leading!,
                )
              else
                Text(
                  'Filters',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              if (onClear != null)
                Semantics(
                  button: true,
                  label: 'Clear all filters',
                  child: TextButton(
                    onPressed: onClear,
                    child: const Text('Clear All'),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Responsive Filters Wrap
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: filters,
          ),
        ],
      ),
    );
  }
}
