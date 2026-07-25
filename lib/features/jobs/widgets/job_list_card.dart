import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/jobs/job_details_screen.dart';

class JobListCard extends StatefulWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final String applicationsCount;
  final String status;
  final int aiMatchScore;

  const JobListCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.applicationsCount,
    required this.status,
    required this.aiMatchScore,
  });

  @override
  State<JobListCard> createState() => _JobListCardState();
}

class _JobListCardState extends State<JobListCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isActive = widget.status.toLowerCase() == "active";

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobDetailsScreen(
                      title: widget.title,
                      company: widget.company,
                      location: widget.location,
                      salary: widget.salary,
                      jobType: widget.jobType,
                      status: widget.status,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AppSpacing.h4,
                              Text(
                                "${widget.company} • ${widget.location}",
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.status,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isActive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.h16,
                    // Attributes Row
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        _buildAttribute(context, Icons.monetization_on_rounded, widget.salary),
                        _buildAttribute(context, Icons.work_rounded, widget.jobType),
                        _buildAttribute(context, Icons.people_alt_rounded, "${widget.applicationsCount} Apps"),
                      ],
                    ),
                    AppSpacing.h16,
                    const Divider(),
                    AppSpacing.h12,
                    // Bottom Actions & AI Match
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // AI Match
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome_rounded, color: Colors.deepPurpleAccent, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "${widget.aiMatchScore}% AI Match",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // Actions
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                minimumSize: const Size(0, 32),
                              ),
                              child: const Text("Edit"),
                            ),
                            FilledButton.tonal(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                minimumSize: const Size(0, 32),
                              ),
                              child: const Text("View"),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert_rounded, size: 18),
                              splashRadius: 20,
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(8),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttribute(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
