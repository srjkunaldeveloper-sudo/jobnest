import '../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Premium ATS stat card — clean elevation, subtle hover, refined typography.
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
    this.trend = '',
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
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? widget.color.withValues(alpha: 0.3) : widget.color.withValues(alpha: 0.15);
    final hoverBorderColor = theme.colorScheme.primary.withValues(alpha: 0.3);
    final surfaceColor = isDark ? widget.color.withValues(alpha: 0.12) : widget.color.withValues(alpha: 0.05);

    final trendPositiveBg = const Color(0xFFDCFCE7);
    final trendPositiveText = const Color(0xFF16A34A);
    final trendNegativeBg = const Color(0xFFFEE2E2);
    final trendNegativeText = const Color(0xFFDC2626);

    Color iconBgColor = widget.color.withValues(alpha: 0.12);
    Color iconColor = widget.color;

    if (!isDark) {
      if (widget.color == Colors.blueAccent) {
        iconBgColor = const Color(0xFFEEF4FF);
        iconColor = const Color(0xFF2563EB);
      } else if (widget.color == Colors.redAccent) {
        iconBgColor = const Color(0xFFFEE2E2);
        iconColor = const Color(0xFFDC2626);
      } else if (widget.color == Colors.orangeAccent) {
        iconBgColor = const Color(0xFFFFF4E8);
        iconColor = const Color(0xFFEA580C);
      } else if (widget.color == Colors.deepOrangeAccent) {
        iconBgColor = const Color(0xFFFFECE5);
        iconColor = const Color(0xFFE04F1A);
      } else if (widget.color == Colors.greenAccent) {
        iconBgColor = const Color(0xFFECFDF3);
        iconColor = const Color(0xFF16A34A);
      } else if (widget.color == Colors.purpleAccent) {
        iconBgColor = const Color(0xFFF5EEFF);
        iconColor = const Color(0xFF7C3AED);
      } else if (widget.color == Colors.pinkAccent) {
        iconBgColor = const Color(0xFFFFF0F7);
        iconColor = const Color(0xFFDB2777);
      } else if (widget.color == Colors.tealAccent) {
        iconBgColor = const Color(0xFFECFBFF);
        iconColor = const Color(0xFF0891B2);
      }
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit:  (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered ? hoverBorderColor : borderColor,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : const Color(0xFF0F172A).withValues(alpha: 0.04),
              blurRadius: _isHovered ? 20 : 16,
              spreadRadius: 0,
              offset: Offset(0, _isHovered ? 8 : 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap ?? () {},
            borderRadius: BorderRadius.circular(18),
            splashColor: theme.colorScheme.primary.withValues(alpha: 0.06),
            highlightColor: theme.colorScheme.primary.withValues(alpha: 0.04),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: iconBgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            widget.icon,
                            color: iconColor,
                            size: 22,
                          ),
                        ),
                      ),
                      if (widget.trend.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: widget.isPositiveTrend ? trendPositiveBg : trendNegativeBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.isPositiveTrend
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                color: widget.isPositiveTrend ? trendPositiveText : trendNegativeText,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.trend,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: widget.isPositiveTrend ? trendPositiveText : trendNegativeText,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.count,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
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
