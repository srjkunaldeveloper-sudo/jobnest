import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class CandidatesAutoScreening extends StatefulWidget {
  const CandidatesAutoScreening({super.key});

  @override
  State<CandidatesAutoScreening> createState() => _CandidatesAutoScreeningState();
}

class _CandidatesAutoScreeningState extends State<CandidatesAutoScreening> {
  bool _autoScreeningEnabled = true;
  bool _aiRankingEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Auto Screening AI backend yaha connect hoga.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.auto_awesome_rounded, color: Colors.deepPurpleAccent, size: 24),
            const SizedBox(width: 12),
            Text(
              "AI Auto Screening",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                value: _autoScreeningEnabled,
                onChanged: (val) => setState(() => _autoScreeningEnabled = val),
                title: Text(
                  "Enable Auto Screening",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Automatically filter out candidates that do not meet minimum requirements."),
                activeTrackColor: Colors.deepPurpleAccent.withValues(alpha: 0.5),
                activeThumbColor: Colors.deepPurpleAccent,
                contentPadding: EdgeInsets.zero,
              ),
              const Divider(),
              SwitchListTile(
                value: _aiRankingEnabled,
                onChanged: (val) => setState(() => _aiRankingEnabled = val),
                title: Text(
                  "Enable AI Ranking",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Sort candidates based on AI match score instead of application date."),
                activeTrackColor: Colors.deepPurpleAccent.withValues(alpha: 0.5),
                activeThumbColor: Colors.deepPurpleAccent,
                contentPadding: EdgeInsets.zero,
              ),
              
              if (_autoScreeningEnabled) ...[
                const SizedBox(height: 24),
                Text(
                  "Minimum Requirements",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildRequirementChip(context, "Experience", "3+ Years", Icons.work_history_rounded),
                    _buildRequirementChip(context, "Skills", "Flutter, Dart", Icons.code_rounded),
                    _buildRequirementChip(context, "Education", "Bachelors", Icons.school_rounded),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementChip(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
