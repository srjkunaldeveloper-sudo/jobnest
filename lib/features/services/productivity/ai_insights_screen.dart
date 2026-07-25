import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class AiInsightsScreen extends StatelessWidget {
  const AiInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: AI Insights ML service se generate honge.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("AI Insights"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded),
            tooltip: "Refresh Insights",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              Text(
                "Actionable Intelligence",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Generated based on your platform activity over the last 30 days.",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              _buildInsightCard(
                context,
                title: "Hiring Trend",
                summary: "Engineering roles are taking 20% longer to close compared to last quarter.",
                recommendation: "Increase referral bonuses for Senior Developer positions.",
                icon: Icons.trending_up_rounded,
                color: Colors.orange,
                confidence: 0.92,
              ),
              const SizedBox(height: 16),
              _buildInsightCard(
                context,
                title: "Candidate Quality",
                summary: "Candidates from 'LinkedIn' source are passing technical rounds at a 40% higher rate.",
                recommendation: "Allocate more budget to LinkedIn sponsored jobs.",
                icon: Icons.star_rounded,
                color: Colors.green,
                confidence: 0.88,
              ),
              const SizedBox(height: 16),
              _buildInsightCard(
                context,
                title: "Hiring Bottlenecks",
                summary: "The 'Technical Assessment' stage has an average waiting time of 5.2 days.",
                recommendation: "Automate technical assessments using JobNest AI tools.",
                icon: Icons.warning_rounded,
                color: Colors.redAccent,
                confidence: 0.95,
              ),
              const SizedBox(height: 16),
              _buildInsightCard(
                context,
                title: "Recruiter Productivity",
                summary: "Morning outreach (9 AM - 11 AM) yields a 35% better candidate response rate.",
                recommendation: "Schedule automated emails for morning delivery.",
                icon: Icons.bolt_rounded,
                color: Colors.blueAccent,
                confidence: 0.85,
              ),
              const SizedBox(height: 16),
              _buildInsightCard(
                context,
                title: "Job Performance",
                summary: "The 'UI/UX Designer' posting has low visibility compared to similar roles.",
                recommendation: "Optimize job description keywords for SEO.",
                icon: Icons.work_rounded,
                color: Colors.purpleAccent,
                confidence: 0.78,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInsightCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String recommendation,
    required IconData icon,
    required Color color,
    required double confidence,
  }) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.auto_awesome_rounded, size: 14, color: theme.colorScheme.primary),
                              const SizedBox(width: 4),
                              Text(
                                "${(confidence * 100).toInt()}% Confidence",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      summary,
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: Colors.amber.shade700, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommendation",
                        style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recommendation,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
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
