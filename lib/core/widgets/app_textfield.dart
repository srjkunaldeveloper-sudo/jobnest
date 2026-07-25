import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? errorText;

  const AppTextField({
    super.key,
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixText,
    this.inputFormatters,
    this.maxLength,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = _isFocused ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant;
    
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixText: widget.prefixText,
        errorText: widget.errorText,
        counterText: "", // Hide character counter
        prefixIcon: widget.icon != null ? Icon(widget.icon, color: iconColor) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) => RotationTransition(
                    turns: child.key == const ValueKey('icon1')
                        ? Tween<double>(begin: 1, end: 1).animate(anim)
                        : Tween<double>(begin: 0.75, end: 1).animate(anim),
                    child: FadeTransition(opacity: anim, child: child),
                  ),
                  child: _obscureText
                      ? Icon(Icons.visibility_off_outlined, color: iconColor, key: const ValueKey('icon1'))
                      : Icon(Icons.visibility_outlined, color: iconColor, key: const ValueKey('icon2')),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}