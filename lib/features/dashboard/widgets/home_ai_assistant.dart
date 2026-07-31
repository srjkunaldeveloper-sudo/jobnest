import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/features/dashboard/models/models.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';


class HomeAiAssistant extends StatefulWidget {
  const HomeAiAssistant({super.key});

  @override
  State<HomeAiAssistant> createState() => _HomeAiAssistantState();
}

class _HomeAiAssistantState extends State<HomeAiAssistant> {
  final TextEditingController _controller = TextEditingController();
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();
    final AiAssistantStateModel state = provider.aiAssistantState;
    final bool isLoading = provider.isDashboardLoading || state.isLoading;
    
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: AppShimmerLoading(
          width: double.infinity,
          height: 180,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // Bottom padding 20px
      child: AppCard(
        padding: const EdgeInsets.all(16), // Overall card padding reduced to 16px
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.deepPurpleAccent,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "AI Hiring Assistant",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(width: 8),
                // Small "AI" badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "AI",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4), // Header -> Description 4px
            // Small description
            Text(
              "Ask AI to help with hiring, screening, or drafting.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16), // Description -> Input 16px
            // ONE search/input row
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.6),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 18,
                    color: Colors.deepPurpleAccent.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textAlignVertical: TextAlignVertical.center,
                      onSubmitted: (val) {
                        if (val.trim().isNotEmpty) {
                          provider.submitAiPrompt(val);
                          _controller.clear();
                        }
                      },
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: "Ask AI to help with hiring...",
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.arrow_upward_rounded,
                      size: 20,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        provider.submitAiPrompt(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Input -> Chips 16px
            // Suggestion chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                "Find Developers",
                "Interview Questions",
                "Generate JD",
                "Screen Resume",
                "Hiring Email",
                "Offer Letter",
              ].map((text) => _buildCompactChip(context, text, provider)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactChip(BuildContext context, String text, DashboardProvider provider) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(999), // Pill shape
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {
          provider.submitAiPrompt(text);
        },
        child: Container(
          height: 30, // Height 30px
          padding: const EdgeInsets.symmetric(horizontal: 12), // Horizontal padding 12px
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3), width: 1.0), // 1px subtle border
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 13, // 13px
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500, // Medium
                  letterSpacing: 0, // Normal letter spacing
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
