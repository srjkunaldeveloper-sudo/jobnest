import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';
import 'package:jobnest/core/widgets/app_chip.dart';

class EmployeeManagementScreen extends StatelessWidget {
  const EmployeeManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Employee list backend se fetch hogi.
    return AppPageScaffold(
      title: "Employee Management",
      body: SingleChildScrollView(
        padding: AppSpacing.edgeInsetsAll24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                _buildOverviewMetrics(context),
                AppSpacing.h32,
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Employees...",
                            border: InputBorder.none,
                            icon: Icon(AppIcons.search_rounded, color: theme.colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.w16,
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(AppIcons.filter_list_rounded, size: 18),
                      label: const Text("Filters"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                AppSpacing.h16,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip(context, "All", true),
                      AppSpacing.w8,
                      _buildChip(context, "Engineering", false),
                      AppSpacing.w8,
                      _buildChip(context, "HR & Admin", false),
                      AppSpacing.w8,
                      _buildChip(context, "Sales", false),
                      AppSpacing.w8,
                      _buildChip(context, "Marketing", false),
                    ],
                  ),
                ),
                AppSpacing.h32,
                
                Text(
                  "Employee Directory",
                  style: AppText.h3,
                ),
                AppSpacing.h16,
                
                _buildEmployeeCard(
                  context,
                  name: "Rahul Sharma",
                  designation: "Senior Software Engineer",
                  department: "Engineering",
                  joiningDate: "Oct 2021",
                  status: "Active",
                  color: Colors.green,
                ),
                AppSpacing.h16,
                _buildEmployeeCard(
                  context,
                  name: "Priya Singh",
                  designation: "HR Manager",
                  department: "HR & Admin",
                  joiningDate: "Jan 2023",
                  status: "On Leave",
                  color: Colors.orange,
                ),
                AppSpacing.h16,
                _buildEmployeeCard(
                  context,
                  name: "Amit Patel",
                  designation: "Sales Executive",
                  department: "Sales",
                  joiningDate: "Mar 2024",
                  status: "Active",
                  color: Colors.green,
                ),
                AppSpacing.h48,
              ],
            ),
          ),
    );
  }

  Widget _buildOverviewMetrics(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(context, "Total Employees", "124", AppIcons.people_rounded, Colors.blueAccent),
        ),
        AppSpacing.w16,
        Expanded(
          child: _buildMetricCard(context, "New Joinees (Month)", "8", AppIcons.person_add_rounded, Colors.green),
        ),
        AppSpacing.w16,
        Expanded(
          child: _buildMetricCard(context, "On Leave Today", "3", AppIcons.event_busy_rounded, Colors.orange),
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return AppCard(
      padding: AppSpacing.edgeInsetsAll24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          AppSpacing.h16,
          Text(
            value,
            style: AppText.h1,
          ),
          AppSpacing.h4,
          Text(
            title,
            style: AppText.label.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, bool isSelected) {
    return AppChip(
      label: label,
      type: AppChipType.filter,
      isSelected: isSelected,
      onSelected: () {},
    );
  }

  Widget _buildEmployeeCard(
    BuildContext context, {
    required String name,
    required String designation,
    required String department,
    required String joiningDate,
    required String status,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return AppCard(
      padding: AppSpacing.edgeInsetsAll24,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: Text(
                  name[0],
                  style: AppText.h3.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              AppSpacing.w16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppText.h3.copyWith(fontSize: 16),
                    ),
                    AppSpacing.h4,
                    Text(
                      designation,
                      style: AppText.bodyMedium.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Department", style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Text(department, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Joined", style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Text(joiningDate, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(AppIcons.remove_red_eye_outlined, size: 20),
                    tooltip: "View",
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(AppIcons.edit_outlined, size: 20),
                    tooltip: "Edit",
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(AppIcons.add_task_rounded, size: 16),
                    label: const Text("Task"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
