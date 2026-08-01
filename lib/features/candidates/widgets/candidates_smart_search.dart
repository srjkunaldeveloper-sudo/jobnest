import '../../../core/constants/app_icons.dart';
import '../../../core/widgets/app_searchbar.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CandidatesSmartSearch extends StatefulWidget {
  final String searchQuery;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onClearSearch;
  final ValueChanged<String>? onRecentSelected;

  const CandidatesSmartSearch({
    super.key,
    this.searchQuery = "",
    this.onSearchChanged,
    this.onClearSearch,
    this.onRecentSelected,
  });

  @override
  State<CandidatesSmartSearch> createState() => _CandidatesSmartSearchState();
}

class _CandidatesSmartSearchState extends State<CandidatesSmartSearch> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant CandidatesSmartSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        widget.searchQuery != _controller.text) {
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMicTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Voice search is not configured in this demo."),
      ),
    );
  }

  void _showFilterPopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss Filters',
      barrierColor: Colors.black.withValues(alpha: 0.3),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        final theme = Theme.of(context);
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Advanced Filters",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            AppIcons.close_rounded,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildFilterSection(context, "Candidate Profile", [
                      "Active",
                      "Passive",
                      "Open to Offers",
                      "Freelance",
                    ]),
                    const SizedBox(height: 20),
                    _buildFilterSection(context, "Location", [
                      "Remote",
                      "On-site",
                      "Hybrid",
                    ]),
                    const SizedBox(height: 20),
                    _buildFilterSection(context, "Experience", [
                      "0-2 Years",
                      "3-5 Years",
                      "5-8 Years",
                      "8+ Years",
                    ]),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Apply Filters"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    List<String> options,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.dividerColor.withValues(alpha: 0.5),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  option,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== BACKEND TODO =====
          // TODO: Search backend API connect hogi.
          // TODO: Real-time search analytics.
          AppSearchBar(
            controller: _controller,
            onChanged: widget.onSearchChanged,
            onClear: widget.onClearSearch,
            onFilterTap: () => _showFilterPopup(context),
            onMicTap: _onMicTap,
            hintText: "Try 'Flutter', 'Delhi', 'Infosys', or 'Python'...",
            icon: AppIcons.search_rounded,
          ),
          const SizedBox(height: 8),
          Text(
            "Recent",
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildRecentChip(context, "Flutter Developer"),
              _buildRecentChip(context, "Python Engineer"),
              _buildRecentChip(context, "Remote"),
              _buildRecentChip(context, "Bangalore"),
              _buildRecentChip(context, "▼ More"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChip(BuildContext context, String label) {
    final theme = Theme.of(context);

    return Semantics(
      label: "Recent search: $label",
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _controller.text = label;
            _controller.selection = TextSelection.collapsed(
              offset: label.length,
            );
            widget.onRecentSelected?.call(label);
          },
          borderRadius: BorderRadius.circular(999),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 24,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
