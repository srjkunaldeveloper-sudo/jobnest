import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class HomeFocus extends StatelessWidget {
  const HomeFocus({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Today's Focus",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              AppSpacing.w8,
              Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: 20,
              ),
            ],
          ),
          AppSpacing.h16,
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFocusItem(
                  context,
                  icon: Icons.calendar_month_rounded,
                  iconColor: theme.colorScheme.primary,
                  text: "3 interviews today",
                ),
                AppSpacing.h16,
                _buildFocusItem(
                  context,
                  icon: Icons.group_add_rounded,
                  iconColor: Colors.orange,
                  text: "12 new candidates",
                ),
                AppSpacing.h16,
                _buildFocusItem(
                  context,
                  icon: Icons.campaign_rounded,
                  iconColor: theme.colorScheme.error,
                  text: "2 urgent jobs",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusItem(BuildContext context, {required IconData icon, required Color iconColor, required String text}) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        AppSpacing.w16,
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        Icon(
          Icons.chevron_right_rounded,
          color: theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ],
    );
  }
}
