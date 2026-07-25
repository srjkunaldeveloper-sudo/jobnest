import 'package:flutter/material.dart';
import '../constants/app_radius.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.large,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
