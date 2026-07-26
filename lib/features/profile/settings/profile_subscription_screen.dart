import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileSubscriptionScreen extends StatelessWidget {
  const ProfileSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Fetch recruiter profile.
    // TODO: Subscription billing API sync.
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              _buildCurrentPlanCard(context),
              const SizedBox(height: 32),
              Text(
                "Billing History & Invoices",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildBillingTile(context, "Oct 01, 2026", "Enterprise Recruiter Suite - Monthly", "\$499.00", "Paid"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildBillingTile(context, "Sep 01, 2026", "Enterprise Recruiter Suite - Monthly", "\$499.00", "Paid"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildBillingTile(context, "Aug 01, 2026", "Enterprise Recruiter Suite - Monthly", "\$499.00", "Paid"),
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
                  Text("CURRENT PLAN", style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                  const SizedBox(height: 6),
                  Text(
                    "Enterprise Edition",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, color: Colors.green, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Active License",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 20),
          Text("Included Enterprise Capabilities:", style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildFeatureRow(context, "Unlimited active requisition postings and candidate pipelines"),
          const SizedBox(height: 12),
          _buildFeatureRow(context, "Advanced AI candidate skill matching & automated ranking"),
          const SizedBox(height: 12),
          _buildFeatureRow(context, "Full access to ATS, CRM, HRMS & API Integration suites"),
          const SizedBox(height: 12),
          _buildFeatureRow(context, "24/7 Dedicated Recruiter Priority Support & SLA 99.99%"),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Connecting to billing management portal... (Dummy)")),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Manage Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Upgrade options requested. An enterprise sales rep will contact you.")),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Upgrade Seats", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, String feature) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline_rounded, color: theme.colorScheme.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(feature, style: const TextStyle(fontWeight: FontWeight.w500, height: 1.3, fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildBillingTile(BuildContext context, String date, String description, String amount, String status) {
    final theme = Theme.of(context);
    return Semantics(
      label: "Invoice: $description on $date. Amount: $amount. Status: $status",
      button: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.receipt_long_rounded, color: theme.colorScheme.primary, size: 22),
          ),
          title: Text(description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(date, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 12)),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(status, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.download_rounded, size: 20),
                tooltip: "Download Invoice PDF",
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Downloading invoice for $date... (Dummy)")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
