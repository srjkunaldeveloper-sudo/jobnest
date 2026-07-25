import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class CrmPipelineScreen extends StatelessWidget {
  const CrmPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Pipeline data CRM backend se load hogi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Hiring Pipeline"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            tooltip: "New Deal",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKanbanColumn(
              context,
              title: "Lead",
              count: "3",
              color: Colors.blueGrey,
              cards: [
                _buildDealCard(context, "TechCorp - Sr. Dev", "\$15,000", "High", Colors.redAccent),
                _buildDealCard(context, "Alpha Inc - UI/UX", "\$8,000", "Low", Colors.green),
                _buildDealCard(context, "Beta LLC - Manager", "\$12,000", "Medium", Colors.orange),
              ],
            ),
            const SizedBox(width: 24),
            _buildKanbanColumn(
              context,
              title: "Discussion",
              count: "2",
              color: Colors.orange,
              cards: [
                _buildDealCard(context, "Gamma Co - Backend", "\$18,000", "High", Colors.redAccent),
                _buildDealCard(context, "Delta Corp - HR", "\$5,000", "Low", Colors.green),
              ],
            ),
            const SizedBox(width: 24),
            _buildKanbanColumn(
              context,
              title: "Req. Received",
              count: "1",
              color: Colors.blueAccent,
              cards: [
                _buildDealCard(context, "Omega - Data Scientist", "\$22,000", "High", Colors.redAccent),
              ],
            ),
            const SizedBox(width: 24),
            _buildKanbanColumn(
              context,
              title: "Interview Running",
              count: "2",
              color: Colors.purpleAccent,
              cards: [
                _buildDealCard(context, "Sigma - DevOps", "\$14,000", "Medium", Colors.orange),
                _buildDealCard(context, "Epsilon - QA", "\$9,000", "Low", Colors.green),
              ],
            ),
            const SizedBox(width: 24),
            _buildKanbanColumn(
              context,
              title: "Offer",
              count: "1",
              color: Colors.teal,
              cards: [
                _buildDealCard(context, "Zeta - PM", "\$16,000", "Medium", Colors.orange),
              ],
            ),
            const SizedBox(width: 24),
            _buildKanbanColumn(
              context,
              title: "Closed",
              count: "5+",
              color: Colors.green,
              cards: [
                _buildDealCard(context, "Theta - Analyst", "\$7,500", "Low", Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKanbanColumn(BuildContext context, {required String title, required String count, required Color color, required List<Widget> cards}) {
    final theme = Theme.of(context);
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count,
                    style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: cards.map((card) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: card,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(BuildContext context, String title, String value, String priority, Color priorityColor) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  priority,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: priorityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.more_horiz_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.monetization_on_rounded, size: 16, color: Colors.green.shade600),
              const SizedBox(width: 4),
              Text(
                value,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
