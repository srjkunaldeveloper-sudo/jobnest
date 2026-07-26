import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';

class ServicesCategories extends StatelessWidget {
  const ServicesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ServicesDataProvider>();
    final categories = provider.categories;
    final selectedCategory = provider.selectedCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Semantics(
              label: "Filter by category: $category",
              selected: isSelected,
              button: true,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: ChoiceChip(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (category == "Favorites") ...[
                          Icon(
                            isSelected ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 16,
                            color: isSelected ? Colors.white : Colors.redAccent,
                          ),
                          const SizedBox(width: 6),
                        ] else if (category == "Recently Used") ...[
                          Icon(
                            Icons.history_rounded,
                            size: 16,
                            color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(category),
                      ],
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      provider.setSelectedCategory(category);
                    }
                  },
                  showCheckmark: false,
                  backgroundColor: theme.colorScheme.surface,
                  selectedColor: category == "Favorites"
                      ? Colors.redAccent
                      : theme.colorScheme.primaryContainer,
                  labelStyle: theme.textTheme.labelMedium?.copyWith(
                    color: category == "Favorites" && isSelected
                        ? Colors.white
                        : isSelected
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                      color: category == "Favorites" && isSelected
                          ? Colors.redAccent
                          : isSelected
                              ? theme.colorScheme.primary
                              : theme.dividerColor.withValues(alpha: 0.6),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
