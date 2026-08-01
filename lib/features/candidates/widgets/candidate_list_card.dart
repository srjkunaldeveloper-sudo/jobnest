import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';

import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/candidates/candidate_profile_screen.dart';
import 'package:jobnest/features/candidates/widgets/candidate_stage_badge.dart';

class CandidateListCard extends StatefulWidget {
  final String name;
  final String role;
  final String location;
  final String experience;
  final List<String> skills;
  final int matchPercentage;
  final double score;
  final CandidateModel? candidate;
  final bool isMultiSelectMode;
  final bool isSelected;
  final VoidCallback? onSelectChanged;
  final VoidCallback? onBookmarkTap;
  final ValueChanged<String>? onStageChange;
  final VoidCallback? onScheduleInterviewTap;
  final VoidCallback? onSendMessageTap;
  final VoidCallback? onDeleteTap;

  const CandidateListCard({
    super.key,
    required this.name,
    required this.role,
    required this.location,
    required this.experience,
    required this.skills,
    required this.matchPercentage,
    required this.score,
    this.candidate,
    this.isMultiSelectMode = false,
    this.isSelected = false,
    this.onSelectChanged,
    this.onBookmarkTap,
    this.onStageChange,
    this.onScheduleInterviewTap,
    this.onSendMessageTap,
    this.onDeleteTap,
  });

  @override
  State<CandidateListCard> createState() => _CandidateListCardState();
}

class _CandidateListCardState extends State<CandidateListCard> {
  bool _isHovered = false;

