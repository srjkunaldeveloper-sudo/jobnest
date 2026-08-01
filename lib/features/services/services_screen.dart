import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/features/services/providers/services_data_provider.dart';
import 'package:jobnest/features/services/widgets/services_header.dart';
import 'package:jobnest/features/services/widgets/services_search.dart';
import 'package:jobnest/features/services/widgets/services_categories.dart';
import 'package:jobnest/features/services/widgets/services_featured.dart';
import 'package:jobnest/features/services/widgets/services_recent.dart';
import 'package:jobnest/features/services/widgets/services_grid.dart';
import 'package:jobnest/features/services/widgets/services_hub_sections.dart';
import 'package:jobnest/features/services/tools/ai_tools_dashboard_screen.dart';

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
        // backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 48.0, bottom: 24.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Consumer<ServicesDataProvider>(
                  builder: (context, provider, _) {
                    final isOverview = provider.selectedCategory == "All" && provider.searchQuery.isEmpty;
                    return Column(
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
                        
                        if (isOverview) ...[
                          const ServicesFeatured(),
                          const SizedBox(height: 32),
                          
                          const ServicesRecent(),
                          const SizedBox(height: 32),
                          
                          const ServicesAiToolsSection(),
                          const SizedBox(height: 32),
                          
                          const ServicesHrmsSection(),
                          const SizedBox(height: 32),
                          
                          const ServicesCrmSection(),
                          const SizedBox(height: 32),
                          
                          const ServicesAutomationSection(),
                          const SizedBox(height: 32),
                          
                          const ServicesReportsSection(),
                          const SizedBox(height: 40),
                        ],
                        
                        provider.selectedCategory == "AI Tools"
                            ? const AiToolsDashboardScreen(isEmbedded: true)
                            : const ServicesGrid(),
                        const SizedBox(height: 80),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
