import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/candidates/widgets/candidate_icon_button.dart';

class CandidatesHeader extends StatelessWidget {
  const CandidatesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Candidates",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                AppSpacing.h4,
                Text(
                  "Search and manage applicants.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CandidateIconButton(icon: Icons.search_rounded, onTap: () {}),
              AppSpacing.w8,
              CandidateIconButton(icon: Icons.tune_rounded, onTap: () {}),
              AppSpacing.w8,
              CandidateIconButton(icon: Icons.sort_rounded, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
