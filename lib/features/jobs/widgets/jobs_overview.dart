import 'package:flutter/material.dart';

import 'package:jobnest/core/widgets/stat_card.dart';

class JobsOverview extends StatelessWidget {
  const JobsOverview({super.key});

  @override
  Widget build(BuildContext context) {
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

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: cardWidth,
                child: const StatCard(
                  title: "Active Jobs", 
                  count: "24", 
                  icon: Icons.work_outline_rounded, 
                  color: Colors.blueAccent, 
                  trend: "+3", 
                  isPositiveTrend: true,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const StatCard(
                  title: "Closed Jobs", 
                  count: "156", 
                  icon: Icons.done_all_rounded, 
                  color: Colors.teal, 
                  trend: "", 
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const StatCard(
                  title: "Applications", 
                  count: "1,240", 
                  icon: Icons.description_outlined, 
                  color: Colors.orangeAccent, 
                  trend: "+12%", 
                  isPositiveTrend: true,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const StatCard(
                  title: "Urgent Hiring", 
                  count: "2", 
                  icon: Icons.warning_amber_rounded, 
                  color: Colors.redAccent, 
                  trend: "", 
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
