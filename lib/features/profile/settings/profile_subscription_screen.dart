import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';

class ProfileSubscriptionScreen extends StatelessWidget {
  const ProfileSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Fetch subscription.

    // TODO:
    // Fetch invoices.

    // TODO:
    // Payment gateway integration.

    // TODO:
    // Subscription API.

    // TODO:
    // Invoice download.

    // TODO:
    // Auto renewal.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription & Billing"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => provider.toggleSubscriptionTrialState(),
            icon: Icon(
              provider.isSubscriptionTrial
                  ? Icons.timer_rounded
                  : Icons.timer_outlined,
              color: provider.isSubscriptionTrial
                  ? Colors.amber.shade800
                  : null,
            ),
            tooltip: provider.isSubscriptionTrial
                ? "Exit Trial Mode"
                : "Simulate Trial State",
          ),
          IconButton(
            onPressed: () => provider.toggleSubscriptionEmptyState(),
            icon: Icon(
              provider.isSubscriptionEmpty
                  ? Icons.remove_shopping_cart_rounded
                  : Icons.shopping_cart_checkout_outlined,
              color: provider.isSubscriptionEmpty ? theme.colorScheme.error : null,
            ),
            tooltip: provider.isSubscriptionEmpty
                ? "Restore Populated Subscription"
                : "Simulate Unsubscribed / Empty State",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: provider.isSubscriptionEmpty
          ? _buildEmptyState(context, provider)
          : _buildPopulatedState(context, provider),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: Column(
            children: [
              AppCard(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer
                            .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.workspace_premium_outlined,
                        size: 56,
                        color: theme.colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "No active subscription found.",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Upgrade your JobNest recruiter workspace to unlock active job requisition limits, AI talent matching, and unlimited candidate sourcing.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () {
                        provider.upgradePlan("Business Edition");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Activated Business Edition subscription (Dummy action)",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.flash_on_rounded),
                      label: const Text(
                        "Choose a Plan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Text(
                "Available Enterprise Plans",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildAvailablePlansSection(context, provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopulatedState(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trial Section Banner (if on trial)
              if (provider.isSubscriptionTrial) ...[
                _buildTrialBanner(context, provider),
                const SizedBox(height: 20),
              ],

              // Section 1: Current Plan Card
              _buildCurrentPlanCard(context, provider),
              const SizedBox(height: 28),

              // Section 2: Plan Benefits & Usage Matrix
              Text(
                "Plan Benefits & Active Usage",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Monitor real-time consumption against your enterprise plan limits.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 14),
              _buildPlanBenefitsGrid(context, provider),
              const SizedBox(height: 32),

              // Section 3: Available Plans Grid / Directory
              Text(
                "Available Plans & Tiers",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Scale recruitment capacity with transparent, enterprise-grade pricing.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 14),
              _buildAvailablePlansSection(context, provider),
              const SizedBox(height: 32),

              // Section 4: Payment Methods Placeholders
              Text(
                "Payment Methods",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Manage corporate billing instruments for automatic invoice settlement.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 14),
              _buildPaymentMethodsSection(context, provider),
              const SizedBox(height: 32),

              // Section 5: Billing History (Invoices)
              Text(
                "Billing History & Invoices",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Download tax-compliant receipts and review past billing transactions.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 14),
              _buildBillingHistorySection(context, provider),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrialBanner(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade800.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade800.withValues(alpha: 0.4)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timer_rounded, color: Colors.amber.shade800, size: 28),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Free Enterprise Trial Active",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                  Text(
                    "${provider.trialDaysRemaining} Days Remaining in your evaluation period.",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Wrap(
            spacing: 10,
            children: [
              OutlinedButton(
                onPressed: () => _showFeatureComparisonDialog(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amber.shade900,
                  side: BorderSide(color: Colors.amber.shade800),
                ),
                child: const Text("Compare Plans"),
              ),
              FilledButton.icon(
                onPressed: () {
                  provider.upgradePlan("Business Edition");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Upgraded to full Business Edition (Dummy action)",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.amber.shade800,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.verified_rounded, size: 16),
                label: const Text("Upgrade Now"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPlanCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final status = provider.currentPlanStatus;

    Color statusColor;
    IconData statusIcon;
    if (status == "Active") {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_rounded;
    } else if (status == "Trial") {
      statusColor = Colors.amber.shade800;
      statusIcon = Icons.hourglass_top_rounded;
    } else if (status == "Expired") {
      statusColor = theme.colorScheme.error;
      statusIcon = Icons.error_rounded;
    } else {
      statusColor = theme.colorScheme.onSurfaceVariant;
      statusIcon = Icons.cancel_rounded;
    }

    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CURRENT PLAN SUBSCRIPTION",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    provider.currentPlanName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    provider.billingCycle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      status,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 32,
            runSpacing: 16,
            children: [
              _buildStatCol(
                theme,
                "Active Since",
                provider.activeSince,
                Icons.calendar_today_outlined,
              ),
              _buildStatCol(
                theme,
                "Renewal Date",
                provider.renewalDate,
                Icons.event_repeat_rounded,
              ),
              _buildStatCol(
                theme,
                "Plan Expiry",
                provider.planExpiry,
                Icons.event_busy_outlined,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              FilledButton.icon(
                onPressed: () {
                  provider.renewPlan();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Plan renewed successfully for 12 months (Dummy action)",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.autorenew_rounded, size: 18),
                label: const Text("Renew Plan"),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  provider.cancelSubscription();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Subscription cancelled. Service active until renewal date (Dummy action)",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 18,
                  color: theme.colorScheme.error,
                ),
                label: Text(
                  "Cancel Subscription",
                  style: TextStyle(color: theme.colorScheme.error),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.error),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCol(
    ThemeData theme,
    String label,
    String val,
    IconData icon,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              val,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlanBenefitsGrid(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: provider.planLimits.map((limit) {
        return _buildBenefitCard(context, limit);
      }).toList(),
    );
  }

  Widget _buildBenefitCard(BuildContext context, PlanLimitItem limit) {
    final theme = Theme.of(context);
    final isUnlimited = limit.maxLimit <= 0 || limit.maxLimit >= 999999;
    final progress = isUnlimited ? 0.3 : (limit.currentUsage / limit.maxLimit);
    final progressColor = progress > 0.85
        ? theme.colorScheme.error
        : (progress > 0.7 ? Colors.amber.shade800 : theme.colorScheme.primary);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 450),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    limit.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  isUnlimited
                      ? "Unlimited"
                      : "${limit.currentUsage} / ${limit.maxLimit}",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor:
                    theme.colorScheme.outline.withValues(alpha: 0.15),
                color: progressColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isUnlimited
                  ? "Enterprise unthrottled capacity"
                  : "${((1.0 - progress) * 100).clamp(0, 100).toInt()}% capacity remaining",
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailablePlansSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: provider.availablePlans.map((plan) {
        return _buildPlanCard(context, provider, plan);
      }).toList(),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    ProfileDataProvider provider,
    SubscriptionPlanItem plan,
  ) {
    final theme = Theme.of(context);
    final isCurrent = plan.isCurrentPlan;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCurrent
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.2),
            width: isCurrent ? 2 : 1,
          ),
          boxShadow: [
            if (isCurrent)
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "CURRENT",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              plan.monthlyPrice,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              plan.featureSummary,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            const SizedBox(height: 14),
            _buildPlanSpecRow(theme, Icons.people_outline, plan.recruiterSeats),
            const SizedBox(height: 8),
            _buildPlanSpecRow(theme, Icons.work_outline, plan.jobPostingLimit),
            const SizedBox(height: 8),
            _buildPlanSpecRow(
              theme,
              Icons.folder_shared_outlined,
              plan.candidateLimit,
            ),
            const SizedBox(height: 8),
            _buildPlanSpecRow(theme, Icons.auto_awesome_outlined, plan.aiFeatures),
            const SizedBox(height: 8),
            _buildPlanSpecRow(
              theme,
              Icons.support_agent_outlined,
              plan.supportLevel,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: isCurrent
                  ? OutlinedButton(
                      onPressed: null,
                      child: const Text("Current Plan"),
                    )
                  : FilledButton(
                      onPressed: () {
                        if (plan.name == "Starter" || plan.name == "Professional") {
                          provider.downgradePlan(plan.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Downgraded to ${plan.name} (Dummy action)",
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          provider.upgradePlan(plan.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Upgraded to ${plan.name} (Dummy action)",
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      child: Text(
                        plan.name == "Enterprise"
                            ? "Upgrade Plan"
                            : "Select Plan",
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanSpecRow(ThemeData theme, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: provider.paymentMethods.map((pm) {
        return _buildPaymentMethodCard(context, provider, pm);
      }).toList(),
    );
  }

  Widget _buildPaymentMethodCard(
    BuildContext context,
    ProfileDataProvider provider,
    PaymentMethodPlaceholderItem pm,
  ) {
    final theme = Theme.of(context);
    final isDefault = pm.isDefault;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 450),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(pm.icon, color: theme.colorScheme.primary, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pm.type,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "DEFAULT",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pm.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    pm.subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (!isDefault)
                        TextButton(
                          onPressed: () {
                            provider.setDefaultPaymentMethod(pm.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Set ${pm.type} as default billing method (Dummy action)",
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 24),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text("Set as Default"),
                        ),
                      if (!isDefault) const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Updating ${pm.type} details (Dummy action)",
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 24),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text("Update"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingHistorySection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_outlined,
                  color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Text(
                "Corporate Invoice Archive",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.billingHistory.length,
            separatorBuilder: (ctx, index) => Divider(
              height: 24,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            itemBuilder: (context, index) {
              final inv = provider.billingHistory[index];
              return _buildInvoiceRow(context, inv);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(BuildContext context, InvoiceItem inv) {
    final theme = Theme.of(context);

    Color statusColor;
    if (inv.status == "Paid") {
      statusColor = Colors.green;
    } else if (inv.status == "Pending") {
      statusColor = Colors.amber.shade800;
    } else if (inv.status == "Failed") {
      statusColor = theme.colorScheme.error;
    } else {
      statusColor = Colors.purple;
    }

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.description_outlined,
                  size: 20, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inv.invoiceId,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Billing Date: ${inv.billingDate}",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              inv.amount,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                inv.status.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.download_rounded, size: 20),
              tooltip: "Download Invoice PDF",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Downloading invoice ${inv.invoiceId} (Dummy action)",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showFeatureComparisonDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.compare_arrows_rounded),
            SizedBox(width: 10),
            Expanded(child: Text("Enterprise Plan Matrix Comparison")),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Compare recruiter capabilities across JobNest editions:",
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              _buildMatrixRow("Active Jobs", "10", "30", "50", "Unlimited"),
              _buildMatrixRow("Candidate Pool", "500", "2.5k", "10k", "Unlimited"),
              _buildMatrixRow("Recruiter Seats", "2", "5", "15", "Unlimited"),
              _buildMatrixRow("AI Matching", "Basic", "Advanced", "Full Suite", "Custom"),
              _buildMatrixRow("Support SLA", "Email", "24/5", "24/7", "Dedicated"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixRow(
    String feat,
    String s,
    String p,
    String b,
    String e,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(feat, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: Text(s, style: const TextStyle(fontSize: 11))),
          Expanded(child: Text(p, style: const TextStyle(fontSize: 11))),
          Expanded(child: Text(b, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
          Expanded(child: Text(e, style: const TextStyle(fontSize: 11))),
        ],
      ),
    );
  }
}
