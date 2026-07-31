import '../../core/constants/app_icons.dart';
import 'dart:async';
import 'package:flutter/material.dart';

/// A reusable search bar widget with built-in debouncing for API-friendly typing.
class AppSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final Duration debounce;

  const AppSearchBar({
    super.key,
    required this.onChanged,
    this.controller,
    this.hintText = 'Search...',
    this.initialValue,
    this.debounce = const Duration(milliseconds: 400),
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;
  Timer? _debounceTimer;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _showClearButton = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(AppSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null && widget.controller != oldWidget.controller) {
      _controller.removeListener(_onTextChanged);
      _controller = widget.controller!;
      _controller.addListener(_onTextChanged);
      _showClearButton = _controller.text.isNotEmpty;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (_showClearButton != hasText) {
      setState(() {
        _showClearButton = hasText;
      });
    }

    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(widget.debounce, () {
      widget.onChanged(_controller.text);
    });
  }

  void _clearSearch() {
    _controller.clear(); // This will trigger _onTextChanged, which starts the timer
    _debounceTimer?.cancel(); // Cancel the timer immediately
    widget.onChanged(''); // Call onChanged instantly for a snappy clear interaction
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: 'Search Input Field',
      textField: true,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(
            AppIcons.search,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          suffixIcon: _showClearButton
              ? Semantics(
                  button: true,
                  label: 'Clear search',
                  child: IconButton(
                    icon: const Icon(AppIcons.clear),
                    onPressed: _clearSearch,
                    tooltip: 'Clear search text',
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        onSubmitted: (value) {
          _debounceTimer?.cancel();
          widget.onChanged(value);
        },
      ),
    );
  }
}
