import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class DetailsOverview extends StatelessWidget {
  final JobModel? job;

  const DetailsOverview({super.key, this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // If job is null, render the empty state instead of fake recruiter data
    if (job == null) {
      return const AppCard(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "No requisition details available.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    final JobModel activeJob = job!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SECTION 1: Overview Card
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeading(theme, AppIcons.info_outline_rounded, "Requisition Overview"),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isWide ? 2 : 1,
                    childAspectRatio: isWide ? 3.5 : 4.5,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 16,
                    children: [
                      if (activeJob.company.isNotEmpty && activeJob.company != "--")
                        _buildMetadataItem(context, AppIcons.work_outline_rounded, "Company", activeJob.company),
                      if (activeJob.location.isNotEmpty && activeJob.location != "--")
                        _buildMetadataItem(context, AppIcons.location_on_rounded, "Location", activeJob.location),
                      if (activeJob.jobType.isNotEmpty && activeJob.jobType != "--")
                        _buildMetadataItem(context, AppIcons.description_outlined, "Employment Type", activeJob.jobType),
                      if (activeJob.salary.isNotEmpty && activeJob.salary != "--")
                        _buildMetadataItem(context, AppIcons.monetization_on_rounded, "Salary Package", activeJob.salary),
                      if (activeJob.postedDate.isNotEmpty && activeJob.postedDate != "--")
                        _buildMetadataItem(context, AppIcons.calendar_today_rounded, "Posted Date", activeJob.postedDate),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // SECTION 2: Job Description
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeading(theme, AppIcons.description_outlined, "Job Description"),
              const SizedBox(height: 12),
              Text(
                activeJob.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // SECTION 3: Requirements
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeading(theme, AppIcons.task_alt_rounded, "Requirements & Qualifications"),
              const SizedBox(height: 12),
              ...activeJob.requirements.map(
                (req) => _buildBulletItem(
                  theme,
                  req,
                  AppIcons.arrow_right_rounded,
                  theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),

        // Required Skills Section (Restored if available)
        if (activeJob.skills.isNotEmpty) ...[
          const SizedBox(height: 20),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeading(theme, AppIcons.auto_awesome_outlined, "Required Skills & Competencies"),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: activeJob.skills.map((skill) => _buildSkillChip(theme, skill)).toList(),
                ),
              ],
            ),
          ),
        ],

        // SECTION 4: Benefits (only if data exists)
        if (activeJob.benefits.isNotEmpty) ...[
          const SizedBox(height: 20),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeading(theme, AppIcons.card_giftcard_rounded, "Compensation & Benefits"),
                const SizedBox(height: 12),
                ...activeJob.benefits.map(
                  (ben) => _buildBulletItem(
                    theme,
                    ben,
                    AppIcons.favorite_border_rounded,
                    Colors.pinkAccent,
                  ),
                ),
              ],
            ),
          ),
        ],

        // Hiring Timeline Section (Restored if timeline data exists)
        if (activeJob.hiringTimeline.isNotEmpty && activeJob.hiringTimeline != "--") ...[
          const SizedBox(height: 20),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeading(theme, AppIcons.timeline_rounded, "Hiring Timeline & Process"),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(AppIcons.access_time_filled_rounded, color: theme.colorScheme.primary, size: 24),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          activeJob.hiringTimeline,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionHeading(ThemeData theme, IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletItem(ThemeData theme, String text, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataItem(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(ThemeData theme, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        skill,
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
