import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_text.dart';
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
  final VoidCallback? onViewPipeline;
  final VoidCallback? onEditTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onArchiveTap;

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
    this.onViewPipeline,
    this.onEditTap,
    this.onShareTap,
    this.onArchiveTap,
  });

  @override
  State<JobListCard> createState() => _JobListCardState();
}

class _JobListCardState extends State<JobListCard> {
  bool _isHovered = false;

  String? _calculateDaysLive(String? postedDateStr) {
    if (postedDateStr == null || postedDateStr.trim().isEmpty) return null;
    
    final cleanStr = postedDateStr.toLowerCase().trim();
    if (cleanStr == "today" || cleanStr == "0 days ago") {
      return "Today";
    }
    if (cleanStr == "yesterday" || cleanStr == "1 day ago" || cleanStr == "1 days ago") {
      return "1 Day Live";
    }
    
    final regex = RegExp(r'(\d+)');
    final match = regex.firstMatch(cleanStr);
    if (match != null) {
      final days = int.tryParse(match.group(1)!);
      if (days != null) {
        if (days == 0) return "Today";
        if (days == 1) return "1 Day Live";
        return "$days Days Live";
      }
    }
    
    try {
      final parsedDate = DateTime.tryParse(postedDateStr);
      if (parsedDate != null) {
        final today = DateTime.now();
        final difference = today.difference(parsedDate).inDays;
        if (difference <= 0) {
          return "Today";
        } else if (difference == 1) {
          return "1 Day Live";
        } else {
          return "$difference Days Live";
        }
      }
    } catch (_) {}
    
    if (cleanStr.contains("day")) {
      return postedDateStr;
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String? daysLiveStr = _calculateDaysLive(widget.job?.postedDate);

    final displaySalary = widget.salary.contains('₹') || widget.salary.contains('\$')
        ? widget.salary
        : '₹${widget.salary}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Semantics(
        label: "Job Requisition ${widget.title} at ${widget.company}, ${widget.location}, Status: ${widget.status}",
        button: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(0, _isHovered ? -1.5 : 0, 0),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Title & Status + Overflow ⋮ (on the right)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: AppText.h3.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildStatusBadge(theme, widget.status),
                              const SizedBox(width: 4),
                              Semantics(
                                label: "Job Requisition Options",
                                button: true,
                                child: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == "duplicate" && widget.onDuplicateTap != null) {
                                      widget.onDuplicateTap!();
                                    } else if (value == "delete" && widget.onDeleteTap != null) {
                                      widget.onDeleteTap!();
                                    } else if (value == "archive" && widget.onArchiveTap != null) {
                                      widget.onArchiveTap!();
                                    } else if (value == "edit" && widget.onEditTap != null) {
                                      widget.onEditTap!();
                                    } else if (value == "share" && widget.onShareTap != null) {
                                      widget.onShareTap!();
                                    }
                                  },
                                  tooltip: "More Options",
                                  constraints: const BoxConstraints(minWidth: 180),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "edit",
                                      enabled: widget.onEditTap != null,
                                      child: Row(
                                        children: [
                                          Icon(
                                            AppIcons.edit_note_rounded,
                                            size: 18,
                                            color: widget.onEditTap != null ? null : theme.disabledColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Edit Requisition",
                                            style: TextStyle(
                                              color: widget.onEditTap != null ? null : theme.disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "duplicate",
                                      enabled: widget.onDuplicateTap != null,
                                      child: Row(
                                        children: [
                                          Icon(
                                            AppIcons.copy_rounded,
                                            size: 18,
                                            color: widget.onDuplicateTap != null ? null : theme.disabledColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Duplicate Job",
                                            style: TextStyle(
                                              color: widget.onDuplicateTap != null ? null : theme.disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "share",
                                      enabled: widget.onShareTap != null,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.share_outlined,
                                            size: 18,
                                            color: widget.onShareTap != null ? null : theme.disabledColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Share Job",
                                            style: TextStyle(
                                              color: widget.onShareTap != null ? null : theme.disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "archive",
                                      enabled: widget.onArchiveTap != null,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.archive_outlined,
                                            size: 18,
                                            color: widget.onArchiveTap != null ? null : theme.disabledColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Archive Job",
                                            style: TextStyle(
                                              color: widget.onArchiveTap != null ? null : theme.disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuDivider(),
                                    PopupMenuItem(
                                      value: "delete",
                                      enabled: widget.onDeleteTap != null,
                                      child: Row(
                                        children: [
                                          Icon(
                                            AppIcons.delete_outline_rounded,
                                            size: 18,
                                            color: widget.onDeleteTap != null ? Colors.red : theme.disabledColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Delete Job",
                                            style: TextStyle(
                                              color: widget.onDeleteTap != null ? Colors.red : theme.disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  icon: Icon(AppIcons.more_vert_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
                                  padding: EdgeInsets.zero,
                                  splashRadius: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Second Row: Company Name
                      Text(
                        widget.company,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Third Row: Location • Employment Type
                      Row(
                        children: [
                          Text(
                            "📍 ${widget.location}  •  ${widget.jobType}",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Fourth Row: Applications Count • Salary
                      Row(
                        children: [
                          Text(
                            "👥 ${widget.applicationsCount} Applicants  •  $displaySalary",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Fifth Row: Days Live (only if posted date exists)
                      if (daysLiveStr != null) ...[
                        const SizedBox(height: 10),
                        const Divider(height: 1),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.access_time_rounded, size: 14, color: theme.colorScheme.onSurfaceVariant),
                            const SizedBox(width: 6),
                            Text(
                              daysLiveStr,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),

                      // Bottom Actions Row
                      Row(
                        children: [
                          // Primary Action: View Details
                          FilledButton(
                            onPressed: () => _navigateToDetails(context),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              minimumSize: const Size(110, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "View Details",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Secondary Action: View Pipeline
                          OutlinedButton(
                            onPressed: widget.onViewPipeline ?? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Pipeline view coming soon")),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              minimumSize: const Size(120, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "View Pipeline",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
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
    );
  }

  void _navigateToDetails(BuildContext context) {
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
  }

  Widget _buildStatusBadge(ThemeData theme, String status) {
    Color badgeColor = Colors.green;
    IconData badgeIcon = AppIcons.check_circle_rounded;
    final s = status.toLowerCase();

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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 11, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            status,
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
}
