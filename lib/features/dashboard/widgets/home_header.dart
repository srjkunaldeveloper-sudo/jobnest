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
        children: [
          // LEFT: Avatar (User Profile)
          Semantics(
            label: "User Profile",
            button: true,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onProfileTap,
                customBorder: const CircleBorder(),
                child: Container(
                  height: 48,
                  width: 48,
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
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // CENTER (Expanded): Greeting & Company Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
          
          const SizedBox(width: 8),
          
          // RIGHT: Action Icons (Intrinsic width)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(
                context,
                icon: Icons.notifications_rounded,
                tooltip: "Notifications",
                hasBadge: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              _buildIconButton(
                context,
                icon: Icons.message_rounded,
                tooltip: "Messages",
                hasBadge: true,
                onTap: () {},
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
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: onTap,
            icon: Icon(icon, size: 24, color: theme.colorScheme.onSurface),
            tooltip: tooltip,
            padding: const EdgeInsets.all(6),
            constraints: const BoxConstraints(), // Removes default minimum sizes
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            splashRadius: 20,
          ),
          if (hasBadge)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                height: 8,
                width: 8,
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
    );
  }
}
