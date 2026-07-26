import 'package:flutter/material.dart';

class AppErrorState extends StatelessWidget {
  final String title;
  final String message;
  final String? description; // Optional alias for message
  final String primaryButtonText;
  final VoidCallback? onRetry;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryAction;
  final IconData iconData;
  final IconData? secondaryIconData;
  final Color? iconColor;
  final double iconSize;

  const AppErrorState({
    super.key,
    this.title = "Something went wrong",
    this.message = "An unexpected error occurred. Please check your connection and try again.",
    this.description,
    this.primaryButtonText = "Retry",
    required this.onRetry,
    this.secondaryButtonText,
    this.onSecondaryAction,
    this.iconData = Icons.cloud_off_rounded,
    this.secondaryIconData,
    this.iconColor,
    this.iconSize = 56.0,
  });

  String get _displayDescription => description ?? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? theme.colorScheme.error;

    return SafeArea(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.sizeOf(context).width;
            final isPhone = screenWidth < 600 || constraints.maxWidth < 500;

            // Ensure elastic maxWidth adaptation without hardcoded widths on small phone screens.
            final maxWidth = isPhone ? constraints.maxWidth : 600.0;
            final availableWidth = constraints.maxWidth;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top: Error Icon
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: effectiveIconColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        iconData,
                        size: iconSize,
                        color: effectiveIconColor,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title: Wrap naturally, Max 2 lines if needed
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    // Description: Wrap automatically, Center aligned
                    Text(
                      _displayDescription,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // Action Buttons: Never force into a fixed horizontal Row.
                    // Stacks vertically automatically when horizontal space is insufficient on phone widths < 600.
                    _buildActionButtons(context, isPhone, theme, availableWidth),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    bool isPhone,
    ThemeData theme,
    double availableWidth,
  ) {
    // Avoid fixed button widths; enforce minimum touch target height and maximum width to prevent overflow
    final maxButtonWidth = (availableWidth - 48).clamp(120.0, 500.0);

    final primaryButton = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48,
        minWidth: 120,
        maxWidth: maxButtonWidth,
      ),
      child: FilledButton(
        onPressed: onRetry,
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.error,
          foregroundColor: theme.colorScheme.onError,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.refresh_rounded, size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                primaryButtonText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );

    if (onSecondaryAction == null || secondaryButtonText == null) {
      return primaryButton;
    }

    final effectiveSecondaryIcon = secondaryIconData ?? Icons.restore_rounded;
    final secondaryButton = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48,
        minWidth: 120,
        maxWidth: maxButtonWidth,
      ),
      child: OutlinedButton(
        onPressed: onSecondaryAction,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(effectiveSecondaryIcon, size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                secondaryButtonText!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );

    // Use Wrap instead of fixed Row so buttons automatically stack vertically when horizontal space is insufficient.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16.0,
      runSpacing: 12.0,
      children: [
        primaryButton,
        secondaryButton,
      ],
    );
  }
}
