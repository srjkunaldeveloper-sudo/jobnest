import 'package:flutter/material.dart';
import '../constants/app_text.dart';
import '../constants/app_radius.dart';
import '../constants/app_colors.dart';

enum AppButtonVariant { primary, secondary, text }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double? height;
  final AppButtonVariant variant;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
    this.variant = AppButtonVariant.primary,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  void _handleTapDown(PointerDownEvent event) {
    if (!widget.isLoading && widget.onPressed != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(PointerUpEvent event) {
    if (!widget.isLoading) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel(PointerCancelEvent event) {
    if (!widget.isLoading) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Color foregroundColor;
    Color? borderColor;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
        foregroundColor = isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
        borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
        break;
      case AppButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
        break;
    }

    final isDisabled = widget.onPressed == null || widget.isLoading;

    return Listener(
      onPointerDown: _handleTapDown,
      onPointerUp: _handleTapUp,
      onPointerCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 52,
          child: ElevatedButton(
            onPressed: isDisabled ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              disabledBackgroundColor: isDark ? AppColors.darkSurface.withValues(alpha: 0.5) : AppColors.borderLight,
              disabledForegroundColor: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.medium,
                side: borderColor != null && !isDisabled
                    ? BorderSide(color: borderColor)
                    : BorderSide.none,
              ),
            ),
            child: widget.isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: foregroundColor,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: AppText.button.copyWith(color: isDisabled ? null : foregroundColor),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}