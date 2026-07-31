import '../../../core/constants/app_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';

class ServicesHeader extends StatelessWidget {
  final VoidCallback? onSearchTap;

  const ServicesHeader({
    super.key,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ServicesDataProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Services",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "AI tools and productivity services for recruiters.",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Semantics(
              label: "Search services",
              button: true,
              child: _buildIconButton(
                context,
                icon: AppIcons.search_rounded,
                tooltip: "Search",
                onPressed: () {
                  if (onSearchTap != null) {
                    onSearchTap!();
                  } else {
                    provider.clearSearchQuery();
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Semantics(
              label: "Recently used tools",
              button: true,
              child: _buildIconButton(
                context,
                icon: AppIcons.history_rounded,
                tooltip: "Recently Used",
                onPressed: () {
                  provider.setSelectedCategory("Recently Used");
                },
              ),
            ),
            const SizedBox(width: 8),
            Semantics(
              label: "More Options",
              button: true,
              child: _buildOverflowMenu(context, provider),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: theme.colorScheme.onSurface),
        tooltip: tooltip,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        onPressed: onPressed,
        splashRadius: 24,
      ),
    );
  }

  Widget _buildOverflowMenu(BuildContext context, ServicesDataProvider provider) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: PopupMenuButton<String>(
        tooltip: "More Options",
        icon: Icon(AppIcons.more_vert_rounded, size: 20, color: theme.colorScheme.onSurface),
        constraints: const BoxConstraints(minWidth: 48),
        onSelected: (value) {
          if (value == "favorites") {
            provider.setSelectedCategory("Favorites");
          } else if (value == "simulate_loading") {
            provider.simulateLoading();
          } else if (value == "simulate_error") {
            provider.simulateError();
          } else if (value == "simulate_empty") {
            provider.simulateEmpty();
          } else if (value == "restore") {
            provider.restoreDefaults();
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: "favorites",
            child: Row(
              children: [
                Icon(AppIcons.favorite_rounded, size: 20, color: Colors.redAccent),
                SizedBox(width: 12),
                Text("Show Favorites", style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          if (kDebugMode) ...[
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: "simulate_loading",
              child: Row(
                children: [
                  Icon(AppIcons.hourglass_empty_rounded, size: 20, color: Colors.blue),
                  SizedBox(width: 12),
                  Text("QA: Loading Skeleton", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "simulate_error",
              child: Row(
                children: [
                  Icon(AppIcons.error_outline_rounded, size: 20, color: Colors.orange),
                  SizedBox(width: 12),
                  Text("QA: Error State", style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "simulate_empty",
              child: Row(
                children: [
                  Icon(AppIcons.inbox_outlined, size: 20, color: Colors.purple),
                  SizedBox(width: 12),
                  Text("QA: Empty State", style: TextStyle(color: Colors.purple)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "restore",
              child: Row(
                children: [
                  Icon(AppIcons.restore_rounded, size: 20, color: Colors.green),
                  SizedBox(width: 12),
                  Text("QA: Restore Defaults", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
