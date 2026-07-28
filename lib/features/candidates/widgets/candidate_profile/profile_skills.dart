import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileSkills extends StatelessWidget {
  final List<String> skills;

  const ProfileSkills({
    super.key,
    this.skills = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displaySkills = skills.isNotEmpty
        ? skills
        : const [
            "Flutter",
            "Dart",
            "Firebase",
            "Provider/BLoC",
            "Python",
            "UI/UX Design",
            "Agile",
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Skills",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List<Widget>.generate(
              displaySkills.length,
              (index) => _buildSkillChip(
                context,
                displaySkills[index],
                _levelForIndex(index),
                _colorForIndex(theme, index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill, String level, Color levelColor) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            skill,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: levelColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              level,
              style: theme.textTheme.labelSmall?.copyWith(
                color: levelColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _levelForIndex(int index) {
    if (index < 2) {
      return "Expert";
    }
    if (index < 4) {
      return "Advanced";
    }
    if (index < 6) {
      return "Intermediate";
    }
    return "Familiar";
  }

  Color _colorForIndex(ThemeData theme, int index) {
    if (index < 2) {
      return Colors.blue;
    }
    if (index < 4) {
      return Colors.orange;
    }
    if (index < 6) {
      return Colors.green;
    }
    return theme.colorScheme.onSurfaceVariant;
  }
}
