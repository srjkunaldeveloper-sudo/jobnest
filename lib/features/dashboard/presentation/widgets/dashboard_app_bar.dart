import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_logo.dart';

/// Reusable application bar for the Dashboard, displaying the logo, title, and quick actions.
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;

  const DashboardAppBar({
    super.key,
    required this.onNotificationTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: AppLogo(size: 32),
      ),
      title: Text(
        'JobNest',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(AppIcons.notifications_outlined),
          onPressed: onNotificationTap,
          tooltip: 'Notifications',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: onProfileTap,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                AppIcons.person_outline,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
