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
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final hoverBorderColor = theme.colorScheme.primary.withValues(alpha: 0.25);
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final trendPositiveColor = const Color(0xFF16A34A); // Green-600
    final trendNegativeColor = const Color(0xFFDC2626); // Red-600

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit:  (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? hoverBorderColor : borderColor,
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? theme.colorScheme.primary.withValues(alpha: 0.08)
                  : (isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : const Color(0xFF0F172A).withValues(alpha: 0.04)),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 6 : 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap ?? () {},
            borderRadius: BorderRadius.circular(16),
            splashColor: theme.colorScheme.primary.withValues(alpha: 0.06),
            highlightColor: theme.colorScheme.primary.withValues(alpha: 0.04),
            child: Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon + Trend row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(widget.icon, color: widget.color, size: 20),
                        ),
                      ),
                      if (widget.trend.isNotEmpty)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 22,
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (widget.isPositiveTrend
                                        ? trendPositiveColor
                                        : trendNegativeColor)
                                    .withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    widget.isPositiveTrend
                                        ? AppIcons.trending_up_rounded
                                        : AppIcons.trending_down_rounded,
                                    color: widget.isPositiveTrend
                                        ? trendPositiveColor
                                        : trendNegativeColor,
                                    size: 10,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      widget.trend,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: widget.isPositiveTrend
                                            ? trendPositiveColor
                                            : trendNegativeColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Texts
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Count
                      Text(
                        widget.count,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          height: 1.1,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Title
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
