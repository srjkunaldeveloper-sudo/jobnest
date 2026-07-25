import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class CandidatesPipeline extends StatelessWidget {
  const CandidatesPipeline({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hiring Pipeline",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Pipeline backend se sync hogi.
        AppCard(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPipelineStage(context, "Applied", 124, Colors.grey, isFirst: true),
                _buildPipelineStage(context, "Shortlisted", 45, Colors.blue),
                _buildPipelineStage(context, "Interview", 12, Colors.orange),
                _buildPipelineStage(context, "Selected", 3, Colors.green),
                _buildPipelineStage(context, "Rejected", 86, Colors.redAccent, isLast: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPipelineStage(BuildContext context, String title, int count, Color color, {bool isFirst = false, bool isLast = false}) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFirst)
          Container(
            width: 40,
            height: 2,
            margin: const EdgeInsets.only(top: 24),
            color: theme.dividerColor,
          ),
        SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      count.toString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: 1.0,
                backgroundColor: theme.dividerColor.withValues(alpha: 0.5),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                borderRadius: BorderRadius.circular(4),
                minHeight: 4,
              ),
              const SizedBox(height: 16),
              _buildAvatarStack(theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack(ThemeData theme) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.primaryContainer, child: Text("A", style: TextStyle(fontSize: 12, color: theme.colorScheme.onPrimaryContainer))),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.secondaryContainer, child: Text("B", style: TextStyle(fontSize: 12, color: theme.colorScheme.onSecondaryContainer))),
          ),
          Positioned(
            left: 40,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.tertiaryContainer, child: Text("C", style: TextStyle(fontSize: 12, color: theme.colorScheme.onTertiaryContainer))),
          ),
          Positioned(
            left: 60,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.surfaceContainerHighest, child: Text("+9", style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurfaceVariant))),
          ),
        ],
      ),
    );
  }
}
