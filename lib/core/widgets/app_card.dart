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
    final shape = RoundedRectangleBorder(
      borderRadius: borderRadius != null
          ? BorderRadius.circular(borderRadius!)
          : AppRadius.large,
    );

    Widget content = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        child: content,
      );
    }

    return Card(
      margin: margin ?? EdgeInsets.zero,
      shape: shape,
      clipBehavior: onTap != null ? Clip.antiAlias : null,
      child: content,
    );
  }
}
