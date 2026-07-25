import 'package:flutter/material.dart';

class AppDropdownField extends StatelessWidget {
  final String hint;
  final IconData icon;

  const AppDropdownField({
    super.key,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextField(
      readOnly: true,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        suffixIcon: Icon(Icons.keyboard_arrow_down, color: theme.colorScheme.onSurfaceVariant),
      ),
    );
  }
}
