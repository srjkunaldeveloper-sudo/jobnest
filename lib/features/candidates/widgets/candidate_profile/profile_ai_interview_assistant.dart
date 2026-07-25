import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

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
            const Icon(Icons.forum_rounded, color: Colors.blueAccent, size: 24),
            const SizedBox(width: 12),
            Text(
              "AI Interview Assistant",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: AI Interview Questions LLM backend generate karega.
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildCategoryTile(
                context,
                title: "Technical Questions",
                icon: Icons.code_rounded,
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
                icon: Icons.psychology_rounded,
                isExpanded: false,
                questions: [
                  "Tell me about a time you had a disagreement with a UI/UX designer. How did you resolve it?",
                ],
              ),
              const Divider(height: 1),
              _buildCategoryTile(
                context,
                title: "HR Questions",
                icon: Icons.groups_rounded,
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
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
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
          Icon(Icons.help_outline_rounded, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              question,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.content_copy_rounded, size: 16),
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
