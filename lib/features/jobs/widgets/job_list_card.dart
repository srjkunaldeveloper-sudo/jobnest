import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/job_details_screen.dart';

class JobListCard extends StatefulWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final String applicationsCount;
  final String status;
  final int aiMatchScore;
  final JobModel? job;
  final VoidCallback? onBookmarkTap;
  final ValueChanged<String>? onStatusChange;
  final VoidCallback? onDuplicateTap;
  final VoidCallback? onDeleteTap;

  const JobListCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.applicationsCount,
    required this.status,
    required this.aiMatchScore,
    this.job,
    this.onBookmarkTap,
    this.onStatusChange,
    this.onDuplicateTap,
    this.onDeleteTap,
  });

  @override
  State<JobListCard> createState() => _JobListCardState();
}

class _JobListCardState extends State<JobListCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String postedDate = widget.job?.postedDate ?? "2 days ago";
    final bool isBookmarked = widget.job?.isBookmarked ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Semantics(
        label: "Job Requisition ${widget.title} at ${widget.company}, ${widget.location}, Status: ${widget.status}",
        button: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailsScreen(
                          title: widget.title,
                          company: widget.company,
                          location: widget.location,
                          salary: widget.salary,
                          jobType: widget.jobType,
                          status: widget.status,
                          job: widget.job,
                        ),
                      ),
                    );
                  },
                  borderRadius: AppRadius.large,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: AppText.h3,
                                  ),
                                  AppSpacing.h4,
                                  Text(
                                    "${widget.company} • ${widget.location}",
                                    style: AppText.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildStatusBadge(theme, widget.status),
                          ],
                        ),
                        AppSpacing.h16,
                        // Attributes Row (ATS metrics)
                        Wrap(
                          spacing: 14,
                          runSpacing: 10,
                          children: [
                            _buildAttribute(context, AppIcons.monetization_on_rounded, widget.salary),
                            _buildAttribute(context, AppIcons.work_outline_rounded, widget.jobType),
                            _buildAttribute(context, AppIcons.people_alt_rounded, "${widget.applicationsCount} Candidates"),
                            _buildAttribute(context, AppIcons.calendar_today_rounded, postedDate),
                          ],
                        ),
                        AppSpacing.h16,
                        const Divider(),
                        AppSpacing.h12,
                        // Bottom Actions & AI Match
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            // AI Match Score
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(AppIcons.auto_awesome_rounded, color: Colors.deepPurpleAccent, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "${widget.aiMatchScore}% AI Match",
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Actions & Bookmarking
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bookmark Icon (48dp Touch Target)
                                Semantics(
                                  label: isBookmarked ? "Remove Bookmark" : "Bookmark Job",
                                  button: true,
                                  child: IconButton(
                                    onPressed: widget.onBookmarkTap ?? () {},
                                    tooltip: isBookmarked ? "Bookmarked" : "Bookmark",
                                    icon: Icon(
                                      isBookmarked ? AppIcons.bookmark_rounded : AppIcons.bookmark_border_rounded,
                                      color: isBookmarked ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                                      size: 20,
                                    ),
                                    constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                                  ),
                                ),
                                FilledButton.tonal(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailsScreen(
                                          title: widget.title,
                                          company: widget.company,
                                          location: widget.location,
                                          salary: widget.salary,
                                          jobType: widget.jobType,
                                          status: widget.status,
                                          job: widget.job,
                                        ),
                                      ),
                                    );
                                  },
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    minimumSize: const Size(64, 36),
                                  ),
                                  child: const Text("View Details", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 4),
                                // Overflow Menu (48dp Touch Target)
                                Semantics(
                                  label: "Job Requisition Options",
                                  button: true,
                                  child: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == "duplicate" && widget.onDuplicateTap != null) {
                                        widget.onDuplicateTap!();
                                      } else if (value == "delete" && widget.onDeleteTap != null) {
                                        widget.onDeleteTap!();
                                      } else if (value.startsWith("status_") && widget.onStatusChange != null) {
                                        final s = value.replaceFirst("status_", "");
                                        widget.onStatusChange!(s);
                                      }
                                    },
                                    tooltip: "More Options",
                                    constraints: const BoxConstraints(minWidth: 180),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: "edit",
                                        child: Row(
                                          children: [
                                            Icon(AppIcons.edit_note_rounded, size: 18),
                                            SizedBox(width: 10),
                                            Text("Edit Requisition"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: "duplicate",
                                        child: Row(
                                          children: [
                                            Icon(AppIcons.copy_rounded, size: 18),
                                            SizedBox(width: 10),
                                            Text("Duplicate Job"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        enabled: false,
                                        child: Text("CHANGE STATUS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                      const PopupMenuItem(
                                        value: "status_Open",
                                        child: Row(
                                          children: [
                                            Icon(AppIcons.check_circle_outline_rounded, size: 16, color: Colors.green),
                                            SizedBox(width: 8),
                                            Text("Set as Open"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: "status_Hiring",
                                        child: Row(
                                          children: [
                                            Icon(AppIcons.group_add_outlined, size: 16, color: Colors.blueAccent),
                                            SizedBox(width: 8),
                                            Text("Set as Hiring"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: "status_Paused",
                                        child: Row(
                                          children: [
                                            Icon(AppIcons.pause_circle_outline_rounded, size: 16, color: Colors.amber),
                                            SizedBox(width: 8),
                                            Text("Set as Paused"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: "status_Closed",
                                        child: Row(
                                          children: [
                                            Icon(AppIcons.cancel_outlined, size: 16, color: Colors.redAccent),
                                            SizedBox(width: 8),
                                            Text("Set as Closed"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuDivider(),
                                      const PopupMenuItem(
                                        value: "delete",
                                        child: Row(
                                          children: [
                                            Icon(AppIcons.delete_outline_rounded, size: 18, color: Colors.red),
                                            SizedBox(width: 10),
                                            Text("Archive / Delete", style: TextStyle(color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                    ],
                                    icon: Icon(AppIcons.more_vert_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
                                    padding: EdgeInsets.zero,
                                    splashRadius: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ThemeData theme, String status) {
    Color badgeColor = Colors.green;
    IconData badgeIcon = AppIcons.check_circle_rounded;
    final s = status.toLowerCase();

    if (s == "active" || s == "open") {
      badgeColor = Colors.green;
      badgeIcon = AppIcons.check_circle_rounded;
    } else if (s == "hiring") {
      badgeColor = Colors.blueAccent;
      badgeIcon = AppIcons.group_add_rounded;
    } else if (s == "paused") {
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
          Icon(badgeIcon, size: 13, color: badgeColor),
          const SizedBox(width: 5),
          Text(
            status,
            style: theme.textTheme.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttribute(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 5),
        Text(
          text,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
