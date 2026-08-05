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
    final isDark = theme.brightness == Brightness.dark;

    final activeColor = isDark ? const Color(0xFF818CF8) : const Color(0xFF4F6DFF);
    final inactiveColor = const Color(0xFF64748B);
    final activeBgColor = isDark ? const Color(0xFF312E81) : const Color(0xFFEEF2FF);

    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        return Container(
          height: 76,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(38),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: provider.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = provider.currentIndex == index;

              return GestureDetector(
                onTap: item.enabled ? () => provider.changeTab(index) : null,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutCubic,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? activeBgColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            isSelected ? item.selectedIcon : item.icon,
                            size: 24,
                            color: isSelected ? activeColor : inactiveColor,
                          ),
                        ),
                        if (item.badgeCount != null && item.badgeCount! > 0)
                          Positioned(
                            top: -2,
                            right: 2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.error,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                item.badgeCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        letterSpacing: -0.2,
                        color: isSelected ? activeColor : inactiveColor,
                      ),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
