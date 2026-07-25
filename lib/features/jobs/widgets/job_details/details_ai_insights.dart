import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class DetailsAiInsights extends StatelessWidget {
  const DetailsAiInsights({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "AI Insights",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: AI recommendation service connect hogi.
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.deepPurpleAccent, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Increase salary to improve applications",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your current maximum salary of ₹6L is 15% below the market average for Senior roles in Bangalore. This is causing a 20% drop in application rates this week.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_rounded, size: 18, color: Colors.deepPurpleAccent),
                      label: const Text(
                        "Update Salary Range",
                        style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.deepPurpleAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
