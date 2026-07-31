import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';
import 'package:jobnest/features/search/global_search_screen.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isMicPressed = false;
  String? _selectedChip;

  void _openSearch(BuildContext context, {String? initialQuery}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) => GlobalSearchScreen(initialQuery: initialQuery),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
          return FadeTransition(
            opacity: curve,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.96, end: 1.0).animate(curve),
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _showVoiceSearchBottomSheet(BuildContext context) {
    // TODO:
    // Integrate speech_to_text package.

    // TODO:
    // AI semantic search.

    // TODO:
    // Backend search endpoint.

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mic_rounded,
                  color: theme.colorScheme.primary,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Voice Search",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Speak your query to search across jobs, candidates, or companies in real time.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  // Simulate dummy voice recognition
                  _openSearch(context, initialQuery: "Senior Flutter Developer");
                },
                icon: const Icon(Icons.graphic_eq_rounded),
                label: const Text("Start Voice Search (Dummy)"),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(sheetContext),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                ),
                child: const Text("Coming Soon"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _onChipSelected(String label) {
    setState(() => _selectedChip = label);
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) {
        setState(() => _selectedChip = null);
        _openSearch(context, initialQuery: label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();
    
    // Combine trending and recent searches into Quick Search Chips
    final List<String> quickChips = [
      ...provider.trendingSearches.take(4),
      ...provider.recentSearches.take(3),
    ];
    final uniqueChips = quickChips.toSet().toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fully clickable Search Bar with Ripple Effect & Smooth Focus/Hover Animation
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              height: 52, // 52-56px height
              decoration: BoxDecoration(
                color: _isHovered 
                    ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3) 
                    : theme.colorScheme.surface, // Surface color only
                borderRadius: BorderRadius.circular(16), // 14-16px radius
                border: Border.all(
                  color: (_isHovered || _isPressed)
                      ? theme.colorScheme.primary // Focus state: Primary border only
                      : theme.dividerColor.withValues(alpha: 0.6), // 1px subtle border
                  width: 1.0,
                ),
                // Very soft shadow or no shadow (using none for flat SaaS look)
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onHover: (hovered) => setState(() => _isHovered = hovered),
                  onHighlightChanged: (pressed) => setState(() => _isPressed = pressed),
                  onTap: () => _openSearch(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // 16-20px padding
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: (_isHovered || _isPressed)
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        const SizedBox(width: 12), // 12px icon gap
                        Expanded(
                          child: Text(
                            "Search jobs, candidates...",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // No wrapped text, no clipped placeholder
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showVoiceSearchBottomSheet(context),
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            Icons.mic_none_rounded,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12), // Gap between trailing icons
                        GestureDetector(
                          onTap: () {
                            // Filter action
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            Icons.tune_rounded, // Simple ghost filter icon
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          if (uniqueChips.isNotEmpty) ...[
            AppSpacing.h16,
            // Quick Search Chips with horizontal scrolling & subtle selected state
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: uniqueChips.map((term) {
                  final isSelected = _selectedChip == term;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildQuickSearchChip(context, term, isSelected),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickSearchChip(BuildContext context, String label, bool isSelected) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: "Search $label",
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor.withValues(alpha: 0.5),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _onChipSelected(label),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? Icons.check_circle_rounded : Icons.trending_up_rounded,
                    size: 16,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
