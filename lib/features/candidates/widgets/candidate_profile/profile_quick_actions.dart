import 'package:flutter/material.dart';

class ProfileQuickActions extends StatelessWidget {
  final String candidateName;
  final String currentStage;
  final ValueChanged<String>? onMoveStage;
  final VoidCallback? onArchive;

  const ProfileQuickActions({
    super.key,
    this.candidateName = "Candidate",
    this.currentStage = "Screening",
    this.onMoveStage,
    this.onArchive,
  });

  void _showMoveStageDialog(BuildContext context) {
    final theme = Theme.of(context);
    final stages = ["Applied", "Screening", "Interview", "Offer", "Hired", "Rejected"];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Move Stage: $candidateName", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: stages.map((stg) {
            final isCur = stg.toLowerCase() == currentStage.toLowerCase();
            return ListTile(
              leading: Icon(
                isCur ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
                color: isCur ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
              ),
              title: Text(stg, style: TextStyle(fontWeight: isCur ? FontWeight.bold : FontWeight.normal)),
              onTap: () {
                Navigator.pop(ctx);
                if (onMoveStage != null) {
                  onMoveStage!(stg);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ===== BACKEND TODO =====
        // TODO: Shortlist API connect hogi.
        // TODO: Message backend integration future me hogi.
        // TODO: Candidate stage update API.
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Scheduled interview with $candidateName. Calendar invite sent!")),
                  );
                },
                icon: const Icon(Icons.calendar_month_outlined, size: 20),
                label: const Text("Schedule Interview"),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: onMoveStage == null ? null : () => _showMoveStageDialog(context),
                icon: const Icon(Icons.swap_horiz_rounded, size: 20),
                label: const Text("Move Stage"),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Opening messaging thread with $candidateName...")),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                label: const Text("Send Message"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Downloading resume PDF for $candidateName...")),
                  );
                },
                icon: const Icon(Icons.download_rounded, size: 20),
                label: const Text("Download Resume"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onArchive,
                icon: const Icon(Icons.archive_outlined, size: 20),
                label: const Text("Archive"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
