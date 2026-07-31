import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 800; 

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (isMobile) ...[
              Icon(AppIcons.work_rounded, color: theme.colorScheme.primary, size: 28),
              AppSpacing.w12,
              Text("JobNest", style: AppText.h3),
              const Spacer(),
            ],
            if (!isMobile) ...[
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search candidates, jobs, or deals...",
                      prefixIcon: const Icon(AppIcons.search_rounded),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.w24,
            ],
            
            if (isMobile)
              IconButton(
                icon: const Icon(AppIcons.search_rounded),
                onPressed: () {},
              ),
            IconButton(
              icon: Badge(
                label: const Text("3"),
                child: const Icon(AppIcons.notifications_none_rounded),
              ),
              onPressed: () {},
            ),
            AppSpacing.w12,
            if (!isMobile) ...[
              IconButton(
                icon: const Icon(AppIcons.settings_outlined),
                onPressed: () {},
              ),
              AppSpacing.w12,
            ],
            CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text("JD", style: AppText.labelSmall.copyWith(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
