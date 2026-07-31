import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/features/services/models/service_item.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';

class ServiceDetailModal extends StatelessWidget {
  final ServiceItem service;
  final ServicesDataProvider provider;

  const ServiceDetailModal({
    super.key,
    required this.service,
    required this.provider,
  });

  static void show(BuildContext context, ServiceItem service, ServicesDataProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ServiceDetailModal(service: service, provider: provider),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.dividerColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Row(
                  children: [
                    // Favorite Toggle Button
                    Semantics(
                      label: service.isFavorite ? "Remove from favorites" : "Add to favorites",
                      button: true,
                      child: IconButton(
                        icon: Icon(
                          service.isFavorite ? AppIcons.favorite_rounded : AppIcons.favorite_border_rounded,
                          color: service.isFavorite ? Colors.redAccent : theme.colorScheme.onSurfaceVariant,
                          size: 24,
                        ),
                        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                        onPressed: () {
                          provider.toggleFavorite(service.id);
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Close Button
                    Semantics(
                      label: "Close details",
                      button: true,
                      child: IconButton(
                        icon: const Icon(AppIcons.close_rounded),
                        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Service Header info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: service.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(service.icon, color: service.color, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // Status Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: service.isAvailable
                                  ? Colors.green.withValues(alpha: 0.12)
                                  : Colors.orange.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: service.isAvailable
                                    ? Colors.green.withValues(alpha: 0.4)
                                    : Colors.orange.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              service.isAvailable ? "Available" : "Coming Soon",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: service.isAvailable ? Colors.green.shade700 : Colors.orange.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // New Badge
                          if (service.isNew)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.deepPurpleAccent, Colors.pinkAccent],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "NEW",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              service.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),

            // Benefits Section
            Text(
              "Key Benefits & Features",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...service.benefits.map((benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        AppIcons.check_circle_rounded,
                        color: service.color,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          benefit,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 16),

            // Coming Soon Notice Box
            if (!service.isAvailable)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(AppIcons.info_outline_rounded, color: Colors.orange.shade800, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "This tool is undergoing internal QA and will be enabled in an upcoming enterprise release.",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.orange.shade200 : Colors.orange.shade900,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Primary Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: Semantics(
                label: service.isAvailable ? "Launch ${service.title}" : "Notify me when ${service.title} is available",
                button: true,
                child: FilledButton.icon(
                  onPressed: () {
                    if (service.isAvailable) {
                      provider.markAsLaunched(service.id);
                      Navigator.pop(context);
                      if (service.screen != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => service.screen!),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Launching ${service.title}..."),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You will be notified as soon as ${service.title} goes live!"),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    service.isAvailable ? AppIcons.launch_rounded : AppIcons.notifications_active_outlined,
                    size: 20,
                  ),
                  label: Text(
                    service.isAvailable ? "Launch Tool" : "Notify Me When Available",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: service.isAvailable ? service.color : theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
