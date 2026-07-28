import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/features/services/models/service_item.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';
import 'package:jobnest/features/services/widgets/service_detail_modal.dart';
import 'package:jobnest/features/services/widgets/services_hub_sections.dart';

class ServicesRecent extends StatelessWidget {
  const ServicesRecent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ServicesDataProvider>();
    final recentList = provider.recentServices;

    // ===== BACKEND TODO =====
    // TODO: Recently Used backend/local storage se aayega.
    // TODO: Service analytics.

    if (recentList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicesSectionHeader(
          title: "Recently Used",
          description: "Quick access to your most frequently launched recruitment tools and CRM modules.",
          onViewAll: () => provider.setSelectedCategory("Recently Used"),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: recentList.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: _buildRecentCard(context, item, provider),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCard(
    BuildContext context,
    ServiceItem item,
    ServicesDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final color = item.color;
    
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Semantics(
          label: "Recently used tool: ${item.title}, used ${item.lastUsedTime ?? 'recently'}",
          button: true,
          child: InkWell(
            onTap: () {
              ServiceDetailModal.show(context, item, provider);
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(item.icon, color: color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.lastUsedTime ?? "Recently",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
