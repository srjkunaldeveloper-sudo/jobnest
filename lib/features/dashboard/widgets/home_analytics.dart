import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/features/dashboard/models/models.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomeAnalytics extends StatelessWidget {
  const HomeAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();
    final bool isLoading = provider.isDashboardLoading;
    final bool isWeekly = provider.isAnalyticsWeekly;
    final AnalyticsFunnelModel funnel = provider.analyticsFunnel;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hiring Analytics",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              // Weekly / Monthly Toggle
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.dividerColor.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    _buildToggleButton(context, "Weekly", isWeekly, () => provider.toggleAnalyticsPeriod(true)),
                    _buildToggleButton(context, "Monthly", !isWeekly, () => provider.toggleAnalyticsPeriod(false)),
                  ],
                ),
              )
            ],
          ),
          AppSpacing.h16,
          // ===== BACKEND TODO =====
          // TODO: Analytics API se fetch hogi (funnel metrics).
          if (isLoading)
            const AppShimmerLoading(
              width: double.infinity,
              height: 260,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            )
          else
            AppCard(
              borderRadius: 18,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildFunnelStage(context, "Applications", funnel.applications, Colors.blueAccent),
                  _buildRatioLine(context, "Application → Interview Ratio", funnel.conversionRate),
                  _buildFunnelStage(context, "Interviews", funnel.interviews, Colors.purpleAccent),
                  _buildRatioLine(context, "Interview → Selection Ratio", funnel.offerRate),
                  _buildFunnelStage(context, "Selected", funnel.selected, Colors.teal),
                  
                  AppSpacing.h24,
                  const Divider(),
                  AppSpacing.h16,
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overall Hiring Success",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.trending_up_rounded, size: 16, color: Colors.green),
                            AppSpacing.w8,
                            Text(
                              funnel.overallSuccessRate,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context, String text, bool isSelected, VoidCallback onTap) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildFunnelStage(BuildContext context, String label, String value, Color color) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            AppSpacing.w12,
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRatioLine(BuildContext context, String label, String ratio) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 5), // Align with circle center
          Container(
            width: 2,
            height: 32,
            color: theme.dividerColor,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  ratio,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
