import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/stat_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';

class HomeQuickStats extends StatefulWidget {
  const HomeQuickStats({super.key});

  @override
  State<HomeQuickStats> createState() => _HomeQuickStatsState();
}

class _HomeQuickStatsState extends State<HomeQuickStats> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate backend API loading
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Stats",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          AppSpacing.h16,
          // ===== BACKEND TODO =====
          // TODO: API se actual dashboard stats aayenge, ye abhi dummy UI hai.
          LayoutBuilder(
            builder: (context, constraints) {
              double cardWidth;
              if (constraints.maxWidth > 800) {
                cardWidth = (constraints.maxWidth - 48) / 4;
              } else if (constraints.maxWidth > 500) {
                cardWidth = (constraints.maxWidth - 32) / 3;
              } else {
                cardWidth = (constraints.maxWidth - 16) / 2;
              }

              return _isLoading
                  ? Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(
                        5,
                        (index) => SizedBox(
                          width: cardWidth,
                          child: const AppShimmerLoading(
                            width: double.infinity,
                            height: 120,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                      ),
                    )
                  : Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: const StatCard(
                            title: "Active Jobs", 
                            count: "12", 
                            icon: Icons.work_outline_rounded, 
                            color: Colors.blueAccent, 
                            trend: "+12%", 
                            isPositiveTrend: true,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const StatCard(
                            title: "Candidates", 
                            count: "84", 
                            icon: Icons.groups_rounded, 
                            color: Colors.orangeAccent, 
                            trend: "+5%", 
                            isPositiveTrend: true,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const StatCard(
                            title: "Shortlisted", 
                            count: "24", 
                            icon: Icons.task_alt_rounded, 
                            color: Colors.greenAccent, 
                            trend: "-2%", 
                            isPositiveTrend: false,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const StatCard(
                            title: "Interviews", 
                            count: "8", 
                            icon: Icons.calendar_today_rounded, 
                            color: Colors.purpleAccent, 
                            trend: "+20%", 
                            isPositiveTrend: true,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const StatCard(
                            title: "Selected", 
                            count: "3", 
                            icon: Icons.verified_rounded, 
                            color: Colors.tealAccent, 
                            trend: "+1", 
                            isPositiveTrend: true,
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
