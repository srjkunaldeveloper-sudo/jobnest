import 'package:flutter/material.dart';

class CandidateStageBadge extends StatelessWidget {
  final String stage;
  final bool isUppercase;

  const CandidateStageBadge({
    super.key,
    required this.stage,
    this.isUppercase = false,
  });

  static Color getStageColor(String stage) {
    final s = stage.toLowerCase();
    if (s == "applied") return Colors.blueGrey;
    if (s == "screening") return Colors.blueAccent;
    if (s == "interview") return Colors.deepPurpleAccent;
    if (s == "offer") return Colors.amber.shade700;
    if (s == "hired") return Colors.green;
    if (s == "rejected") return Colors.redAccent;
    return Colors.blueAccent;
  }

  static IconData getStageIcon(String stage) {
    final s = stage.toLowerCase();
    if (s == "applied") return Icons.inbox_rounded;
    if (s == "screening") return Icons.fact_check_outlined;
    if (s == "interview") return Icons.people_alt_outlined;
    if (s == "offer") return Icons.verified_outlined;
    if (s == "hired") return Icons.check_circle_rounded;
    if (s == "rejected") return Icons.cancel_outlined;
    return Icons.group_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = getStageColor(stage);
    final icon = getStageIcon(stage);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isUppercase ? 0.15 : 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isUppercase ? color : color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              isUppercase ? stage.toUpperCase() : stage,
              style: (isUppercase ? theme.textTheme.labelSmall : theme.textTheme.labelMedium)?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
                letterSpacing: isUppercase ? 0.5 : null,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
