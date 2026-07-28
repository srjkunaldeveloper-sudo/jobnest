import 'package:flutter/material.dart';

class CandidateIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final String? tooltip;
  final BoxConstraints? constraints;

  const CandidateIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.tooltip,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: iconColor ?? theme.colorScheme.onSurface),
        onPressed: onTap,
        splashRadius: constraints != null ? 22 : 20,
        tooltip: tooltip,
        constraints: constraints,
      ),
    );
  }
}
