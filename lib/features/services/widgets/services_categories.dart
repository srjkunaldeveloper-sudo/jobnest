import 'package:flutter/material.dart';

class ServicesCategories extends StatefulWidget {
  const ServicesCategories({super.key});

  @override
  State<ServicesCategories> createState() => _ServicesCategoriesState();
}

class _ServicesCategoriesState extends State<ServicesCategories> {
  final List<String> _categories = [
    "All",
    "AI Tools",
    "HRMS",
    "CRM",
    "Automation",
    "Templates",
    "Recently Used",
  ];
  
  String _selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final isSelected = category == _selectedCategory;
          final theme = Theme.of(context);
          
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedCategory = category);
                }
              },
              showCheckmark: false,
              backgroundColor: theme.colorScheme.surface,
              selectedColor: theme.colorScheme.primaryContainer,
              labelStyle: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
