import '../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

class AppDropdownField extends StatelessWidget {
  final String? label;
  final String hint;
  final IconData icon;

  const AppDropdownField({
    super.key,
    this.label,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget dropdown = TextField(
      readOnly: true,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        suffixIcon: Icon(AppIcons.keyboard_arrow_down, color: theme.colorScheme.onSurfaceVariant),
      ),
    );

    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          dropdown,
        ],
      );
    }

    return dropdown;
  }
}
