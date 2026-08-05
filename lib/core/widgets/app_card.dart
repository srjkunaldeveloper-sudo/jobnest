import 'package:flutter/material.dart';
import '../constants/app_radius.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final br = borderRadius != null
        ? BorderRadius.circular(borderRadius!)
        : BorderRadius.circular(24);

    Widget content = Padding(
      padding: padding ?? const EdgeInsets.all(24.0),
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: br,
        child: content,
      );
    }

    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: br,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
              ],
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.04),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: br,
        child: Material(
          color: Colors.transparent,
          child: content,
        ),
      ),
    );
  }
}
