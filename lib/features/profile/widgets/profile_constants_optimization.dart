import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/profile/providers/profile_data_provider.dart';

/// Single Shared Profile Constants, Performance Optimization, and Reusable UI
/// Components utility module for Phase P14.5.
/// Optimizes list rendering, provider selectors, memory management, and UI consistency across all 15 Profile screens.

// ============================================================================
// 1. STANDARDIZED PROFILE CONSTANTS
// ============================================================================

class ProfileConstants {
  // Spacing (Mapped to AppSpacing to maintain global consistency)
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  static const double spacingXXLarge = 48.0;

  // Border Radius (Mapped to AppRadius for global consistency)
  static const double radiusSmallVal = 8.0;
  static const double radiusMediumVal = 12.0;
  static const double radiusLargeVal = 16.0; // Updated from 24 to match AppRadius.large which is 16
  static final BorderRadius radiusSmall = AppRadius.small;
  static final BorderRadius radiusMedium = AppRadius.medium;
  static final BorderRadius radiusLarge = AppRadius.large;

  // Padding (Mapped to AppSpacing)
  static const EdgeInsets paddingSmall = EdgeInsets.all(8.0);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16.0);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24.0);
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: 24.0); // Changed to 24 to match Spacing Tokens

  // Avatar Sizes
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 64.0;
  static const double avatarSizeXLarge = 96.0;

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeLarge = 24.0;
  static const double iconSizeXLarge = 36.0;

  // Animations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 250);
  static const Duration animationSlow = Duration(milliseconds: 400);
  static const Curve defaultCurve = Curves.easeOutCubic;

  // Elevations
  static const double cardElevation = 0.0;
}

// ============================================================================
// 2. PERFORMANCE & LIST OPTIMIZATION WRAPPERS
// ============================================================================

class ProfileListOptimization {
  /// Efficiently renders long lists (Team Members, Support Tickets, Billing History,
  /// Activity Lists, Verification Lists) using `ListView.separated` with optimal caching
  /// to prevent unnecessary widget rebuilds and deep widget trees.
  static Widget buildOptimizedList<T>({
    required List<T> items,
    required Widget Function(BuildContext, T, int) itemBuilder,
    ScrollPhysics physics = const NeverScrollableScrollPhysics(),
    bool shrinkWrap = true,
    Widget? separator,
    EdgeInsetsGeometry? padding,
  }) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding ?? EdgeInsets.zero,
      itemCount: items.length,
      separatorBuilder: (ctx, index) => separator ?? Divider(height: 1, color: Theme.of(ctx).dividerColor),
      itemBuilder: (ctx, index) => itemBuilder(ctx, items[index], index),
    );
  }

  /// Efficiently renders grid layouts (Stats cards, Company Branding media) using `GridView.builder`.
  static Widget buildOptimizedGrid<T>({
    required List<T> items,
    required Widget Function(BuildContext, T, int) itemBuilder,
    int crossAxisCount = 2,
    double childAspectRatio = 1.2,
    double mainAxisSpacing = 16.0,
    double crossAxisSpacing = 16.0,
    ScrollPhysics physics = const NeverScrollableScrollPhysics(),
    bool shrinkWrap = true,
    EdgeInsetsGeometry? padding,
  }) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding ?? EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemCount: items.length,
      itemBuilder: (ctx, index) => itemBuilder(ctx, items[index], index),
    );
  }
}

// ============================================================================
// 3. REUSABLE PROFILE UI COMPONENTS
// ============================================================================

class ProfileSharedComponents {
  /// Standardized Section Header with title, subtitle, and optional trailing action.
  static Widget sectionHeader(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTrailingTap,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: ProfileConstants.spacingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: ProfileConstants.spacingXSmall),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null)
            InkWell(
              onTap: onTrailingTap,
              borderRadius: ProfileConstants.radiusMedium,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: trailing,
              ),
            ),
        ],
      ),
    );
  }

  /// Standardized Profile Card wrapper with enterprise styling and zero elevation.
  static Widget profileCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Border? border,
    VoidCallback? onTap,
  }) {
    final card = AppCard(
      padding: padding ?? ProfileConstants.paddingLarge,
      child: child,
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: ProfileConstants.radiusLarge,
      child: card,
    );
  }

  /// Standardized Settings Tile with leading icon, title, subtitle, trailing control, and accessibility.
  static Widget settingsTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData leadingIcon,
    Widget? trailing,
    VoidCallback? onTap,
    bool isDestructive = false,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final effectiveColor = isDestructive
        ? theme.colorScheme.error
        : (iconColor ?? theme.colorScheme.primary);

    return InkWell(
      onTap: onTap,
      borderRadius: ProfileConstants.radiusMedium,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: effectiveColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(leadingIcon, size: ProfileConstants.iconSizeMedium, color: effectiveColor),
            ),
            const SizedBox(width: ProfileConstants.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? theme.colorScheme.error : theme.colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else
              Icon(AppIcons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  /// Standardized Status Badge for Active, Verified, Premium, Pending, Needs Attention, etc.
  static Widget statusBadge(
    BuildContext context, {
    required String label,
    Color? color,
    IconData? icon,
    bool isSmall = false,
  }) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 12, vertical: isSmall ? 2 : 6),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: effectiveColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: isSmall ? 12 : 14, color: effectiveColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: (isSmall ? theme.textTheme.labelSmall : theme.textTheme.labelMedium)?.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Standardized Information Row for key-value display (e.g., PAN/TAN, Employee ID, Location).
  static Widget infoRow(
    BuildContext context, {
    required String label,
    required String value,
    IconData? icon,
    bool isCopied = false,
    VoidCallback? onCopy,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: ProfileConstants.iconSizeMedium, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.end,
                  ),
                ),
                if (onCopy != null) ...[
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: onCopy,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        isCopied ? AppIcons.check_rounded : AppIcons.copy_rounded,
                        size: 16,
                        color: isCopied ? Colors.green : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. PROVIDER & MEMORY OPTIMIZATION HELPERS
// ============================================================================

class ProfileProviderOptimization {
  /// Selects a specific slice of `ProfileDataProvider` state to avoid rebuilding
  /// entire screens when unrelated state changes.
  static T select<T>(BuildContext context, T Function(ProfileDataProvider) selector) {
    return context.select<ProfileDataProvider, T>(selector);
  }

  /// Standardized Consumer wrapper for full provider access when multiple fields are required.
  static Widget consumer({
    required Widget Function(BuildContext, ProfileDataProvider, Widget?) builder,
    Widget? child,
  }) {
    return Consumer<ProfileDataProvider>(
      builder: builder,
      child: child,
    );
  }
}
