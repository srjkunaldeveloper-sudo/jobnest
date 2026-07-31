import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/widgets/stat_card.dart';
import 'package:jobnest/features/jobs/providers/job_filter_provider.dart';

class JobsOverview extends StatelessWidget {
  const JobsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = context.watch<JobFilterProvider>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth;
          if (constraints.maxWidth > 800) {
            cardWidth = (constraints.maxWidth - (16 * 3)) / 4;
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
                  title: "Active Jobs", 
                  count: filterProvider.activeJobsCount.toString(), 
                  icon: AppIcons.work_outline_rounded, 
                  color: Colors.blueAccent, 
                  trend: "+3", 
                  isPositiveTrend: true,
                  onTap: () => filterProvider.setSelectedFilter("Open"),
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: StatCard(
                  title: "Closed Jobs", 
                  count: filterProvider.closedJobsCount.toString(), 
                  icon: AppIcons.done_all_rounded, 
                  color: Colors.teal, 
                  trend: "", 
                  onTap: () => filterProvider.setSelectedFilter("Closed"),
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: StatCard(
                  title: "Applications", 
                  count: filterProvider.totalApplications.toString(), 
                  icon: AppIcons.description_outlined, 
                  color: Colors.orangeAccent, 
                  trend: "+12%", 
                  isPositiveTrend: true,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: StatCard(
                  title: "Urgent Hiring", 
                  count: filterProvider.urgentJobsCount.toString(), 
                  icon: AppIcons.warning_amber_rounded, 
                  color: Colors.redAccent, 
                  trend: "", 
                  onTap: () => filterProvider.setSelectedFilter("Hiring"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
