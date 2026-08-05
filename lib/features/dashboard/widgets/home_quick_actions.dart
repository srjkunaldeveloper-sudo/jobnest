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
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? widget.color.withValues(alpha: 0.3) : widget.color.withValues(alpha: 0.15);
    
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
            color: isDark ? widget.color.withValues(alpha: 0.12) : widget.color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _isHovered ? widget.color.withValues(alpha: 0.5) : borderColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : const Color(0xFF0F172A).withValues(alpha: 0.04),
                blurRadius: _isHovered ? 20 : 16,
                spreadRadius: 0,
                offset: Offset(0, _isHovered ? 8 : 6),
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(18),
              splashColor: widget.color.withValues(alpha: 0.1),
              highlightColor: widget.color.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: widget.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              widget.icon,
                              color: widget.color,
                              size: 22,
                            ),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF334155) : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? widget.color.withValues(alpha: 0.3)
                                  : widget.color.withValues(alpha: 0.15),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: widget.color,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        widget.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
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
