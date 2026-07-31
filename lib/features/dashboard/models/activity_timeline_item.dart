import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

class ActivityTimelineItem {
  final String id;
  final String title;
  final String subtitle;
  final String timestamp;
  final IconData icon;
  final String type;

  const ActivityTimelineItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.icon,
    required this.type,
  });

  Color get iconColor {
    switch (type.toLowerCase()) {
      case 'application':
        return Colors.blueAccent;
      case 'interview':
        return Colors.purpleAccent;
      case 'job':
        return Colors.orangeAccent;
      case 'selection':
        return Colors.teal;
      case 'offer':
        return Colors.green;
      default:
        return Colors.blueAccent;
    }
  }

  static List<ActivityTimelineItem> getDefaultItems() {
    return const [
      ActivityTimelineItem(
        id: '1',
        title: "Candidate Applied",
        subtitle: "Aarav Sharma applied for Backend Engineer",
        timestamp: "2 minutes ago",
        icon: AppIcons.person_add_rounded,
        type: 'application',
      ),
      ActivityTimelineItem(
        id: '2',
        title: "Interview Scheduled",
        subtitle: "Technical round for UI/UX",
        timestamp: "15 minutes ago",
        icon: AppIcons.calendar_month_rounded,
        type: 'interview',
      ),
      ActivityTimelineItem(
        id: '3',
        title: "Job Posted",
        subtitle: "Senior Flutter Developer",
        timestamp: "1 hour ago",
        icon: AppIcons.work_rounded,
        type: 'job',
      ),
      ActivityTimelineItem(
        id: '4',
        title: "Candidate Selected",
        subtitle: "Priya Singh for Data Scientist",
        timestamp: "Yesterday",
        icon: AppIcons.verified_rounded,
        type: 'selection',
      ),
      ActivityTimelineItem(
        id: '5',
        title: "Offer Letter Sent",
        subtitle: "Offer letter generated for Priya Singh",
        timestamp: "Yesterday",
        icon: AppIcons.mail_rounded,
        type: 'offer',
      ),
    ];
  }
}
