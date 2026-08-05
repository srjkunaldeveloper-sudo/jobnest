import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class PipelineStage {
  final String name;
  final int candidateCount;
  final IconData icon;
  final Color color;
  final String statusLabel; // e.g. "Completed", "Active", "Pending"
  final String? metaLabel; // e.g. "+12 Today", "5 Pending", etc.

  const PipelineStage({
    required this.name,
    required this.candidateCount,
    required this.icon,
    required this.color,
    required this.statusLabel,
    this.metaLabel,
  });
}

class DetailsPipeline extends StatelessWidget {
  final List<PipelineStage>? stages;
  final VoidCallback? onViewCandidates;

  const DetailsPipeline({
    super.key,
    this.stages,
    this.onViewCandidates,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // If stages list is null or empty, display a professional empty state
    if (stages == null || stages!.isEmpty) {
      return AppCard(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.account_tree_outlined,
                size: 48,
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                "No Hiring Pipeline Available",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Pipeline information will appear once candidates enter the recruitment workflow.",
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

    final activeStages = stages!;

    // Separate Rejected stage from the main linear pipeline flow
    final mainFlowStages = activeStages.where((s) => s.name.toLowerCase() != "rejected").toList();
    final hasRejected = activeStages.any((s) => s.name.toLowerCase() == "rejected");
    final rejectedStage = hasRejected
        ? activeStages.firstWhere((s) => s.name.toLowerCase() == "rejected")
        : null;
    final int rejectedCount = rejectedStage?.candidateCount ?? 0;

    // SECTION 2 Calculations: Overall Completion Percentage
    final int totalActive = mainFlowStages.fold(0, (sum, stage) => sum + stage.candidateCount);
    final hiredStage = mainFlowStages.firstWhere(
      (s) => s.name.toLowerCase() == "hired",
      orElse: () => mainFlowStages.last,
    );
    final int hiredCount = hiredStage.candidateCount;
    final double completionPct = totalActive > 0 ? (hiredCount / totalActive) * 100 : 0.0;
    final bool showProgressCard = totalActive > 0;

    // SECTION 4 Calculations: Pipeline Health Summary Metrics
    final int appliedCount = mainFlowStages.any((s) => s.name.toLowerCase() == "applied")
        ? mainFlowStages.firstWhere((s) => s.name.toLowerCase() == "applied").candidateCount
        : 0;
    final int qualifiedCount = mainFlowStages
        .where((s) => ["ai screening", "resume review", "technical review", "resume viewer", "tech review"].contains(s.name.toLowerCase()))
        .fold<int>(0, (sum, s) => sum + s.candidateCount);
    final int interviewedCount = mainFlowStages
        .where((s) => ["ai interview", "human interview", "hr round"].contains(s.name.toLowerCase()))
        .fold<int>(0, (sum, s) => sum + s.candidateCount);

    // SECTION 5 Calculations: Stage Conversion Rates
    final List<Widget> conversionRows = [];
    if (mainFlowStages.length > 1) {
      for (int i = 0; i < mainFlowStages.length - 1; i++) {
        final current = mainFlowStages[i];
        final next = mainFlowStages[i + 1];
        if (current.candidateCount > 0) {
          final double rate = (next.candidateCount / current.candidateCount) * 100;
          if (rate <= 100) {
            conversionRows.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${current.name} → ${next.name}",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      "${rate.toStringAsFixed(1)}%",
                      style: theme.textTheme.labelMedium?.copyWith(
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
                    "Hiring Pipeline",
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Track candidate movement through every recruitment stage.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // SECTION 2: Overall Progress Card
        if (showProgressCard) ...[
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Overall Hiring Progress",
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${completionPct.toStringAsFixed(1)}%",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: completionPct / 100,
                  backgroundColor: theme.dividerColor.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // SECTION 4: Pipeline Health Summary Card (Compact Metric Chips)
        AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pipeline Health Summary",
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (appliedCount > 0) _buildHealthChip(theme, "Applied", appliedCount, Colors.blue),
                  if (qualifiedCount > 0) _buildHealthChip(theme, "Qualified", qualifiedCount, Colors.purple),
                  if (interviewedCount > 0) _buildHealthChip(theme, "Interviewed", interviewedCount, Colors.orange),
                  if (hiredCount > 0) _buildHealthChip(theme, "Hired", hiredCount, Colors.green),
                  if (rejectedCount > 0) _buildHealthChip(theme, "Rejected", rejectedCount, Colors.red),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECTION 3: Recruiter ATS Pipeline (Vertical Flow)
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mainFlowStages.length,
            itemBuilder: (context, index) {
              final stage = mainFlowStages[index];
              final isLast = index == mainFlowStages.length - 1;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Stage Icon
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: stage.color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(stage.icon, size: 16, color: stage.color),
                      ),
                      const SizedBox(width: 16),

                      // Stage Name & Status Indicator
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stage.name,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                _buildStatusDot(theme, stage.statusLabel),
                                if (stage.metaLabel != null && stage.metaLabel!.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  Text(
                                    stage.metaLabel!,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Candidate count
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.dividerColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          "${stage.candidateCount} candidates",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Vertical connector line
                  if (!isLast)
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          width: 2,
                          height: 18,
                          color: theme.dividerColor.withValues(alpha: 0.4),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),

        // SECTION 3 Cont: Separate terminal card for Rejected status (displayed only if data exists)
        if (rejectedCount > 0 && rejectedStage != null) ...[
          const SizedBox(height: 12),
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(rejectedStage.icon, size: 16, color: Colors.redAccent),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rejectedStage.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        rejectedStage.statusLabel.isNotEmpty
                            ? rejectedStage.statusLabel
                            : "Terminal status (excluded from flow)",
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    "$rejectedCount candidates",
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // SECTION 5: Stage Conversion Card
        if (conversionRows.isNotEmpty) ...[
          const SizedBox(height: 16),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stage Conversion Rates",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                ...conversionRows,
              ],
            ),
          ),
        ],

        // SECTION 6: Bottom Action View Candidates
        if (onViewCandidates != null) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onViewCandidates,
              icon: const Icon(Icons.people_outline, size: 18),
              label: const Text("View Pipeline Candidates"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHealthChip(ThemeData theme, String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$count",
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDot(ThemeData theme, String status) {
    Color color = Colors.grey;
    if (status == "Completed") {
      color = Colors.green;
    } else if (status == "Active") {
      color = Colors.orange;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          status,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
