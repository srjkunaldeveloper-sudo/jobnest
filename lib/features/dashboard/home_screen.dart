import 'package:flutter/material.dart';

import 'package:jobnest/features/dashboard/widgets/home_header.dart';
import 'package:jobnest/features/dashboard/widgets/home_search.dart';
import 'package:jobnest/features/dashboard/widgets/home_focus.dart';
import 'package:jobnest/features/dashboard/widgets/home_quick_stats.dart';
import 'package:jobnest/features/dashboard/widgets/home_analytics.dart';
import 'package:jobnest/features/dashboard/widgets/home_ai_assistant.dart';
import 'package:jobnest/features/dashboard/widgets/home_quick_actions.dart';
import 'package:jobnest/features/dashboard/widgets/home_daily_tasks.dart';
import 'package:jobnest/features/dashboard/widgets/home_activity_timeline.dart';
import 'package:jobnest/features/dashboard/widgets/home_smart_notifications.dart';
import 'package:jobnest/features/dashboard/widgets/home_hiring_probability.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const HomeScreen({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(onProfileTap: onProfileTap),
              const HomeSearch(),
              const HomeFocus(),
              const HomeQuickStats(),
              const HomeAnalytics(),
              const HomeAiAssistant(),
              const HomeQuickActions(),
              const HomeDailyTasks(),
              const HomeActivityTimeline(),
              const HomeSmartNotifications(),
              const HomeHiringProbability(),
            ],
          ),
        ),
      ),
    );
  }
}
