import 'package:flutter/material.dart';
import '../providers/navigation_provider.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text.dart';

class AppBottomNavigation extends StatelessWidget {
  final NavigationProvider provider;

  const AppBottomNavigation({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.only(top: 12, bottom: 24, left: 16, right: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(top: BorderSide(color: theme.dividerColor)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: provider.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = provider.currentIndex == index;
                
                return GestureDetector(
                  onTap: item.enabled ? () => provider.changeTab(index) : null,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? theme.colorScheme.primaryContainer : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              isSelected ? item.selectedIcon : item.icon,
                              color: isSelected 
                                  ? theme.colorScheme.primary 
                                  : (item.enabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
                            ),
                          ),
                          if (item.badgeCount != null && item.badgeCount! > 0)
                            Positioned(
                              top: -2,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.error,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  item.badgeCount.toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      ),
                      AppSpacing.h4,
                      Text(
                        item.title,
                        style: AppText.labelSmall.copyWith(
                          color: isSelected 
                                ? theme.colorScheme.primary 
                                : (item.enabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
