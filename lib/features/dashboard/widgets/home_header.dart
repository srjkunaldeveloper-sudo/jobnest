import 'package:flutter/material.dart';


import 'package:jobnest/core/constants/app_spacing.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const HomeHeader({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Formatting date and time
    final now = DateTime.now();
    final List<String> monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    final List<String> dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    final String weekday = dayNames[now.weekday - 1];
    final String month = monthNames[now.month - 1];
    
    final int hour = now.hour == 0 ? 12 : (now.hour > 12 ? now.hour - 12 : now.hour);
    final String amPm = now.hour >= 12 ? 'PM' : 'AM';
    final String minute = now.minute.toString().padLeft(2, '0');
    
    final dateStr = "$weekday, ${now.day} $month";
    final timeStr = "$hour:$minute $amPm";

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Greeting & Date/Time
          Expanded(
            child: Row(
              children: [
                // Company/App Logo or Recruiter Avatar
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.work_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppSpacing.w16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning, Kunal",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSpacing.h4,
                      Row(
                        children: [
                          Text(
                            "Tech Innovators Inc.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: CircleAvatar(
                              radius: 2,
                              backgroundColor: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                          ),
                          Text(
                            "$dateStr • $timeStr",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Right Side: Actions
          Row(
            children: [
              _buildIconButton(
                context,
                icon: Icons.search_rounded,
                onTap: () {
                  // ===== BACKEND TODO =====
                  // TODO: Global Search bottom sheet trigger yaha hoga.
                },
              ),
              _buildIconButton(
                context,
                icon: Icons.notifications_rounded,
                hasBadge: true,
                onTap: () {
                  // ===== BACKEND TODO =====
                  // TODO: Notifications screen open karna hai yaha se.
                },
              ),
              _buildIconButton(
                context,
                icon: Icons.message_rounded,
                hasBadge: true,
                onTap: () {
                  // ===== BACKEND TODO =====
                  // TODO: Messages list screen open hogi yaha se.
                },
              ),
              AppSpacing.w8,
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.dividerColor,
                      width: 1.5,
                    ),
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    final theme = Theme.of(context);
    
    return Stack(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 24, color: theme.colorScheme.onSurface),
          splashRadius: 20,
        ),
        if (hasBadge)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.scaffoldBackgroundColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
