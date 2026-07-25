import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/stat_card.dart';

class DetailsOverview extends StatelessWidget {
  const DetailsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth;
        if (constraints.maxWidth > 800) {
          cardWidth = (constraints.maxWidth - (16 * 4)) / 5;
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
                title: "Applications",
                count: "246",
                icon: Icons.description_outlined,
                color: Colors.blueAccent,
                trend: "+12",
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
                trend: "+3",
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
                trend: "",
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: const StatCard(
                title: "Selected",
                count: "2",
                icon: Icons.star_border_rounded,
                color: Colors.green,
                trend: "",
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: const StatCard(
                title: "Rejected",
                count: "15",
                icon: Icons.cancel_outlined,
                color: Colors.redAccent,
                trend: "",
              ),
            ),
          ],
        );
      },
    );
  }
}
