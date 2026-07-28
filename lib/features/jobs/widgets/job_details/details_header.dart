import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';

class DetailsHeader extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final String status;
  final JobModel? job;

  const DetailsHeader({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.status,
    this.job,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<JobProvider>();
    final JobModel? activeJob = job ?? provider.jobs.cast<JobModel?>().firstWhere(
      (j) => j?.title == title && j?.company == company,
      orElse: () => null,
    );
    final bool isBookmarked = activeJob?.isBookmarked ?? false;
    final String displayStatus = activeJob?.status ?? status;
    final String postedDate = activeJob?.postedDate ?? "2 days ago";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$company • $location",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Bookmark button (48dp touch target)
                Semantics(
                  label: isBookmarked ? "Remove Bookmark" : "Bookmark Job Requisition",
                  button: true,
                  child: _buildIconButton(
                    context,
                    isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    () {
                      if (activeJob != null) {
                        provider.toggleBookmarkJob(activeJob.id);
                      }
                    },
                    iconColor: isBookmarked ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                Semantics(
                  label: "Share Requisition",
                  button: true,
                  child: _buildIconButton(context, Icons.share_rounded, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Job link copied to clipboard.")),
                    );
                  }),
                ),
                const SizedBox(width: 8),
                Semantics(
                  label: "More Actions",
                  button: true,
                  child: _buildIconButton(context, Icons.more_vert_rounded, () {}),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildInfoChip(context, Icons.monetization_on_rounded, salary),
            _buildInfoChip(context, Icons.work_outline_rounded, jobType),
            _buildInfoChip(context, Icons.calendar_today_rounded, postedDate),
            _buildStatusBadge(theme, displayStatus),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(ThemeData theme, String statusStr) {
    Color badgeColor = Colors.green;
    IconData badgeIcon = Icons.check_circle_rounded;
    final s = statusStr.toLowerCase();

    if (s == "active" || s == "open") {
      badgeColor = Colors.green;
      badgeIcon = Icons.check_circle_rounded;
    } else if (s == "hiring") {
      badgeColor = Colors.blueAccent;
      badgeIcon = Icons.group_add_rounded;
    } else if (s == "paused") {
      badgeColor = Colors.amber.shade700;
      badgeIcon = Icons.pause_circle_filled_rounded;
    } else if (s == "closed") {
      badgeColor = Colors.redAccent;
      badgeIcon = Icons.cancel_rounded;
    } else if (s == "draft") {
      badgeColor = Colors.blueGrey;
      badgeIcon = Icons.edit_note_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 15, color: badgeColor),
          const SizedBox(width: 6),
          Text(
            statusStr,
            style: theme.textTheme.labelMedium?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, VoidCallback onTap, {Color? iconColor}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: iconColor ?? theme.colorScheme.onSurface),
        onPressed: onTap,
        splashRadius: 24,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
