import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/constants/app_spacing.dart';

class ProfileAiInterviewAssistant extends StatelessWidget {
  const ProfileAiInterviewAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(AppIcons.forum_rounded, color: Colors.blueAccent, size: 24),
            AppSpacing.w12,
            Text(
              "AI Interview Assistant",
              style: AppText.h3,
            ),
          ],
        ),
        AppSpacing.h16,
        // ===== BACKEND TODO =====
        // TODO: AI Interview Questions LLM backend generate karega.
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildCategoryTile(
                context,
                title: "Technical Questions",
                icon: AppIcons.code_rounded,
                isExpanded: true,
                questions: [
                  "Can you explain how the BLoC pattern differs from Provider, and when you would choose one over the other?",
                  "Describe a time you had to migrate a legacy mobile app to Flutter. What were the biggest challenges?",
                  "How do you handle background tasks and push notifications in a cross-platform environment?",
                ],
              ),
              const Divider(height: 1),
              _buildCategoryTile(
                context,
                title: "Behavioral Questions",
                icon: AppIcons.psychology_rounded,
                isExpanded: false,
                questions: [
                  "Tell me about a time you had a disagreement with a UI/UX designer. How did you resolve it?",
                ],
              ),
              const Divider(height: 1),
              _buildCategoryTile(
                context,
                title: "HR Questions",
                icon: AppIcons.groups_rounded,
                isExpanded: false,
                questions: [
                  "Why are you looking to leave your current role after 2.5 years?",
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isExpanded,
    required List<String> questions,
  }) {
    final theme = Theme.of(context);

    return ExpansionTile(
      initiallyExpanded: isExpanded,
      iconColor: theme.colorScheme.primary,
      collapsedIconColor: theme.colorScheme.onSurfaceVariant,
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(
        title,
        style: AppText.h3.copyWith(fontSize: 16),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: questions.map((q) => _buildQuestionItem(context, q)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionItem(BuildContext context, String question) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(AppIcons.help_outline_rounded, size: 16, color: theme.colorScheme.primary),
          AppSpacing.w12,
          Expanded(
            child: Text(
              question,
              style: AppText.bodyMedium.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          AppSpacing.w12,
          IconButton(
            onPressed: () {},
            icon: const Icon(AppIcons.content_copy_rounded, size: 16),
            tooltip: "Copy Question",
            splashRadius: 20,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(4),
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
