import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';

class ServicesSearch extends StatefulWidget {
  final FocusNode? focusNode;

  const ServicesSearch({
    super.key,
    this.focusNode,
  });

  @override
  State<ServicesSearch> createState() => _ServicesSearchState();
}

class _ServicesSearchState extends State<ServicesSearch> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ServicesDataProvider>();
    _controller = TextEditingController(text: provider.searchQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ServicesDataProvider>();

    // Update controller text if provider changed from outside (e.g., clear button in header/restore)
    if (_controller.text != provider.searchQuery) {
      _controller.value = _controller.value.copyWith(
        text: provider.searchQuery,
        selection: TextSelection.collapsed(offset: provider.searchQuery.length),
      );
    }

    // ===== BACKEND TODO =====
    // TODO: Search API connect hogi.
    // TODO: Services API integration.
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: provider.searchQuery.isNotEmpty
              ? theme.colorScheme.primary
              : theme.dividerColor.withValues(alpha: 0.5),
          width: provider.searchQuery.isNotEmpty ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Semantics(
        label: "Search services by name, category, or description",
        textField: true,
        child: TextField(
          controller: _controller,
          focusNode: widget.focusNode,
          onChanged: (value) {
            provider.setSearchQuery(value);
          },
          decoration: InputDecoration(
            hintText: "Search tools (e.g. Resume Analyzer, CRM...)",
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                AppIcons.search_rounded,
                color: provider.searchQuery.isNotEmpty
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            suffixIcon: provider.searchQuery.isNotEmpty
                ? Semantics(
                    label: "Clear search query",
                    button: true,
                    child: IconButton(
                      icon: const Icon(AppIcons.clear_rounded),
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                      onPressed: () {
                        _controller.clear();
                        provider.clearSearchQuery();
                      },
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
