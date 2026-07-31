import '../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          AppIcons.work_outline_rounded,
          size: size * 0.5,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
