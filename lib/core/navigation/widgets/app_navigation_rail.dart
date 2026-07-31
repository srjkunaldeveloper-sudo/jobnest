import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import '../providers/navigation_provider.dart';

class AppNavigationRail extends StatelessWidget {
  final NavigationProvider provider;
  const AppNavigationRail({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        return NavigationRail(
          selectedIndex: provider.currentIndex,
          onDestinationSelected: (index) {
            if (provider.items[index].enabled) {
              provider.changeTab(index);
            }
          },
          labelType: NavigationRailLabelType.all,
          backgroundColor: theme.colorScheme.surface,
          useIndicator: true,
          indicatorColor: theme.colorScheme.primaryContainer,
          selectedIconTheme: IconThemeData(color: theme.colorScheme.primary),
          unselectedIconTheme: IconThemeData(color: theme.colorScheme.onSurfaceVariant),
          destinations: provider.items.map((item) {
            Widget iconWidget = Icon(item.icon);
            Widget selectedIconWidget = Icon(item.selectedIcon);
            
            if (item.badgeCount != null && item.badgeCount! > 0) {
              iconWidget = Badge(label: Text(item.badgeCount.toString()), child: iconWidget);
              selectedIconWidget = Badge(label: Text(item.badgeCount.toString()), child: selectedIconWidget);
            }
            if (!item.enabled) {
              iconWidget = Opacity(opacity: 0.4, child: iconWidget);
              selectedIconWidget = Opacity(opacity: 0.4, child: selectedIconWidget);
            }
            
            return NavigationRailDestination(
              icon: iconWidget,
              selectedIcon: selectedIconWidget,
              label: Text(item.title),
            );
          }).toList(),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 24, top: 16),
            child: Icon(AppIcons.work_rounded, color: theme.colorScheme.primary, size: 32),
          ),
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text("JD", style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
