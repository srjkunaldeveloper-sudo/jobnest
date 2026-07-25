import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile Summary",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double itemWidth;
              if (constraints.maxWidth > 600) {
                itemWidth = (constraints.maxWidth - (24 * 2)) / 3; // 3 columns
              } else {
                itemWidth = (constraints.maxWidth - 24) / 2; // 2 columns
              }

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: _buildSummaryItem(context, Icons.email_outlined, "Email", "rahul.sharma@example.com"),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildSummaryItem(context, Icons.phone_outlined, "Phone", "+91 98765 43210"),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildSummaryItem(context, Icons.business_outlined, "Current Company", "TechCorp India"),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildSummaryItem(context, Icons.work_history_outlined, "Total Experience", "5 Years 2 Months"),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildSummaryItem(context, Icons.access_time_rounded, "Notice Period", "15 Days"),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildSummaryItem(context, Icons.location_city_outlined, "Preferred Location", "Bangalore, Remote"),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
