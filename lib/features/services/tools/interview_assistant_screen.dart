import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class InterviewAssistantScreen extends StatelessWidget {
  const InterviewAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: LLM future me interview questions generate karega.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("AI Interview Assistant"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Context Setup",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Job Role",
                                hintText: "e.g., Flutter Developer",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Experience Level",
                                hintText: "e.g., 3-5 Years",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.generating_tokens_rounded),
                        label: const Text("Generate New Questions"),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                Text(
                  "Generated Questions",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _buildCategory(
                        context,
                        "Technical Round",
                        Icons.code_rounded,
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
                        Icons.psychology_rounded,
                        [
                          "Tell me about a time you had a disagreement with a designer.",
                        ],
                      ),
                      const Divider(height: 1),
                      _buildCategory(
                        context,
                        "Scenario Based",
                        Icons.extension_rounded,
                        [
                          "If the API is taking too long to respond, how would you design the UI state?",
                        ],
                      ),
                      const Divider(height: 1),
                      _buildCategory(
                        context,
                        "HR Round",
                        Icons.groups_rounded,
                        [
                          "What are your salary expectations for this role?",
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
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
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                  Icon(Icons.help_outline_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      q,
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
