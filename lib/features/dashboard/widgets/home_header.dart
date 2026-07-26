import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/notifications/notifications_screen.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const HomeHeader({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Formatting date and time
    final now = DateTime.now();
    final List<String> monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    final List<String> shortDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final String weekdayShort = shortDays[now.weekday - 1];
    final String monthShort = monthNames[now.month - 1];
    
    final dateStr = "$weekdayShort, ${now.day} $monthShort"; // e.g. "Sat, 25 Jul"
    
    final String greetingText = now.hour < 12
        ? "Good Morning"
        : (now.hour < 17 ? "Good Afternoon" : "Good Evening");

    final String subtitleText = "Tech Innovators Pvt Ltd • $dateStr";

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Avatar, Greeting & Subtitle
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Enterprise Avatar with 48dp footprint
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.work_rounded,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                AppSpacing.w16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Greeting: Material 3 Large, Bold
                      Text(
                        greetingText,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Subtitle: Company Name & Date without cramped FittedBox
                      Text(
                        subtitleText,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Right Side: Action Icons & Profile Avatar with equal spacing and 48dp tap targets
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(
                context,
                icon: Icons.notifications_rounded,
                tooltip: "Notifications",
                hasBadge: true,
                onTap: () {
                  // ===== BACKEND TODO =====
                  // TODO: Notifications screen open karna hai yaha se.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
              _buildIconButton(
                context,
                icon: Icons.message_rounded,
                tooltip: "Messages",
                hasBadge: true,
                onTap: () {
                  // ===== BACKEND TODO =====
                  // TODO: Messages list screen open hogi yaha se.
                },
              ),
              const SizedBox(width: 4),
              Semantics(
                label: "User Profile",
                button: true,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onProfileTap,
                        customBorder: const CircleBorder(),
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
                    ),
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
    required String tooltip,
    bool hasBadge = false,
  }) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: tooltip,
      button: true,
      child: SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onTap,
                icon: Icon(icon, size: 24, color: theme.colorScheme.onSurface),
                tooltip: tooltip,
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                splashRadius: 22,
              ),
              if (hasBadge)
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    height: 9,
                    width: 9,
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
          ),
        ),
      ),
    );
  }
}
