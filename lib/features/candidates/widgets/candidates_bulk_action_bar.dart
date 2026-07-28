import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';

class CandidatesBulkActionBar extends StatelessWidget {
  final Set<String> selectedCandidateIds;
  final VoidCallback onClearSelection;
  final RecruitmentDataProvider provider;
  final bool isMobile;

  const CandidatesBulkActionBar({
    super.key,
    required this.selectedCandidateIds,
    required this.onClearSelection,
    required this.provider,
    required this.isMobile,
  });

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showBulkMoveStageDialog(BuildContext context) {
    final theme = Theme.of(context);
    final stages = ["Applied", "Screening", "Interview", "Offer", "Hired", "Rejected"];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Move ${selectedCandidateIds.length} Candidates", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: stages.map((stg) {
            return ListTile(
              leading: Icon(Icons.swap_horiz_rounded, color: theme.colorScheme.primary),
              title: Text("Move to $stg"),
              onTap: () {
                Navigator.pop(ctx);
                provider.bulkUpdateCandidateStage(selectedCandidateIds.toList(), stg);
                _showSnackBar(context, "Moved ${selectedCandidateIds.length} candidates to $stg stage.");
                onClearSelection();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    Color? iconColor,
    Color? textColor,
    BorderSide? side,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: iconColor),
      label: Text(label, style: textColor != null ? TextStyle(color: textColor) : null),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: side,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: isMobile ? 16 : 24, 
        right: isMobile ? 16 : 24, 
        top: 16, 
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${selectedCandidateIds.length}",
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Selected for Bulk ATS Actions",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: onClearSelection,
                icon: const Icon(Icons.close_rounded, size: 18),
                label: const Text("Clear"),
              ),
            ],
          ),
          AppSpacing.h12,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _showSnackBar(context, "Scheduled batch interview invitations for ${selectedCandidateIds.length} candidates.");
                    onClearSelection();
                  },
                  icon: const Icon(Icons.calendar_month_outlined, size: 18),
                  label: const Text("Schedule Interview"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  onPressed: () => _showBulkMoveStageDialog(context),
                  icon: Icons.swap_horiz_rounded,
                  label: "Move Stage",
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  onPressed: () {
                    _showSnackBar(context, "Opening broadcast message composer for ${selectedCandidateIds.length} candidates.");
                    onClearSelection();
                  },
                  icon: Icons.chat_bubble_outline_rounded,
                  label: "Send Message",
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  onPressed: () {
                    _showSnackBar(context, "Exported profile summaries of ${selectedCandidateIds.length} candidates as PDF/CSV.");
                    onClearSelection();
                  },
                  icon: Icons.download_rounded,
                  label: "Export Profiles",
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  onPressed: () {
                    final count = selectedCandidateIds.length;
                    provider.bulkDeleteCandidates(selectedCandidateIds.toList());
                    _showSnackBar(context, "Archived $count candidate profiles.");
                    onClearSelection();
                  },
                  icon: Icons.archive_outlined,
                  label: "Archive",
                  iconColor: theme.colorScheme.error,
                  textColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
