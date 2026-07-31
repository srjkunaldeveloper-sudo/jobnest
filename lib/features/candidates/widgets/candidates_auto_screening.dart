import '../../../core/constants/app_icons.dart';
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
            const Icon(AppIcons.auto_awesome_rounded, color: Colors.deepPurpleAccent, size: 20),
            const SizedBox(width: 10),
            Text(
              "AI Auto Screening",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCompactSwitchRow(
                context,
                title: "Enable Auto Screening",
                subtitle: "Automatically filter out candidates that do not meet minimum requirements.",
                value: _autoScreeningEnabled,
                onChanged: (val) => setState(() => _autoScreeningEnabled = val),
              ),
              const SizedBox(height: 16),
              _buildCompactSwitchRow(
                context,
                title: "Enable AI Ranking",
                subtitle: "Sort candidates based on AI match score instead of application date.",
                value: _aiRankingEnabled,
                onChanged: (val) => setState(() => _aiRankingEnabled = val),
              ),
              
              if (_autoScreeningEnabled) ...[
                const SizedBox(height: 24),
                Text(
                  "Minimum Requirements",
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildRequirementChip(context, "Experience", "3+ Years", AppIcons.work_history_rounded)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildRequirementChip(context, "Skills", "Flutter, Dart", AppIcons.code_rounded)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildRequirementChip(context, "Education", "Bachelors", AppIcons.school_rounded)),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactSwitchRow(BuildContext context, {required String title, required String subtitle, required bool value, required ValueChanged<bool> onChanged}) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Transform.scale(
          scale: 0.8,
          alignment: Alignment.topRight,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Colors.deepPurpleAccent,
            inactiveTrackColor: theme.colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementChip(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 9,
                    letterSpacing: 0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
