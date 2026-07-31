import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import '../providers/navigation_provider.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text.dart';

class AppSidebar extends StatelessWidget {
  final NavigationProvider provider;
  const AppSidebar({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 280, // Fixed desktop sidebar width
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppSpacing.edgeInsetsAll24,
            child: Row(
              children: [
                Icon(AppIcons.work_rounded, color: theme.colorScheme.primary, size: 32),
                AppSpacing.w12,
                Text(
                  "JobNest",
                  style: AppText.h2,
                ),
              ],
            ),
          ),
          AppSpacing.h16,
          Expanded(
            child: ListenableBuilder(
              listenable: provider,
              builder: (context, _) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: provider.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isSelected = provider.currentIndex == index;
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: item.enabled ? () => provider.changeTab(index) : null,
                          borderRadius: BorderRadius.circular(12),
                          hoverColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? theme.colorScheme.primaryContainer 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? item.selectedIcon : item.icon,
                                  color: isSelected 
                                      ? theme.colorScheme.primary 
                                      : (item.enabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
                                  size: 24,
                                ),
                                AppSpacing.w16,
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: AppText.bodyMedium.copyWith(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                      color: isSelected 
                                          ? theme.colorScheme.primary 
                                          : (item.enabled ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
                                    ),
                                  ),
                                ),
                                if (item.badgeCount != null && item.badgeCount! > 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.error,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      item.badgeCount.toString(),
                                      style: AppText.labelSmall.copyWith(color: theme.colorScheme.onError),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: AppSpacing.edgeInsetsAll24,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text("JD", style: AppText.label.copyWith(color: theme.colorScheme.onPrimaryContainer)),
                ),
                AppSpacing.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("John Doe", style: AppText.h3.copyWith(fontSize: 14)),
                      Text("Recruiter", style: AppText.caption),
                    ],
                  ),
                ),
                Icon(AppIcons.more_vert_rounded, color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
