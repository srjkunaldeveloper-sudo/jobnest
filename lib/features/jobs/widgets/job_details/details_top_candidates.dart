import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';
import 'package:jobnest/features/candidates/providers/candidate_provider.dart';
import 'package:jobnest/features/jobs/job_details_screen.dart';

class DetailsTopCandidates extends StatelessWidget {
  final VoidCallback? onViewProfile;
  final VoidCallback? onMoveStage;
  final VoidCallback? onScheduleInterview;
  final VoidCallback? onViewAll;

  const DetailsTopCandidates({
    super.key,
    this.onViewProfile,
    this.onMoveStage,
    this.onScheduleInterview,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<JobProvider>();
    final candidateProvider = context.watch<CandidateProvider>();

    // Retrieve active JobModel context dynamically from parent screen or provider
    final parentScreen = context.findAncestorWidgetOfExactType<JobDetailsScreen>();
    final JobModel? activeJob = parentScreen?.job ?? provider.jobs.cast<JobModel?>().firstWhere(
      (j) => j?.title == parentScreen?.title && j?.company == parentScreen?.company,
      orElse: () => null,
    );

    if (activeJob == null) {
      return const SizedBox.shrink();
    }

    // Filter candidates matching the active requisition title
    final jobCandidates = candidateProvider.candidates
        .where((c) => c.role.toLowerCase() == activeJob.title.toLowerCase())
        .toList();

    if (jobCandidates.isEmpty) {
      return const SizedBox.shrink();
    }

    // Sort by match percentage descending to extract top candidates
    jobCandidates.sort((a, b) => b.matchPercentage.compareTo(a.matchPercentage));
    final topCandidates = jobCandidates.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Candidates",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              "Best matching candidates for this requisition.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Responsive grid/wrap list of candidates
        LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth;
            if (constraints.maxWidth > 800) {
              cardWidth = (constraints.maxWidth - 16) / 2; // 2 columns for wider screens
            } else {
              cardWidth = constraints.maxWidth; // 1 column for standard screens
            }
            if (cardWidth < 0) cardWidth = 100.0;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: topCandidates.map((candidate) {
                return SizedBox(
                  width: cardWidth,
                  child: _buildCandidateCard(context, candidate),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 16),

        // Bottom CTA View All button
        if (onViewAll != null)
          AppButton(
            text: "View All Candidates",
            variant: AppButtonVariant.secondary,
            onPressed: onViewAll,
          ),
      ],
    );
  }

  Widget _buildCandidateCard(BuildContext context, CandidateModel candidate) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: theme.colorScheme.primaryContainer,
                backgroundImage: candidate.avatarUrl.isNotEmpty
                    ? NetworkImage(candidate.avatarUrl)
                    : null,
                child: candidate.avatarUrl.isEmpty
                    ? Text(
                        candidate.name.isNotEmpty ? candidate.name[0] : "?",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Name, Company and Experience details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      candidate.company.isNotEmpty
                          ? "${candidate.experience} • ${candidate.company}"
                          : candidate.experience,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Current Stage
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        candidate.stage,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Match Score and Status Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${candidate.matchPercentage}% Match",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (candidate.isNew) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "New",
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Skills Chips
          if (candidate.skills.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: candidate.skills.take(3).map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: theme.textTheme.labelSmall,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],

          // Actions row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onViewProfile,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("View Profile"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: onMoveStage,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Move Stage"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: onScheduleInterview,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Schedule"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
