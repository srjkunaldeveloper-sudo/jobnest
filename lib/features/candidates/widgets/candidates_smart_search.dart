import 'package:flutter/material.dart';

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
    if (widget.searchQuery != oldWidget.searchQuery && widget.searchQuery != _controller.text) {
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== BACKEND TODO =====
          // TODO: Search backend API connect hogi.
          // TODO: Real-time search analytics.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome_rounded, color: Colors.deepPurpleAccent),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: widget.onSearchChanged,
                    decoration: InputDecoration(
                      hintText: "Try 'Flutter', 'Delhi', 'Infosys', or 'Python'...",
                      hintStyle: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_controller.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
                    onPressed: () {
                      _controller.clear();
                      widget.onClearSearch?.call();
                      widget.onSearchChanged?.call("");
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  ),
                const SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 24,
                  color: theme.dividerColor,
                ),
                const SizedBox(width: 4),
                Semantics(
                  label: "Voice Search Candidates",
                  button: true,
                  child: IconButton(
                    icon: Icon(Icons.mic_none_rounded, color: theme.colorScheme.primary),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Listening for voice search...")),
                      );
                    },
                    tooltip: "Voice Search",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "Recent:",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildRecentChip(context, "Flutter Developer"),
                    _buildRecentChip(context, "Python Engineer"),
                    _buildRecentChip(context, "Remote"),
                    _buildRecentChip(context, "Bangalore"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Semantics(
      label: "Filter by recent search $label",
      button: true,
      child: InkWell(
        onTap: () {
          _controller.text = label;
          widget.onRecentSelected?.call(label);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
