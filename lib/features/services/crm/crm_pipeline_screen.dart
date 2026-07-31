import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';

class CrmPipelineScreen extends StatelessWidget {
  const CrmPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Pipeline data CRM backend se load hogi.
    return AppPageScaffold(
      title: "Hiring Pipeline",
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(AppIcons.add_rounded),
          tooltip: "New Deal",
        ),
        AppSpacing.w8,
      ],
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.edgeInsetsAll24,
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
            AppSpacing.w24,
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
            AppSpacing.w24,
            _buildKanbanColumn(
              context,
              title: "Req. Received",
              count: "1",
              color: Colors.blueAccent,
              cards: [
                _buildDealCard(context, "Omega - Data Scientist", "\$22,000", "High", Colors.redAccent),
              ],
            ),
            AppSpacing.w24,
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
            AppSpacing.w24,
            _buildKanbanColumn(
              context,
              title: "Offer",
              count: "1",
              color: Colors.teal,
              cards: [
                _buildDealCard(context, "Zeta - PM", "\$16,000", "Medium", Colors.orange),
              ],
            ),
            AppSpacing.w24,
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
                    AppSpacing.w12,
                    Text(
                      title,
                      style: AppText.h3.copyWith(fontSize: 16),
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
                    style: AppText.label.copyWith(fontWeight: FontWeight.bold),
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
      padding: AppSpacing.edgeInsetsAll16,
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
                  style: AppText.labelSmall.copyWith(
                    color: priorityColor,
                  ),
                ),
              ),
              Icon(AppIcons.more_horiz_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
          AppSpacing.h12,
          Text(
            title,
            style: AppText.h3.copyWith(fontSize: 14),
          ),
          AppSpacing.h16,
          Row(
            children: [
              Icon(AppIcons.monetization_on_rounded, size: 16, color: Colors.green.shade600),
              AppSpacing.w4,
              Text(
                value,
                style: AppText.label.copyWith(
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
