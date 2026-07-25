import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ClientManagementScreen extends StatelessWidget {
  const ClientManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Clients list backend CRM se fetch hogi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Client Management"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_business_rounded),
            tooltip: "Add Client",
          ),
          const SizedBox(width: 8),
        ],
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
                            hintText: "Search Clients...",
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
                      _buildChip(context, "All Clients", true),
                      const SizedBox(width: 8),
                      _buildChip(context, "Active", false),
                      const SizedBox(width: 8),
                      _buildChip(context, "Lead", false),
                      const SizedBox(width: 8),
                      _buildChip(context, "Churned", false),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                Text(
                  "Client Directory",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildClientCard(
                  context,
                  companyName: "TechCorp Inc.",
                  industry: "Software & Technology",
                  activeJobs: "4",
                  openPositions: "12",
                  accountManager: "Rahul Sharma",
                  status: "Active",
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildClientCard(
                  context,
                  companyName: "FinServe Partners",
                  industry: "Banking & Finance",
                  activeJobs: "2",
                  openPositions: "5",
                  accountManager: "Priya Singh",
                  status: "Lead",
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildClientCard(
                  context,
                  companyName: "HealthPlus+",
                  industry: "Healthcare",
                  activeJobs: "1",
                  openPositions: "3",
                  accountManager: "Amit Patel",
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
          child: _buildMetricCard(context, "Total Clients", "42", Icons.business_rounded, Colors.blueAccent),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildMetricCard(context, "New Leads", "15", Icons.person_add_alt_1_rounded, Colors.orange),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildMetricCard(context, "Active Accounts", "24", Icons.verified_rounded, Colors.green),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
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

  Widget _buildClientCard(
    BuildContext context, {
    required String companyName,
    required String industry,
    required String activeJobs,
    required String openPositions,
    required String accountManager,
    required String status,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    companyName[0],
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      industry,
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
          const SizedBox(height: 24),
          Row(
            children: [
              _buildInfoStat(context, "Active Jobs", activeJobs),
              const SizedBox(width: 24),
              _buildInfoStat(context, "Open Positions", openPositions),
              const SizedBox(width: 24),
              _buildInfoStat(context, "Account Manager", accountManager),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                label: const Text("View"),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text("Edit"),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.work_outline_rounded, size: 18),
                label: const Text("Open Jobs"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoStat(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
