import 'package:flutter/material.dart';
import '../constants/app_radius.dart';

class StatCard extends StatefulWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;
  final String trend;
  final bool isPositiveTrend;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    this.trend = "",
    this.isPositiveTrend = true,
    this.onTap,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
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
            borderRadius: AppRadius.large,
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: _isHovered ? 0.08 : 0.02),
                blurRadius: _isHovered ? 12 : 8,
                offset: Offset(0, _isHovered ? 6 : 4),
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap ?? () {
                // ===== BACKEND TODO =====
                // TODO: List page (e.g. candidates list or jobs list) navigate hogi yaha se.
              },
              borderRadius: AppRadius.large,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: widget.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(widget.icon, color: widget.color, size: 24),
                        ),
                        if (widget.trend.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: (widget.isPositiveTrend ? Colors.green : Colors.red).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  widget.isPositiveTrend ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                                  color: widget.isPositiveTrend ? Colors.green : Colors.red,
                                  size: 12,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  widget.trend,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isPositiveTrend ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.count, 
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.title, 
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant, 
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
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
