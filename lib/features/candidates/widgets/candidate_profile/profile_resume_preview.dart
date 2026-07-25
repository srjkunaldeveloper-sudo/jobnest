import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileResumePreview extends StatelessWidget {
  const ProfileResumePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Resume",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Resume backend storage se load hoga.
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent, size: 32),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rahul_Sharma_Resume.pdf",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Uploaded on 12 Oct 2023",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "•",
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "1.2 MB",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility_rounded, size: 18),
                          label: const Text("Preview"),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text("Download"),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
    );
  }
}
