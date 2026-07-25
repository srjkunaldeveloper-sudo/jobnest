import 'package:flutter/material.dart';

import 'package:jobnest/features/services/widgets/services_header.dart';
import 'package:jobnest/features/services/widgets/services_search.dart';
import 'package:jobnest/features/services/widgets/services_categories.dart';
import 'package:jobnest/features/services/widgets/services_featured.dart';
import 'package:jobnest/features/services/widgets/services_recent.dart';
import 'package:jobnest/features/services/widgets/services_grid.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ServicesHeader(),
              SizedBox(height: 32),
              
              ServicesSearch(),
              SizedBox(height: 24),
              
              ServicesCategories(),
              SizedBox(height: 32),
              
              ServicesFeatured(),
              SizedBox(height: 32),
              
              ServicesRecent(),
              SizedBox(height: 32),
              
              ServicesGrid(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
