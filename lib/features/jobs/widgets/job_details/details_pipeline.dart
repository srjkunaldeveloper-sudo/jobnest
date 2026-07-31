import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class DetailsPipeline extends StatelessWidget {
  const DetailsPipeline({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hiring Pipeline",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Pipeline Firestore/API se update hogi.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPipelineStage(context, "Applied", "180", 1.0, Colors.blueAccent),
              const SizedBox(width: 16),
              _buildPipelineStage(context, "Shortlisted", "45", 0.25, Colors.orangeAccent),
              const SizedBox(width: 16),
              _buildPipelineStage(context, "Interview", "12", 0.08, Colors.deepPurpleAccent),
              const SizedBox(width: 16),
              _buildPipelineStage(context, "Selected", "2", 0.02, Colors.green),
              const SizedBox(width: 16),
              _buildPipelineStage(context, "Rejected", "15", 0.1, Colors.redAccent),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPipelineStage(BuildContext context, String title, String count, double progress, Color color) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: 200,
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
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 56,
                  height: 24,
                  child: Stack(
                    children: [
                      Positioned(left: 0, child: _buildAvatar(color)),
                      Positioned(left: 16, child: _buildAvatar(color)),
                      Positioned(left: 32, child: _buildAvatar(color)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "+ view all",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.dividerColor.withValues(alpha: 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Icon(AppIcons.person, size: 14, color: color),
    );
  }
}
