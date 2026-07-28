import 'package:flutter/material.dart';

enum DashboardAction {
  createJob,
  viewCandidates,
  scheduleInterview,
  messages,
  analytics,
  settings,
}

class DashboardQuickAction {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool enabled;
  final DashboardAction action;
  final String colorName;

  const DashboardQuickAction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.enabled = true,
    required this.action,
    required this.colorName,
  });

  Color get color {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'teal':
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }

  static List<DashboardQuickAction> getDefaultActions() {
    return const [
      DashboardQuickAction(
        id: '1',
        title: "Create Job",
        subtitle: "Draft a new posting",
        icon: Icons.add_business_rounded,
        enabled: true,
        action: DashboardAction.createJob,
        colorName: "blue",
      ),
      DashboardQuickAction(
        id: '2',
        title: "View Candidates",
        subtitle: "Review applicants",
        icon: Icons.groups_rounded,
        enabled: true,
        action: DashboardAction.viewCandidates,
        colorName: "orange",
      ),
      DashboardQuickAction(
        id: '3',
        title: "Schedule Interview",
        subtitle: "Set up meetings",
        icon: Icons.edit_calendar_rounded,
        enabled: true,
        action: DashboardAction.scheduleInterview,
        colorName: "purple",
      ),
      DashboardQuickAction(
        id: '4',
        title: "Messages",
        subtitle: "Chat with candidates",
        icon: Icons.chat_rounded,
        enabled: true,
        action: DashboardAction.messages,
        colorName: "teal",
      ),
    ];
  }
}
