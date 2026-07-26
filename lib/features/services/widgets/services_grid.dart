import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/features/services/models/service_item.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';
import 'package:jobnest/features/services/widgets/service_detail_modal.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ServicesDataProvider>();
    final filteredList = provider.filteredServices;
    final isLoading = provider.isLoading;
    final isError = provider.isError;

    // ===== BACKEND TODO =====
    // TODO: Future me tools backend se load honge.
    // TODO: Tool permissions backend se manage hongi.
    // TODO: Dynamic service availability.
    // TODO: Favorites backend sync.

    if (isLoading) {
      return _buildSkeletonGrid(context);
    }

    if (isError) {
      return _buildErrorState(context, provider);
    }

    if (filteredList.isEmpty) {
      return _buildEmptyState(context, provider);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              provider.selectedCategory == "All"
                  ? "All Services (${filteredList.length})"
                  : "${provider.selectedCategory} (${filteredList.length})",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
            if (provider.searchQuery.isNotEmpty || provider.selectedCategory != "All")
              Semantics(
                label: "Reset filters",
                button: true,
                child: TextButton.icon(
                  onPressed: () {
                    provider.restoreDefaults();
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text("Reset Filters", style: TextStyle(fontWeight: FontWeight.w600)),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(48, 36),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            double childAspectRatio;
            if (constraints.maxWidth >= 1000) {
              crossAxisCount = 4;
              childAspectRatio = 0.90;
            } else if (constraints.maxWidth >= 600) {
              crossAxisCount = 3;
              childAspectRatio = 0.88;
            } else {
              crossAxisCount = 2;
              childAspectRatio = 0.84;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final service = filteredList[index];
                return _buildServiceGridCard(context, service, provider);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceGridCard(
    BuildContext context,
    ServiceItem service,
    ServicesDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final color = service.color;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: service.isFavorite
              ? Colors.redAccent.withValues(alpha: 0.4)
              : theme.dividerColor.withValues(alpha: 0.5),
          width: service.isFavorite ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Semantics(
          label: "${service.title} tool. ${service.isAvailable ? 'Available' : 'Coming Soon'}. ${service.description}",
          button: true,
          child: InkWell(
            onTap: () {
              ServiceDetailModal.show(context, service, provider);
            },
            borderRadius: BorderRadius.circular(22),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Icon and Favorite / New Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(service.icon, color: color, size: 24),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (service.isNew) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.deepPurpleAccent, Colors.pinkAccent],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "NEW",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                          Semantics(
                            label: service.isFavorite ? "Remove favorite" : "Add favorite",
                            button: true,
                            child: InkResponse(
                              onTap: () => provider.toggleFavorite(service.id),
                              radius: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                                  child: Icon(
                                    service.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                    key: ValueKey<bool>(service.isFavorite),
                                    color: service.isFavorite
                                        ? Colors.redAccent
                                        : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Status Badge
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: service.isAvailable
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      service.isAvailable ? "Available" : "Coming Soon",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: service.isAvailable ? Colors.green.shade700 : Colors.orange.shade800,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),

                  // Title
                  Text(
                    service.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Description
                  Text(
                    service.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.3,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Loading Services...",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth >= 1000
                ? 4
                : constraints.maxWidth >= 600
                    ? 3
                    : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.86,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppShimmerLoading(width: 44, height: 44, borderRadius: BorderRadius.all(Radius.circular(22))),
                          AppShimmerLoading(width: 20, height: 20, borderRadius: BorderRadius.all(Radius.circular(10))),
                        ],
                      ),
                      Spacer(),
                      AppShimmerLoading(width: 60, height: 16),
                      SizedBox(height: 10),
                      AppShimmerLoading(width: double.infinity, height: 18),
                      SizedBox(height: 6),
                      AppShimmerLoading(width: 120, height: 14),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, ServicesDataProvider provider) {
    return AppErrorState(
      title: "Unable to load services",
      message: "A network timeout occurred while fetching recruiter tools from the server. Please check your connection and try again.",
      primaryButtonText: "Retry Connection",
      onRetry: () => provider.refreshServices(),
      iconData: Icons.error_outline_rounded,
    );
  }

  Widget _buildEmptyState(BuildContext context, ServicesDataProvider provider) {
    final theme = Theme.of(context);
    final isSearch = provider.searchQuery.isNotEmpty;
    final isFav = provider.selectedCategory == "Favorites";

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFav
                    ? Icons.favorite_border_rounded
                    : isSearch
                        ? Icons.search_off_rounded
                        : Icons.auto_awesome_outlined,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isFav
                  ? "No favorite tools yet"
                  : isSearch
                      ? "No tools matching '${provider.searchQuery}'"
                      : "No services available.",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isFav
                  ? "Tap the heart icon on any service card in the marketplace to add it to your personal favorites."
                  : isSearch
                      ? "Try searching for another keyword or browse by category above."
                      : "There are no recruitment tools enabled for your current organization license.",
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () => provider.refreshServices(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text("Refresh", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                if (isSearch || provider.selectedCategory != "All") ...[
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => provider.restoreDefaults(),
                      child: const Text("View All Services", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
