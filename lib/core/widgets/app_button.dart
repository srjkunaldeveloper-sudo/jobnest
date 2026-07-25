import 'package:flutter/material.dart';
import '../constants/app_text.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  void _handleTapDown(PointerDownEvent event) {
    if (!widget.isLoading) {
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
          height: widget.height ?? 56,
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: widget.isLoading
                ? SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.onPrimary,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: AppText.button.copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}