import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/stat_card.dart';

class DetailsOverview extends StatelessWidget {
  final JobModel? job;

  const DetailsOverview({super.key, this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final JobModel defaultJob = const JobModel(
      id: 'dummy',
      title: 'Senior Sales Executive',
      company: 'TechCorp India',
      location: 'Delhi, India',
      salary: '₹ 4 - 6 LPA',
      jobType: 'Full Time',
      applicationsCount: '246',
      status: 'Open',
      aiMatchScore: 92,
    );
    final JobModel activeJob = job ?? defaultJob;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. ATS Stat Cards
        LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth;
            if (constraints.maxWidth > 800) {
              cardWidth = (constraints.maxWidth - (16 * 4)) / 5;
            } else if (constraints.maxWidth > 500) {
              cardWidth = (constraints.maxWidth - (16 * 2)) / 3;
            } else {
              cardWidth = (constraints.maxWidth - 16) / 2;
            }
            if (cardWidth < 0) cardWidth = 100.0;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    title: "Applications",
                    count: activeJob.applicationsCount,
                    icon: Icons.description_outlined,
                    color: Colors.blueAccent,
                    trend: "+12%",
                    isPositiveTrend: true,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const StatCard(
                    title: "Shortlisted",
                    count: "45",
                    icon: Icons.fact_check_outlined,
                    color: Colors.orangeAccent,
                    trend: "+3%",
                    isPositiveTrend: true,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const StatCard(
                    title: "Interviews",
                    count: "12",
                    icon: Icons.people_alt_outlined,
                    color: Colors.deepPurpleAccent,
                    trend: "Stable",
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const StatCard(
                    title: "Selected",
                    count: "2",
                    icon: Icons.star_border_rounded,
                    color: Colors.green,
                    trend: "+1",
                    isPositiveTrend: true,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const StatCard(
                    title: "Rejected",
                    count: "15",
                    icon: Icons.cancel_outlined,
                    color: Colors.redAccent,
                    trend: "-2%",
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 32),

        // 2. Job Requisition Profile Card
        AppCard(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Job Requisition Details",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // About the Role
              _buildSectionHeading(theme, Icons.info_outline_rounded, "About the Role (Company & Description)"),
              const SizedBox(height: 12),
              Text(
                activeJob.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),

              // Key Responsibilities
              _buildSectionHeading(theme, Icons.task_alt_rounded, "Key Responsibilities"),
              const SizedBox(height: 12),
              ...activeJob.responsibilities.map((resp) => _buildBulletItem(theme, resp, Icons.check_circle_outline_rounded, Colors.blueAccent)),
              const SizedBox(height: 28),

              // Requirements & Qualifications
              _buildSectionHeading(theme, Icons.school_outlined, "Requirements & Qualifications"),
              const SizedBox(height: 12),
              ...activeJob.requirements.map((req) => _buildBulletItem(theme, req, Icons.arrow_right_rounded, theme.colorScheme.primary)),
              const SizedBox(height: 28),

              // Required Skills
              _buildSectionHeading(theme, Icons.auto_awesome_outlined, "Required Skills & Competencies"),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: activeJob.skills.map((skill) => _buildSkillChip(theme, skill)).toList(),
              ),
              const SizedBox(height: 28),

              // Compensation & Benefits
              _buildSectionHeading(theme, Icons.card_giftcard_rounded, "Compensation & Benefits"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.monetization_on_rounded, color: Colors.green, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Annual Compensation Range",
                            style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activeJob.salary,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...activeJob.benefits.map((ben) => _buildBulletItem(theme, ben, Icons.favorite_border_rounded, Colors.pinkAccent)),
              const SizedBox(height: 28),

              // Hiring Timeline & Process
              _buildSectionHeading(theme, Icons.timeline_rounded, "Hiring Timeline & Process"),
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
                    Icon(Icons.access_time_filled_rounded, color: theme.colorScheme.primary, size: 24),
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
    );
  }

  Widget _buildSectionHeading(ThemeData theme, IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
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
