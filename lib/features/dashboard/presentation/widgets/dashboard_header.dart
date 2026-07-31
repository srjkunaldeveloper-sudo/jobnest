import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_colors.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/features/notifications/notifications_screen.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const HomeHeader({super.key, this.onProfileTap});

  static bool _isDesktop(double w)  => w > 800;
  static bool _isTablet(double w)   => w > 480 && w <= 800;

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width  = MediaQuery.of(context).size.width;

    final now   = DateTime.now();
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final days   = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    final dateStr = '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';

    final String greeting = now.hour < 12
        ? 'Good morning'
        : (now.hour < 17 ? 'Good afternoon' : 'Good evening');

    final bool isDesktop = _isDesktop(width);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateStr.toUpperCase(),
                      style: AppText.labelSmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "$greeting, John.",
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.2,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              if (isDesktop)
                Row(
                  children: [
                    _OutlinedAction(
                      icon: AppIcons.search,
                      label: "Search (⌘K)",
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _OutlinedAction(
                      icon: AppIcons.notifications,
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                      },
                      hasBadge: true,
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: onProfileTap,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.dividerColor, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: theme.colorScheme.onSurface,
                          child: Text(
                            "JD",
                            style: AppText.labelSmall.copyWith(
                              color: theme.colorScheme.surface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 24),
          // Quick filter chips matching Linear style
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _StatusChip(label: "Overview", isSelected: true, theme: theme),
                const SizedBox(width: 8),
                _StatusChip(label: "My Tasks", count: "12", theme: theme),
                const SizedBox(width: 8),
                _StatusChip(label: "Interviews", count: "3", theme: theme),
                const SizedBox(width: 8),
                _StatusChip(label: "Candidates", theme: theme),
                const SizedBox(width: 8),
                _StatusChip(label: "Performance", theme: theme),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedAction extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final bool hasBadge;

  const _OutlinedAction({
    required this.icon,
    this.label,
    required this.onTap,
    this.hasBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(8),
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ]
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 16, color: theme.colorScheme.onSurface),
                if (hasBadge)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(
                label!,
                style: AppText.labelSmall.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final String? count;
  final bool isSelected;
  final ThemeData theme;

  const _StatusChip({
    required this.label,
    this.count,
    this.isSelected = false,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? theme.colorScheme.onSurface : Colors.transparent;
    final textColor = isSelected ? theme.colorScheme.surface : theme.colorScheme.onSurfaceVariant;
    
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: theme.dividerColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppText.labelSmall.copyWith(
                color: textColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.surface.withValues(alpha: 0.2) : theme.dividerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count!,
                  style: AppText.labelSmall.copyWith(
                    color: textColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
