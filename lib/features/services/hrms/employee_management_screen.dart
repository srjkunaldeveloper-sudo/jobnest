import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class EmployeeManagementScreen extends StatelessWidget {
  const EmployeeManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Employee list backend se fetch hogi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Employee Management"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewMetrics(context),
                const SizedBox(height: 32),
                
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
                            icon: Icon(Icons.search_rounded, color: theme.colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list_rounded, size: 18),
                      label: const Text("Filters"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip(context, "All", true),
                      const SizedBox(width: 8),
                      _buildChip(context, "Engineering", false),
                      const SizedBox(width: 8),
                      _buildChip(context, "HR & Admin", false),
                      const SizedBox(width: 8),
                      _buildChip(context, "Sales", false),
                      const SizedBox(width: 8),
                      _buildChip(context, "Marketing", false),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                Text(
                  "Employee Directory",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildEmployeeCard(
                  context,
                  name: "Rahul Sharma",
                  designation: "Senior Software Engineer",
                  department: "Engineering",
                  joiningDate: "Oct 2021",
                  status: "Active",
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildEmployeeCard(
                  context,
                  name: "Priya Singh",
                  designation: "HR Manager",
                  department: "HR & Admin",
                  joiningDate: "Jan 2023",
                  status: "On Leave",
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildEmployeeCard(
                  context,
                  name: "Amit Patel",
                  designation: "Sales Executive",
                  department: "Sales",
                  joiningDate: "Mar 2024",
                  status: "Active",
                  color: Colors.green,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewMetrics(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(context, "Total Employees", "124", Icons.people_rounded, Colors.blueAccent),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildMetricCard(context, "New Joinees (Month)", "8", Icons.person_add_rounded, Colors.green),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildMetricCard(context, "On Leave Today", "3", Icons.event_busy_rounded, Colors.orange),
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(20),
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
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, bool isSelected) {
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {},
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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: Text(
                  name[0],
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      designation,
                      style: theme.textTheme.bodyMedium?.copyWith(
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
                    icon: const Icon(Icons.remove_red_eye_outlined, size: 20),
                    tooltip: "View",
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    tooltip: "Edit",
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_task_rounded, size: 16),
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
