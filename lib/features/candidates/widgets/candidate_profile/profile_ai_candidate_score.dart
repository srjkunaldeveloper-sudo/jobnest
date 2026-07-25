import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileAiCandidateScore extends StatelessWidget {
  const ProfileAiCandidateScore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.analytics_rounded, color: Colors.blueAccent, size: 24),
            const SizedBox(width: 12),
            Text(
              "Candidate Score",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Candidate Score backend se calculate hoga.
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: 0.85,
                      strokeWidth: 8,
                      backgroundColor: theme.dividerColor.withValues(alpha: 0.5),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "8.5",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            "/ 10",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: [
                    _buildScoreBar(context, "Skills Match", 0.9, Colors.green),
                    const SizedBox(height: 12),
                    _buildScoreBar(context, "Experience", 0.8, Colors.blue),
                    const SizedBox(height: 12),
                    _buildScoreBar(context, "Education", 0.7, Colors.orange),
                    const SizedBox(height: 12),
                    _buildScoreBar(context, "Communication", 0.85, Colors.purple),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreBar(BuildContext context, String label, double value, Color color) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${(value * 10).toStringAsFixed(1)} / 10",
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: theme.dividerColor.withValues(alpha: 0.5),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius: BorderRadius.circular(4),
          minHeight: 6,
        ),
      ],
    );
  }
}
