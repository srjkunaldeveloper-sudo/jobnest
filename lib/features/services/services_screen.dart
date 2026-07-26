import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/features/services/providers/services_data_provider.dart';
import 'package:jobnest/features/services/widgets/services_header.dart';
import 'package:jobnest/features/services/widgets/services_search.dart';
import 'package:jobnest/features/services/widgets/services_categories.dart';
import 'package:jobnest/features/services/widgets/services_featured.dart';
import 'package:jobnest/features/services/widgets/services_recent.dart';
import 'package:jobnest/features/services/widgets/services_grid.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // ===== BACKEND TODO COMMENTS =====
  // TODO:
  // Services API integration.

  // TODO:
  // Dynamic service availability.

  // TODO:
  // Favorites backend sync.

  // TODO:
  // Service analytics.

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ChangeNotifierProvider<ServicesDataProvider>.value(
      value: ServicesDataProvider(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServicesHeader(
                      onSearchTap: () {
                        _searchFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    ServicesSearch(focusNode: _searchFocusNode),
                    const SizedBox(height: 24),
                    
                    const ServicesCategories(),
                    const SizedBox(height: 32),
                    
                    const ServicesFeatured(),
                    const SizedBox(height: 32),
                    
                    const ServicesRecent(),
                    const SizedBox(height: 32),
                    
                    const ServicesGrid(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