  void _navigateToProfile() {
    if (widget.isMultiSelectMode && widget.onSelectChanged != null) {
      widget.onSelectChanged!();
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CandidateProfileScreen(
          name: widget.name,
          role: widget.role,
          location: widget.location,
          experience: widget.experience,
          candidate: widget.candidate,
        ),
      ),
    );
  }

  void _showStageSelectionDialog(BuildContext context) {
    final theme = Theme.of(context);
    final stages = [
      "Applied",
      "Screening",
      "Interview",
      "Offer",
      "Hired",
      "Rejected",
    ];
    final currentStage = widget.candidate?.stage ?? "Screening";

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Move Stage: ${widget.name}",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: stages.map((stg) {
            final isCur = stg.toLowerCase() == currentStage.toLowerCase();
            return ListTile(
              leading: isCur
                  ? Icon(
                      AppIcons.check_rounded,
                      color: theme.colorScheme.primary,
                    )
                  : const SizedBox(width: 24),
              title: Text(
                stg,
                style: TextStyle(
                  fontWeight: isCur ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.pop(ctx);
                if (widget.onStageChange != null) {
                  widget.onStageChange!(stg);
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
    final String salary = widget.candidate?.expectedSalary ?? "₹ 18 - 22 LPA";
    final String appliedDate = widget.candidate?.appliedDate ?? "2 days ago";
    final String stage = widget.candidate?.stage ?? "Screening";
    final double rating = widget.candidate?.rating ?? widget.score;
    final String company = widget.candidate?.company ?? "TechCorp India";
    final bool isBookmarked = widget.candidate?.isBookmarked ?? false;
    final List<String> topSkills = widget.skills.take(3).toList();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: AppRadius.large,
          border: widget.isSelected
              ? Border.all(color: theme.colorScheme.primary, width: 2.0)
              : Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.5),
                  width: 1.0,
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.02),
              blurRadius: _isHovered ? 16 : 8,
              offset: _isHovered ? const Offset(0, 8) : const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _navigateToProfile,
            borderRadius: AppRadius.large,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Avatar, Name/Role/Company, Match Score, Checkbox/Bookmark/Overflow
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Photo Avatar
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          widget.name.isNotEmpty
                              ? widget.name[0].toUpperCase()
                              : "?",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AppSpacing.w16,

                      // Full Name, Current Position & Company
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            AppSpacing.h4,
                            Text(
                              "${widget.role} • $company",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            AppSpacing.h4,
                            Text(
                              "${widget.experience} • ${widget.location}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Match Percentage Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withValues(
                              alpha: 0.25,
                            ),
                          ),
                        ),
                        child: Text(
                          "${widget.matchPercentage}% Match",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Info Chips Row: Experience, Location, Expected Salary, Applied Date
                  Wrap(
                    spacing: 14,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildInfoItem(
                        context,
                        AppIcons.work_outline_rounded,
                        widget.experience,
                      ),
                      _buildInfoItem(
                        context,
                        AppIcons.location_on_outlined,
                        widget.location,
                      ),
                      _buildInfoItem(
                        context,
                        AppIcons.monetization_on_outlined,
                        salary,
                      ),
                      _buildInfoItem(
                        context,
                        AppIcons.calendar_today_rounded,
                        appliedDate,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Rating and Stage in the same row
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          context,
                          AppIcons.star_rounded,
                          "Rating: $rating",
                          iconColor: Colors.amber.shade700,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CandidateStageBadge(stage: stage),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Skills (Top 3)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: topSkills
                        .map((s) => _buildSkillTag(context, s))
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  const Divider(height: 1),
                  const SizedBox(height: 14),

                  // Bottom Action Row: Checkbox (Independent), View Profile, Quick Actions & Overflow Menu
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 12,
                    children: [
                      // Selection Checkbox (48dp touch target, independent from card navigation)
                      Semantics(
                        label: widget.isSelected
                            ? "Deselect candidate"
                            : "Select candidate for bulk actions",
                        checked: widget.isSelected,
                        button: true,
                        child: InkWell(
                          onTap: () {
                            if (widget.onSelectChanged != null) {
                              widget.onSelectChanged!();
                            }
                          },
                          borderRadius: BorderRadius.circular(24),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  widget.isSelected
                                      ? AppIcons.check_box_rounded
                                      : AppIcons
                                            .check_box_outline_blank_rounded,
                                  size: 22,
                                  color: widget.isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.isSelected ? "Selected" : "Select",
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: widget.isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: widget.isSelected
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Actions: View Profile button & Overflow Menu
                      Wrap(
                        spacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: _navigateToProfile,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(80, 40),
                            ),
                            child: const Text(
                              "View Profile",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          // Bookmark Button (48dp touch target)
                          Semantics(
                            label: isBookmarked
                                ? "Remove Bookmark"
                                : "Bookmark Candidate",
                            button: true,
                            child: IconButton(
                              onPressed: () {
                                if (widget.onBookmarkTap != null) {
                                  widget.onBookmarkTap!();
                                }
                              },
                              icon: Icon(
                                isBookmarked
                                    ? AppIcons.bookmark_rounded
                                    : AppIcons.bookmark_border_rounded,
                                size: 20,
                                color: isBookmarked
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                              tooltip: "Bookmark",
                              splashRadius: 24,
                              constraints: const BoxConstraints(
                                minWidth: 48,
                                minHeight: 48,
                              ),
                            ),
                          ),

                          // Overflow Menu (48dp touch target)
                          Semantics(
                            label: "More Candidate Actions",
                            button: true,
                            child: PopupMenuButton<String>(
                              onSelected: (action) {
                                switch (action) {
                                  case 'profile':
                                    _navigateToProfile();
                                    break;
                                  case 'schedule':
                                    if (widget.onScheduleInterviewTap != null) {
                                      widget.onScheduleInterviewTap!();
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Scheduled Interview with ${widget.name}.",
                                          ),
                                        ),
                                      );
                                    }
                                    break;
                                  case 'stage':
                                    _showStageSelectionDialog(context);
                                    break;
                                  case 'message':
                                    if (widget.onSendMessageTap != null) {
                                      widget.onSendMessageTap!();
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Opening message thread with ${widget.name}.",
                                          ),
                                        ),
                                      );
                                    }
                                    break;
                                  case 'delete':
                                    if (widget.onDeleteTap != null) {
                                      widget.onDeleteTap!();
                                    }
                                    break;
                                }
                              },
                              tooltip: "More Actions",
                              icon: Icon(
                                AppIcons.more_vert_rounded,
                                size: 20,
                                color: theme.colorScheme.onSurface,
                              ),
                              constraints: const BoxConstraints(minWidth: 210),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'profile',
                                  child: Row(
                                    children: [
                                      Icon(
                                        AppIcons.person_outline_rounded,
                                        size: 18,
                                      ),
                                      SizedBox(width: 12),
                                      Text("View Profile"),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'schedule',
                                  child: Row(
                                    children: [
                                      Icon(
                                        AppIcons.calendar_month_outlined,
                                        size: 18,
                                      ),
                                      SizedBox(width: 12),
                                      Text("Schedule Interview"),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'stage',
                                  child: Row(
                                    children: [
                                      Icon(
                                        AppIcons.swap_horiz_rounded,
                                        size: 18,
                                      ),
                                      SizedBox(width: 12),
                                      Text("Move Stage"),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'message',
                                  child: Row(
                                    children: [
                                      Icon(
                                        AppIcons.chat_bubble_outline_rounded,
                                        size: 18,
                                      ),
                                      SizedBox(width: 12),
                                      Text("Send Message"),
                                    ],
                                  ),
                                ),
                                const PopupMenuDivider(),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(
                                        AppIcons.archive_outlined,
                                        size: 18,
                                        color: theme.colorScheme.error,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "Archive Candidate",
                                        style: TextStyle(
                                          color: theme.colorScheme.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label, {
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 15,
          color: iconColor ?? theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillTag(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
