import 'package:flutter/material.dart';

import 'package:jobnest/features/services/tools/resume_analyzer_screen.dart';
import 'package:jobnest/features/services/tools/interview_assistant_screen.dart';
import 'package:jobnest/features/services/tools/decision_support_screen.dart';

class ServicesFeatured extends StatelessWidget {
  const ServicesFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured AI Tools",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFeaturedCard(
                context,
                title: "Resume Analyzer AI",
                description: "Automatically extract skills and rank candidates based on deep learning matching.",
                icon: Icons.document_scanner_rounded,
                color: Colors.deepPurpleAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResumeAnalyzerScreen()),
                  );
                },
              ),
              const SizedBox(width: 16),
              _buildFeaturedCard(
                context,
                title: "Interview Assistant",
                description: "Real-time question generation and post-interview candidate scoring.",
                icon: Icons.forum_rounded,
                color: Colors.blueAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InterviewAssistantScreen()),
                  );
                },
              ),
              const SizedBox(width: 16),
              _buildFeaturedCard(
                context,
                title: "Decision Support",
                description: "Compare shortlisted candidates side-by-side with objective AI metrics.",
                icon: Icons.balance_rounded,
                color: Colors.orangeAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DecisionSupportScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            label: const Text("Open Tool"),
            style: FilledButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
