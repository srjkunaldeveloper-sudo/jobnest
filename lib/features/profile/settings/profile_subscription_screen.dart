import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileSubscriptionScreen extends StatelessWidget {
  const ProfileSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Subscription & Billing"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              _buildCurrentPlanCard(context),
              const SizedBox(height: 32),
              Text(
                "Billing History",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildBillingTile(context, "Oct 01, 2026", "Enterprise Monthly", "\$499.00", "Paid"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildBillingTile(context, "Sep 01, 2026", "Enterprise Monthly", "\$499.00", "Paid"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildBillingTile(context, "Aug 01, 2026", "Enterprise Monthly", "\$499.00", "Paid"),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPlanCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Plan", style: theme.textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(
                    "Enterprise Edition",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Active",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          Text("Included Features:", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildFeatureRow(context, "Unlimited active job postings"),
          const SizedBox(height: 8),
          _buildFeatureRow(context, "Advanced AI candidate matching"),
          const SizedBox(height: 8),
          _buildFeatureRow(context, "Full CRM & HRMS tool access"),
          const SizedBox(height: 8),
          _buildFeatureRow(context, "24/7 Priority Support"),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Upgrade to Ultimate"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary, size: 20),
        const SizedBox(width: 12),
        Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildBillingTile(BuildContext context, String date, String plan, String amount, String status) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.receipt_long_rounded),
      ),
      title: Text(plan, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(date),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(status, style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
