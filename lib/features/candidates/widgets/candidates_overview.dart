import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/stat_card.dart';

class CandidatesOverview extends StatelessWidget {
  const CandidatesOverview({super.key});

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
                  title: "Total Candidates", 
                  count: "12,450", 
                  icon: AppIcons.people_alt_outlined, 
                  color: Colors.blueAccent, 
                  trend: "+124", 
                  isPositiveTrend: true,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const StatCard(
                  title: "Shortlisted", 
                  count: "450", 
                  icon: AppIcons.fact_check_outlined, 
                  color: Colors.orangeAccent, 
                  trend: "+12", 
                  isPositiveTrend: true,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const StatCard(
                  title: "Interview Today", 
                  count: "18", 
                  icon: AppIcons.video_camera_front_outlined, 
                  color: Colors.deepPurpleAccent, 
                  trend: "", 
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const StatCard(
                  title: "Selected", 
                  count: "42", 
                  icon: AppIcons.star_border_rounded, 
                  color: Colors.green, 
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
