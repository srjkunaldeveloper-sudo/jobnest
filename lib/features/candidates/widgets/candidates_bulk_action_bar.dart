import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/candidates/providers/candidate_provider.dart';

class CandidatesBulkActionBar extends StatelessWidget {
  final Set<String> selectedCandidateIds;
  final VoidCallback onClearSelection;
  final CandidateProvider provider;
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
              leading: Icon(AppIcons.swap_horiz_rounded, color: theme.colorScheme.primary),
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
      icon: Icon(icon, size: 16, color: iconColor),
      label: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 13)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${selectedCandidateIds.length}",
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Selected for Bulk ATS Actions",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton.icon(
                onPressed: onClearSelection,
                icon: const Icon(AppIcons.close_rounded, size: 16),
                label: const Text("Clear", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
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
                  icon: const Icon(AppIcons.calendar_month_outlined, size: 16),
                  label: const Text("Schedule Interview", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  onPressed: () => _showBulkMoveStageDialog(context),
                  icon: AppIcons.swap_horiz_rounded,
                  label: "Move Stage",
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  onPressed: () {
                    _showSnackBar(context, "Opening broadcast message composer for ${selectedCandidateIds.length} candidates.");
                    onClearSelection();
                  },
                  icon: AppIcons.chat_bubble_outline_rounded,
                  label: "Send Message",
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  onPressed: () {
                    _showSnackBar(context, "Exported profile summaries of ${selectedCandidateIds.length} candidates as PDF/CSV.");
                    onClearSelection();
                  },
                  icon: AppIcons.download_rounded,
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
                  icon: AppIcons.archive_outlined,
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
