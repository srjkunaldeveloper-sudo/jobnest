import 'package:flutter/material.dart';
import '../constants/app_text.dart';
import '../constants/app_colors.dart';

enum AppChipType {
  defaultType,
  selected,
  filter,
  success,
  warning,
  error,
}

class AppChip extends StatelessWidget {
  final String label;
  final AppChipType type;
  final bool isSelected;
  final VoidCallback? onSelected;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppChip({
    super.key,
    required this.label,
    this.type = AppChipType.defaultType,
    this.isSelected = false,
    this.onSelected,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    Color backgroundColor;
    Color labelColor;
    Color borderColor;
    
    final bool isDisabled = onSelected == null && onPressed == null;

    if (isDisabled) {
      backgroundColor = theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);
      labelColor = isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
      borderColor = Colors.transparent;
    } else {
      switch (type) {
        case AppChipType.selected:
          backgroundColor = theme.colorScheme.primaryContainer;
          labelColor = theme.colorScheme.onPrimaryContainer;
          borderColor = theme.colorScheme.primary;
          break;
        case AppChipType.filter:
          backgroundColor = isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surface;
          labelColor = isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface;
          borderColor = isSelected ? theme.colorScheme.primary : theme.dividerColor;
          break;
        case AppChipType.success:
          backgroundColor = (isDark ? AppColors.darkSuccess : AppColors.lightSuccess).withValues(alpha: 0.1);
          labelColor = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
          borderColor = Colors.transparent;
          break;
        case AppChipType.warning:
          backgroundColor = Colors.orange.withValues(alpha: 0.1);
          labelColor = Colors.orange;
          borderColor = Colors.transparent;
          break;
        case AppChipType.error:
          backgroundColor = theme.colorScheme.error.withValues(alpha: 0.1);
          labelColor = theme.colorScheme.error;
          borderColor = Colors.transparent;
          break;
        case AppChipType.defaultType:
          backgroundColor = theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);
          labelColor = theme.colorScheme.onSurface;
          borderColor = Colors.transparent;
          break;
      }
    }

    return RawChip(
      label: Text(label),
      avatar: icon != null ? Icon(icon, size: 16, color: labelColor) : null,
      selected: isSelected,
      isEnabled: !isDisabled,
      onSelected: onSelected != null ? (bool selected) => onSelected!() : null,
      onPressed: onPressed,
      showCheckmark: false,
      backgroundColor: backgroundColor,
      selectedColor: backgroundColor,
      disabledColor: backgroundColor,
      labelStyle: AppText.label.copyWith(
        color: labelColor,
        fontWeight: isSelected || type == AppChipType.selected ? FontWeight.bold : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
