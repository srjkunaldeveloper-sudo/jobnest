import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomeFocus extends StatelessWidget {
  final VoidCallback? onNavigateToJobs;
  final VoidCallback? onNavigateToCandidates;
  final VoidCallback? onNavigateToInterviews;

  const HomeFocus({
    super.key,
    this.onNavigateToJobs,
    this.onNavigateToCandidates,
    this.onNavigateToInterviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final int interviewsCount = context.select<DashboardProvider, int>((p) => p.todayInterviewsCount);
    final int candidatesCount = context.select<DashboardProvider, int>((p) => p.newCandidatesCount);
    final int jobsCount = context.select<DashboardProvider, int>((p) => p.urgentJobsCount);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Today's Focus",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              AppSpacing.w8,
              const Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: 20,
              ),
            ],
          ),
          AppSpacing.h16,
          
          // Complete card with interactive rows, hover, pressed states and graceful empty handling
          AppCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: Interviews Today
                _FocusRowWidget(
                  icon: interviewsCount > 0 ? Icons.calendar_month_rounded : Icons.check_circle_outline_rounded,
                  iconColor: interviewsCount > 0 ? theme.colorScheme.primary : Colors.green,
                  text: interviewsCount > 0 
                      ? "$interviewsCount ${interviewsCount == 1 ? 'interview' : 'interviews'} today" 
                      : "No interviews scheduled today — Tap to schedule",
                  isEmpty: interviewsCount == 0,
                  onTap: () {
                    if (onNavigateToInterviews != null) onNavigateToInterviews!();
                  },
                ),
                const Divider(height: 16, thickness: 0.5),
                
                // Row 2: New Candidates
                _FocusRowWidget(
                  icon: candidatesCount > 0 ? Icons.group_add_rounded : Icons.person_search_outlined,
                  iconColor: candidatesCount > 0 ? Colors.orange : theme.colorScheme.secondary,
                  text: candidatesCount > 0 
                      ? "$candidatesCount new ${candidatesCount == 1 ? 'candidate' : 'candidates'}" 
                      : "No new candidates — Tap to explore talent pool",
                  isEmpty: candidatesCount == 0,
                  onTap: () {
                    if (onNavigateToCandidates != null) onNavigateToCandidates!();
                  },
                ),
                const Divider(height: 16, thickness: 0.5),
                
                // Row 3: Urgent Jobs
                _FocusRowWidget(
                  icon: jobsCount > 0 ? Icons.campaign_rounded : Icons.work_outline_rounded,
                  iconColor: jobsCount > 0 ? theme.colorScheme.error : theme.colorScheme.primary,
                  text: jobsCount > 0 
                      ? "$jobsCount urgent ${jobsCount == 1 ? 'job' : 'jobs'}" 
                      : "No urgent requisitions — All job pipelines on track",
                  isEmpty: jobsCount == 0,
                  onTap: () {
                    if (onNavigateToJobs != null) onNavigateToJobs!();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusRowWidget extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final VoidCallback onTap;
  final bool isEmpty;

  const _FocusRowWidget({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.onTap,
    this.isEmpty = false,
  });

  @override
  State<_FocusRowWidget> createState() => _FocusRowWidgetState();
}

class _FocusRowWidgetState extends State<_FocusRowWidget> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: widget.text,
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            color: _isHovered
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.25)
                : (_isPressed
                    ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onHover: (hovered) => setState(() => _isHovered = hovered),
              onHighlightChanged: (pressed) => setState(() => _isPressed = pressed),
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                child: AnimatedScale(
                  scale: _isPressed ? 0.98 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeOutCubic,
                  child: Row(
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: widget.iconColor.withValues(alpha: widget.isEmpty ? 0.08 : 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.iconColor,
                          size: 20,
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: Text(
                          widget.text,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: widget.isEmpty ? FontWeight.w500 : FontWeight.w600,
                            color: widget.isEmpty ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface,
                            fontStyle: widget.isEmpty ? FontStyle.italic : FontStyle.normal,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: (_isHovered || _isPressed) ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                        size: 22,
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
}
