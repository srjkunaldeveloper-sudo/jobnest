import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomeFocus extends StatelessWidget {
  final VoidCallback? onNavigateToJobs;
  final VoidCallback? onNavigateToCandidates;
  final VoidCallback? onNavigateToInterviews;

  const HomeFocus({
    key,
    this.onNavigateToJobs,
    this.onNavigateToCandidates,
    this.onNavigateToInterviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Select existing metrics from DashboardProvider
    final int interviewsCount = context.select<DashboardProvider, int>((p) => p.todayInterviewsCount);
    final int candidatesCount = context.select<DashboardProvider, int>((p) => p.newCandidatesCount);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🔥 Priority Follow-ups",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View All"),
              ),
            ],
          ),
          AppSpacing.h16,
          
          AppCard(
            borderRadius: 18,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FocusRowWidget(
                  icon: LucideIcons.calendar,
                  iconColor: theme.colorScheme.primary,
                  text: "Today's Interviews",
                  badgeText: "$interviewsCount",
                  onTap: onNavigateToInterviews,
                ),
                const Divider(height: 24, thickness: 0.5),
                _FocusRowWidget(
                  icon: LucideIcons.userCheck,
                  iconColor: Colors.orange,
                  text: "Candidates Pending Review",
                  badgeText: "$candidatesCount",
                  onTap: onNavigateToCandidates,
                ),
                const Divider(height: 24, thickness: 0.5),
                _FocusRowWidget(
                  icon: LucideIcons.fileText,
                  iconColor: Colors.purple,
                  text: "Offer Letters Pending",
                  badgeText: "--",
                  onTap: onNavigateToJobs,
                ),
                const Divider(height: 24, thickness: 0.5),
                _FocusRowWidget(
                  icon: LucideIcons.barChart2,
                  iconColor: Colors.teal,
                  text: "AI Reports Pending",
                  badgeText: "--",
                  onTap: () {},
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
  final String badgeText;
  final VoidCallback? onTap;

  const _FocusRowWidget({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.badgeText,
    this.onTap,
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
      label: "${widget.text}, ${widget.badgeText} items",
      button: widget.onTap != null,
      child: MouseRegion(
        cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) {
          if (widget.onTap != null) setState(() => _isHovered = true);
        },
        onExit: (_) {
          if (widget.onTap != null) setState(() => _isHovered = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            color: _isHovered
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.15)
                : (_isPressed
                    ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onHover: widget.onTap == null ? null : (hovered) => setState(() => _isHovered = hovered),
              onHighlightChanged: widget.onTap == null ? null : (pressed) => setState(() => _isPressed = pressed),
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
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
                          color: widget.iconColor.withValues(alpha: 0.12),
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
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: widget.iconColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.badgeText,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: widget.iconColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        LucideIcons.chevronRight,
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
