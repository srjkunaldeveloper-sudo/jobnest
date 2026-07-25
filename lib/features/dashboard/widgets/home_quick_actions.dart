import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
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
          // ===== BACKEND TODO =====
          // TODO: Quick Actions actual navigation use karenge.
          LayoutBuilder(
            builder: (context, constraints) {
              double buttonWidth;
              // Desktop: 4 Columns
              if (constraints.maxWidth > 900) {
                buttonWidth = (constraints.maxWidth - (16 * 3)) / 4;
              } 
              // Tablet: 3 Columns
              else if (constraints.maxWidth > 600) {
                buttonWidth = (constraints.maxWidth - (16 * 2)) / 3;
              } 
              // Mobile: 2 Columns
              else {
                buttonWidth = (constraints.maxWidth - 16) / 2;
              }
              
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: buttonWidth,
                    child: _QuickActionShortcut(
                      icon: Icons.add_business_rounded,
                      title: "Create Job",
                      subtitle: "Draft a new posting",
                      color: Colors.blue,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    child: _QuickActionShortcut(
                      icon: Icons.groups_rounded,
                      title: "View Candidates",
                      subtitle: "Review applicants",
                      color: Colors.orange,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    child: _QuickActionShortcut(
                      icon: Icons.edit_calendar_rounded,
                      title: "Schedule Interview",
                      subtitle: "Set up meetings",
                      color: Colors.purple,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    child: _QuickActionShortcut(
                      icon: Icons.chat_rounded,
                      title: "Messages",
                      subtitle: "Chat with candidates",
                      color: Colors.teal,
                      onTap: () {},
                    ),
                  ),
                ],
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
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? widget.color.withValues(alpha: 0.5) : theme.dividerColor.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? widget.color.withValues(alpha: 0.1) : theme.shadowColor.withValues(alpha: 0.02),
              blurRadius: _isHovered ? 8 : 4,
              offset: Offset(0, _isHovered ? 4 : 2),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: 24,
                    ),
                  ),
                  AppSpacing.h16,
                  Text(
                    widget.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.h4,
                  Text(
                    widget.subtitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
