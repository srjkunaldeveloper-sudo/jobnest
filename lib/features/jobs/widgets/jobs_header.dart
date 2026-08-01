import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';

class JobsHeader extends StatelessWidget {
  const JobsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Align to start
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jobs",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 24, // 24px size
                    fontWeight: FontWeight.w600, // 600 weight
                    letterSpacing: -0.4,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6), // 6px gap
                Text(
                  "Track and manage your hiring pipeline.",
                  maxLines: 2, // Max 2 lines
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8), // Muted text color
                  ),
                ),
              ],
            ),
          ),
          // Small ghost overflow menu button
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(AppIcons.more_vert_rounded, size: 20, color: theme.colorScheme.onSurface),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 20,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
