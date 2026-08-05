import '../../../../core/constants/app_icons.dart';
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
  final String? experience;
  final String? closingDate;
  final VoidCallback? onShareTap;
  final VoidCallback? onMoreTap;

  const DetailsHeader({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.status,
    this.job,
    this.experience,
    this.closingDate,
    this.onShareTap,
    this.onMoreTap,
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
    final int matchScore = activeJob?.aiMatchScore ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Job Title (large), Status Badge & Actions (right)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusBadge(theme, displayStatus),
                const SizedBox(width: 6),
                // Bookmark button (48dp touch target)
                Semantics(
                  label: isBookmarked ? "Remove Bookmark" : "Bookmark Job Requisition",
                  button: true,
                  child: _buildIconButton(
                    context,
                    isBookmarked ? AppIcons.bookmark_rounded : AppIcons.bookmark_border_rounded,
                    () {
                      if (activeJob != null) {
                        provider.toggleBookmarkJob(activeJob.id);
                      }
                    },
                    iconColor: isBookmarked ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 6),
                Semantics(
                  label: "Share Requisition",
                  button: true,
                  child: _buildIconButton(
                    context,
                    AppIcons.share_rounded,
                    onShareTap,
                  ),
                ),
                const SizedBox(width: 6),
                Semantics(
                  label: "More Actions",
                  button: true,
                  child: _buildIconButton(
                    context,
                    AppIcons.more_vert_rounded,
                    onMoreTap,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Second Row: Company Badge & AI Match Badge
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                company,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            if (matchScore > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.deepPurpleAccent.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(AppIcons.auto_awesome_rounded, color: Colors.deepPurpleAccent, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      "$matchScore% AI Match",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),

        // Combined metadata into a single-row layout whenever horizontal space permits
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildInfoChip(context, AppIcons.location_on_rounded, location),
            _buildInfoChip(context, AppIcons.work_outline_rounded, jobType),
            _buildInfoChip(context, AppIcons.monetization_on_rounded, salary, isSalary: true),
            if (experience != null && experience!.isNotEmpty && experience != "--")
              _buildInfoChip(context, AppIcons.work_history_rounded, experience!),
            _buildInfoChip(context, AppIcons.calendar_today_rounded, "Posted: $postedDate"),
            if (closingDate != null && closingDate!.isNotEmpty && closingDate != "--")
              _buildInfoChip(context, Icons.event_busy_rounded, "Closing: $closingDate!"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(ThemeData theme, String statusStr) {
    Color badgeColor = Colors.green;
    IconData badgeIcon = AppIcons.check_circle_rounded;
    final s = statusStr.toLowerCase();

    if (s == "active" || s == "open" || s == "live") {
      badgeColor = Colors.green;
      badgeIcon = AppIcons.check_circle_rounded;
    } else if (s == "hiring") {
      badgeColor = Colors.blueAccent;
      badgeIcon = AppIcons.group_add_rounded;
    } else if (s == "paused" || s == "expired") {
      badgeColor = Colors.amber.shade700;
      badgeIcon = AppIcons.pause_circle_filled_rounded;
    } else if (s == "closed") {
      badgeColor = Colors.redAccent;
      badgeIcon = AppIcons.cancel_rounded;
    } else if (s == "draft") {
      badgeColor = Colors.blueGrey;
      badgeIcon = AppIcons.edit_note_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 12, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            statusStr,
            style: theme.textTheme.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, VoidCallback? onTap, {Color? iconColor}) {
    final theme = Theme.of(context);
    final isEnabled = onTap != null;
    return Container(
      decoration: BoxDecoration(
        color: isEnabled ? theme.colorScheme.surface : theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: isEnabled ? 0.5 : 0.2),
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 18,
          color: isEnabled
              ? (iconColor ?? theme.colorScheme.onSurface)
              : theme.disabledColor,
        ),
        onPressed: onTap,
        splashRadius: 20,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String label, {
    bool isSalary = false,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSalary
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.8)
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSalary
              ? theme.colorScheme.primary.withValues(alpha: 0.3)
              : theme.dividerColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: isSalary
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isSalary
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.onSurface,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
