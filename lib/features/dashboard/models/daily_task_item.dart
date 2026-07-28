import 'package:flutter/material.dart';

class DailyTaskItem {
  final String id;
  final String title;
  final String priority;
  final String time;
  final bool isCompleted;

  const DailyTaskItem({
    required this.id,
    required this.title,
    required this.priority,
    required this.time,
    this.isCompleted = false,
  });

  Color get priorityColor {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.redAccent;
      case 'medium':
        return Colors.orangeAccent;
      case 'low':
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }

  DailyTaskItem copyWith({bool? isCompleted}) {
    return DailyTaskItem(
      id: id,
      title: title,
      priority: priority,
      time: time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static List<DailyTaskItem> getDefaultTasks() {
    return const [
      DailyTaskItem(
        id: '1',
        title: "Interview with Rahul Sharma",
        priority: "High",
        time: "10:30 AM",
        isCompleted: true,
      ),
      DailyTaskItem(
        id: '2',
        title: "Follow up with Priya Singh",
        priority: "Medium",
        time: "12:00 PM",
        isCompleted: false,
      ),
      DailyTaskItem(
        id: '3',
        title: "Send Offer Letter",
        priority: "High",
        time: "02:00 PM",
        isCompleted: true,
      ),
      DailyTaskItem(
        id: '4',
        title: "Review Java Candidates",
        priority: "Low",
        time: "04:30 PM",
        isCompleted: false,
      ),
    ];
  }
}
