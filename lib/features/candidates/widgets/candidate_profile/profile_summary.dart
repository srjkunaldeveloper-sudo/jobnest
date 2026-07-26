import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/models/recruitment_models.dart';

class ProfileSummary extends StatelessWidget {
  final CandidateModel? candidate;

  const ProfileSummary({
    super.key,
    this.candidate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String company = candidate?.company ?? "TechCorp India";
    final String exp = candidate?.experience ?? "5 Years";
    final String salary = candidate?.expectedSalary ?? "₹ 18 - 22 LPA";
    final String about = candidate?.about ??
        "Experienced software professional with a strong track record of designing scalable architecture, leading cross-functional teams, and deploying AI-driven solutions in fast-paced product environments.";
    final String resumeSummary = candidate?.resumeSummary ??
        "Senior Architect & Lead Engineer with 5+ years building distributed cloud applications and high-throughput microservices. Proven expertise in system design, CI/CD automation, and mentoring junior engineers.";
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile Summary & About",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double itemWidth;
                  if (constraints.maxWidth > 600) {
                    itemWidth = (constraints.maxWidth - (24 * 2)) / 3;
                  } else {
                    itemWidth = (constraints.maxWidth - 24) / 2;
                  }

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      SizedBox(
                        width: itemWidth,
                        child: _buildSummaryItem(context, Icons.email_outlined, "Email", "rahul.sharma@example.com"),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: _buildSummaryItem(context, Icons.phone_outlined, "Phone", "+91 98765 43210"),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: _buildSummaryItem(context, Icons.business_outlined, "Current Company", company),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: _buildSummaryItem(context, Icons.work_history_outlined, "Total Experience", exp),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: _buildSummaryItem(context, Icons.monetization_on_outlined, "Expected Salary", salary),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: _buildSummaryItem(context, Icons.location_city_outlined, "Preferred Location", "Bangalore, Remote"),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 20),
              
              Text(
                "About Candidate",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                about,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              
              Text(
                "Resume Summary",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                resumeSummary,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
