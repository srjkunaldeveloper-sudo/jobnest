import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';

class HomeAiAssistant extends StatelessWidget {
  const HomeAiAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<RecruitmentDataProvider>();
    final bool isLoading = provider.isDashboardLoading;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.deepPurpleAccent,
                size: 24,
              ),
              AppSpacing.w8,
              Text(
                "AI Hiring Assistant",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          AppSpacing.h4,
          Text(
            "Ask AI to help with recruitment tasks.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h16,
          // ===== BACKEND TODO =====
          // TODO: AI backend connect karna hai yaha par (e.g. OpenAI or Gemini).
          if (isLoading)
            const AppShimmerLoading(
              width: double.infinity,
              height: 220,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            )
          else
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input Field
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.dividerColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        AppSpacing.w16,
                        const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                        AppSpacing.w12,
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Ask AI anything...",
                              hintStyle: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send_rounded, color: Colors.deepPurpleAccent),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.h16,
                  // Suggested Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildAiChip(context, "Find Python Developers"),
                      _buildAiChip(context, "Schedule Interviews"),
                      _buildAiChip(context, "Generate Job Description"),
                      _buildAiChip(context, "Find Top Candidates"),
                      _buildAiChip(context, "Improve Hiring Rate"),
                    ],
                  ),
                  AppSpacing.h24,
                  const Divider(),
                  AppSpacing.h16,
                  // Recent AI Suggestions
                  Text(
                    "Recent AI Suggestions",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.h12,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.deepPurpleAccent.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lightbulb_outline_rounded,
                          color: Colors.deepPurpleAccent,
                          size: 20,
                        ),
                        AppSpacing.w12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Sales Executive job is getting fewer applications.",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              AppSpacing.h8,
                              Row(
                                children: [
                                  const Icon(Icons.arrow_right_alt_rounded, size: 16, color: Colors.deepPurple),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Increase salary by 10%.",
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAiChip(BuildContext context, String text) {
    final theme = Theme.of(context);
    return ActionChip(
      label: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
        ),
      ),
      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      onPressed: () {},
    );
  }
}
