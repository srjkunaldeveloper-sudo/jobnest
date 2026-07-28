import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/features/services/models/service_item.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';
import 'package:jobnest/features/services/widgets/service_detail_modal.dart';
import 'package:jobnest/features/services/widgets/services_hub_sections.dart';

class ServicesFeatured extends StatelessWidget {
  const ServicesFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ServicesDataProvider>();
    final featuredList = provider.featuredServices;

    if (featuredList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicesSectionHeader(
          title: "Featured AI Tools",
          description: "Curated high-priority artificial intelligence tools to accelerate candidate screening and qualification.",
          onViewAll: () => provider.setSelectedCategory("AI Tools"),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: featuredList.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _buildFeaturedCard(context, item, provider),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(
    BuildContext context,
    ServiceItem item,
    ServicesDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final color = item.color;
    
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ServiceDetailModal.show(context, item, provider);
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Icon, New badge & Favorite heart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: color, size: 28),
                    ),
                    Row(
                      children: [
                        if (item.isNew) ...[
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
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Semantics(
                          label: item.isFavorite ? "Remove from favorites" : "Add to favorites",
                          button: true,
                          child: InkResponse(
                            onTap: () => provider.toggleFavorite(item.id),
                            radius: 24,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                                child: Icon(
                                  item.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  key: ValueKey<bool>(item.isFavorite),
                                  color: item.isFavorite ? Colors.redAccent : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  item.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Semantics(
                    label: "Explore ${item.title} tool details",
                    button: true,
                    child: FilledButton.icon(
                      onPressed: () {
                        ServiceDetailModal.show(context, item, provider);
                      },
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text("Explore Tool", style: TextStyle(fontWeight: FontWeight.bold)),
                      style: FilledButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
