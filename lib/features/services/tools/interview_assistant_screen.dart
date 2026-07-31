import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';

class InterviewAssistantScreen extends StatelessWidget {
  const InterviewAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: LLM future me interview questions generate karega.
    return AppPageScaffold(
      title: "AI Interview Assistant",
      body: SingleChildScrollView(
        padding: AppSpacing.edgeInsetsAll24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              padding: AppSpacing.edgeInsetsAll24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Context Setup",
                    style: AppText.h3,
                  ),
                  AppSpacing.h16,
                  Row(
                    children: [
                      const Expanded(
                        child: AppTextField(
                          label: "Job Role",
                          hint: "e.g., Flutter Developer",
                        ),
                      ),
                      AppSpacing.w16,
                      const Expanded(
                        child: AppTextField(
                          label: "Experience Level",
                          hint: "e.g., 3-5 Years",
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.h16,
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(AppIcons.generating_tokens_rounded),
                        label: const Text("Generate New Questions"),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                ],
              ),
            ),
            AppSpacing.h32,
            
            Text(
              "Generated Questions",
              style: AppText.h2,
            ),
            AppSpacing.h16,
                
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _buildCategory(
                        context,
                        "Technical Round",
                        AppIcons.code_rounded,
                        [
                          "Can you explain the difference between Provider and BLoC?",
                          "How do you handle memory leaks in Flutter applications?",
                        ],
                        isExpanded: true,
                      ),
                      const Divider(height: 1),
                      _buildCategory(
                        context,
                        "Behavioral Round",
                        AppIcons.psychology_rounded,
                        [
                          "Tell me about a time you had a disagreement with a designer.",
                        ],
                      ),
                      const Divider(height: 1),
                      _buildCategory(
                        context,
                        "Scenario Based",
                        AppIcons.extension_rounded,
                        [
                          "If the API is taking too long to respond, how would you design the UI state?",
                        ],
                      ),
                      const Divider(height: 1),
                      _buildCategory(
                        context,
                        "HR Round",
                        AppIcons.groups_rounded,
                        [
                          "What are your salary expectations for this role?",
                        ],
                      ),
                    ],
                  ),
                ),
            AppSpacing.h48,
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, IconData icon, List<String> questions, {bool isExpanded = false}) {
    final theme = Theme.of(context);
    return ExpansionTile(
      initiallyExpanded: isExpanded,
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        style: AppText.h3.copyWith(fontSize: 16),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: questions.map((q) => Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(AppIcons.help_outline_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
                  AppSpacing.w12,
                  Expanded(
                    child: Text(
                      q,
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
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}
