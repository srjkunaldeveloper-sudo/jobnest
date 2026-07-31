import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/features/dashboard/models/models.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isLoading = context.select<DashboardProvider, bool>((p) => p.isDashboardLoading);
    final List<DashboardQuickAction> actions = context.select<DashboardProvider, List<DashboardQuickAction>>((p) => p.quickActions);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          AppSpacing.h16,
          if (isLoading)
            const AppShimmerLoading(
              width: double.infinity,
              height: 160,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid logic based on constraints
                int columns = 2; // Perfect 2-column base grid
                if (constraints.maxWidth > 900) {
                  columns = 4;
                } else if (constraints.maxWidth > 600) {
                  columns = 3;
                }
                
                final double gap = 16.0;
                final double buttonWidth = (constraints.maxWidth - (gap * (columns - 1))) / columns;
                
                return Wrap(
                  spacing: gap, // Horizontal gap
                  runSpacing: gap, // Vertical gap
                  children: actions.map((action) {
                    return SizedBox(
                      width: buttonWidth,
                      height: 160, // Exact height constraint for every card
                      child: _QuickActionShortcut(
                        icon: action.icon,
                        title: action.title,
                        subtitle: action.subtitle,
                        color: action.color,
                        onTap: () {
                          if (action.enabled) {
                            context.read<DashboardProvider>().triggerQuickAction(action.action);
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _QuickActionShortcut extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionShortcut({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  State<_QuickActionShortcut> createState() => _QuickActionShortcutState();
}

class _QuickActionShortcutState extends State<_QuickActionShortcut> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: "Quick Action ${widget.title}, ${widget.subtitle}",
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? widget.color.withValues(alpha: 0.5) : theme.dividerColor.withValues(alpha: 0.3),
              width: 1, // Exact same border thickness
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? widget.color.withValues(alpha: 0.1) : theme.shadowColor.withValues(alpha: 0.02),
                blurRadius: _isHovered ? 12 : 6,
                offset: Offset(0, _isHovered ? 6 : 2),
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              splashColor: widget.color.withValues(alpha: 0.1),
              highlightColor: widget.color.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon Container (kept original icon proportion, optimized container)
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: widget.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center, // Perfectly centered
                          child: Icon(
                            widget.icon,
                            color: widget.color,
                            size: 28, // Kept icon size
                          ),
                        ),
                        const SizedBox(height: 10), // 8-10px gap
                        Text(
                          widget.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13, // Slightly reduced to prevent "Schedule Interview" from truncating
                            height: 1.2,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.visible, // Must never overflow
                        ),
                        const SizedBox(height: 4), // 4-6px gap
                        Text(
                          widget.subtitle,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                        color: _isHovered ? widget.color : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
