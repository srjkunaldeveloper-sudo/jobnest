import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class FunnelStageData {
  final String name;
  final int count;
  final Color color;

  const FunnelStageData({
    required this.name,
    required this.count,
    required this.color,
  });
}

class DetailsAnalytics extends StatelessWidget {
  final int? appliedCount;
  final int? interviewCount;
  final int? hiredCount;
  final int? rejectedCount;
  final List<FunnelStageData>? funnelStages;
  final double? hiringSuccessRate;
  final double? selectionRate;
  final double? interviewSuccessRate;

  const DetailsAnalytics({
    super.key,
    this.appliedCount,
    this.interviewCount,
    this.hiredCount,
    this.rejectedCount,
    this.funnelStages,
    this.hiringSuccessRate,
    this.selectionRate,
    this.interviewSuccessRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool hasData = (appliedCount != null && appliedCount! > 0) ||
        (interviewCount != null && interviewCount! > 0) ||
        (hiredCount != null && hiredCount! > 0) ||
        (rejectedCount != null && rejectedCount! > 0) ||
        (funnelStages != null && funnelStages!.isNotEmpty);

    if (!hasData) {
      return _buildEmptyState(context);
    }

    final activeFunnelStages = funnelStages ?? const [];

    // Calculations for Conversion Rates sequentially from provided funnel stages
    final List<Widget> conversionRows = [];
    if (activeFunnelStages.length > 1) {
      for (int i = 0; i < activeFunnelStages.length - 1; i++) {
        final current = activeFunnelStages[i];
        final next = activeFunnelStages[i + 1];
        if (current.count > 0) {
          final double rate = (next.count / current.count) * 100;
          if (rate <= 100) {
            conversionRows.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${current.name} → ${next.name}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      "${rate.toStringAsFixed(1)}%",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SECTION 1: Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hiring Analytics",
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Monitor recruitment performance and pipeline conversion.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // SECTION 6: Analytics Period
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Weekly",
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: theme.colorScheme.onSurface),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // SECTION 2: Summary Metrics
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (appliedCount != null && appliedCount! > 0)
              _buildSummaryCard(context, "Applications", appliedCount!, Colors.blue),
            if (interviewCount != null && interviewCount! > 0)
              _buildSummaryCard(context, "Interviews", interviewCount!, Colors.orange),
            if (hiredCount != null && hiredCount! > 0)
              _buildSummaryCard(context, "Hired", hiredCount!, Colors.green),
            if (rejectedCount != null && rejectedCount! > 0)
              _buildSummaryCard(context, "Rejected", rejectedCount!, Colors.red),
          ],
        ),
        const SizedBox(height: 20),

        // SECTION 3: Hiring Funnel
        if (activeFunnelStages.isNotEmpty)
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hiring Funnel",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: activeFunnelStages.length,
                  itemBuilder: (context, index) {
                    final stage = activeFunnelStages[index];
                    final isLast = index == activeFunnelStages.length - 1;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFunnelRow(context, stage.name, stage.count, stage.color),
                        if (!isLast) _buildFunnelArrow(theme),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),

        // SECTION 4: Conversion Metrics
        if (conversionRows.isNotEmpty)
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Conversion Metrics",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...conversionRows,
              ],
            ),
          ),
        const SizedBox(height: 16),

        // SECTION 5: Recruitment Performance
        if ((hiringSuccessRate != null && hiringSuccessRate! > 0) ||
            (selectionRate != null && selectionRate! > 0) ||
            (interviewSuccessRate != null && interviewSuccessRate! > 0))
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recruitment Performance",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                if (hiringSuccessRate != null && hiringSuccessRate! > 0)
                  _buildPerformanceRow(theme, "Overall Hiring Success", hiringSuccessRate!),
                if (interviewSuccessRate != null && interviewSuccessRate! > 0)
                  _buildPerformanceRow(theme, "Interview Success Rate", interviewSuccessRate!),
                if (selectionRate != null && selectionRate! > 0)
                  _buildPerformanceRow(theme, "Selection Rate", selectionRate!),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bar_chart_rounded, size: 48, color: theme.colorScheme.primary.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              "No Analytics Available",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Recruitment analytics will appear after candidate activity begins.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String label, int count, Color color) {
    final theme = Theme.of(context);
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            count.toString(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelRow(BuildContext context, String stageName, int count, Color color) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 8,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            stageName,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "$count candidates",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFunnelArrow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2),
      child: Icon(
        Icons.arrow_downward_rounded,
        size: 14,
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildPerformanceRow(ThemeData theme, String metric, double rate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            metric,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            "${rate.toStringAsFixed(1)}%",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
