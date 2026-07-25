import 'package:flutter/material.dart';

class SocialButton extends StatefulWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isPressed = false;

  void _handleTapDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(PointerUpEvent event) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel(PointerCancelEvent event) {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color textColor = theme.colorScheme.onSurface;
    final Color borderColor = theme.dividerColor;

    return Listener(
      onPointerDown: _handleTapDown,
      onPointerUp: _handleTapUp,
      onPointerCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: widget.onPressed,
            icon: widget.icon,
            label: Text(
              widget.text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            style: OutlinedButton.styleFrom(
              elevation: 0,
              side: BorderSide(
                color: borderColor,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
