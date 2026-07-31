import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

enum NotificationType {
  jobPosted,
  newApplicationReceived,
  candidateShortlisted,
  interviewScheduled,
  interviewReminder,
  interviewCancelled,
  offerSent,
  offerAccepted,
  offerRejected,
  aiRecommendation,
  resumeProcessed,
  systemAnnouncement,
  profileUpdated,
  subscriptionReminder,
}

enum NotificationPriority {
  high,
  medium,
  low,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final String time;
  final String section; // "Today", "Yesterday", "Earlier"
  final NotificationPriority priority;
  final String? optionalCta;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    required this.section,
    required this.priority,
    this.optionalCta,
    this.isRead = false,
  });

  NotificationItem copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? description,
    String? time,
    String? section,
    NotificationPriority? priority,
    String? optionalCta,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      section: section ?? this.section,
      priority: priority ?? this.priority,
      optionalCta: optionalCta ?? this.optionalCta,
      isRead: isRead ?? this.isRead,
    );
  }

  // Map notification type to filter category
  String get category {
    switch (type) {
      case NotificationType.jobPosted:
        return "Jobs";
      case NotificationType.newApplicationReceived:
      case NotificationType.candidateShortlisted:
      case NotificationType.offerSent:
      case NotificationType.offerAccepted:
      case NotificationType.offerRejected:
      case NotificationType.resumeProcessed:
        return "Candidates";
      case NotificationType.interviewScheduled:
      case NotificationType.interviewReminder:
      case NotificationType.interviewCancelled:
        return "Interviews";
      case NotificationType.aiRecommendation:
        return "AI";
      case NotificationType.systemAnnouncement:
      case NotificationType.profileUpdated:
      case NotificationType.subscriptionReminder:
        return "System";
    }
  }

  // Helper for UI styling
  IconData get icon {
    switch (type) {
      case NotificationType.jobPosted:
        return AppIcons.work_outline_rounded;
      case NotificationType.newApplicationReceived:
        return AppIcons.person_add_alt_1_rounded;
      case NotificationType.candidateShortlisted:
        return AppIcons.star_rounded;
      case NotificationType.interviewScheduled:
      case NotificationType.interviewReminder:
        return AppIcons.calendar_today_rounded;
      case NotificationType.interviewCancelled:
        return AppIcons.event_busy_rounded;
      case NotificationType.offerSent:
        return AppIcons.send_rounded;
      case NotificationType.offerAccepted:
        return AppIcons.check_circle_outline_rounded;
      case NotificationType.offerRejected:
        return AppIcons.cancel_outlined;
      case NotificationType.aiRecommendation:
        return AppIcons.auto_awesome_rounded;
      case NotificationType.resumeProcessed:
        return AppIcons.description_outlined;
      case NotificationType.systemAnnouncement:
        return AppIcons.campaign_outlined;
      case NotificationType.profileUpdated:
        return AppIcons.manage_accounts_outlined;
      case NotificationType.subscriptionReminder:
        return AppIcons.payment_rounded;
    }
  }

  Color get iconColor {
    switch (type) {
      case NotificationType.jobPosted:
        return Colors.blue;
      case NotificationType.newApplicationReceived:
        return Colors.teal;
      case NotificationType.candidateShortlisted:
        return Colors.amber.shade700;
      case NotificationType.interviewScheduled:
      case NotificationType.interviewReminder:
        return Colors.purple;
      case NotificationType.interviewCancelled:
        return Colors.red;
      case NotificationType.offerSent:
        return Colors.indigo;
      case NotificationType.offerAccepted:
        return Colors.green;
      case NotificationType.offerRejected:
        return Colors.deepOrange;
      case NotificationType.aiRecommendation:
        return Colors.deepPurpleAccent;
      case NotificationType.resumeProcessed:
        return Colors.cyan.shade700;
      case NotificationType.systemAnnouncement:
        return Colors.blueGrey;
      case NotificationType.profileUpdated:
        return Colors.brown;
      case NotificationType.subscriptionReminder:
        return Colors.orange.shade800;
    }
  }

  static List<NotificationItem> getDummyNotifications() {
    return [
      // --- TODAY ---
      NotificationItem(
        id: "notif_1",
        type: NotificationType.aiRecommendation,
        title: "AI Talent Match Found",
        description: "JobNest AI shortlisted 3 top-tier candidates for Senior Flutter Developer (94% match score).",
        time: "10m ago",
        section: "Today",
        priority: NotificationPriority.high,
        optionalCta: "View Candidate",
        isRead: false,
      ),
      NotificationItem(
        id: "notif_2",
        type: NotificationType.newApplicationReceived,
        title: "New Application Received",
        description: "Rahul Sharma applied for the Lead Technical Architect position in Bangalore.",
        time: "45m ago",
        section: "Today",
        priority: NotificationPriority.medium,
        optionalCta: "View Candidate",
        isRead: false,
      ),
      NotificationItem(
        id: "notif_3",
        type: NotificationType.interviewReminder,
        title: "Interview Reminder",
        description: "Technical Round 2 with Priya Singh starts in 15 minutes via Zoom Integration.",
        time: "1h ago",
        section: "Today",
        priority: NotificationPriority.high,
        optionalCta: "View Interview",
        isRead: false,
      ),
      NotificationItem(
        id: "notif_4",
        type: NotificationType.resumeProcessed,
        title: "Bulk Resumes Processed",
        description: "Auto-screening completed for 24 candidate resumes uploaded to the Python Engineer pipeline.",
        time: "3h ago",
        section: "Today",
        priority: NotificationPriority.low,
        isRead: true,
      ),
      NotificationItem(
        id: "notif_5",
        type: NotificationType.offerAccepted,
        title: "Offer Accepted! 🎉",
        description: "Vikram Mehta accepted the offer letter for Senior Product Designer. Joining date: Aug 15.",
        time: "5h ago",
        section: "Today",
        priority: NotificationPriority.high,
        optionalCta: "View Candidate",
        isRead: false,
      ),

      // --- YESTERDAY ---
      NotificationItem(
        id: "notif_6",
        type: NotificationType.candidateShortlisted,
        title: "Candidate Shortlisted by Hiring Manager",
        description: "Ananya Iyer was marked as 'Strong Yes' by tech lead during peer review.",
        time: "Yesterday, 4:15 PM",
        section: "Yesterday",
        priority: NotificationPriority.medium,
        optionalCta: "View Candidate",
        isRead: true,
      ),
      NotificationItem(
        id: "notif_7",
        type: NotificationType.jobPosted,
        title: "Job Posted Successfully",
        description: "Your requisition 'DevOps Engineer (AWS/Kubernetes)' is now live across LinkedIn & Indeed.",
        time: "Yesterday, 2:30 PM",
        section: "Yesterday",
        priority: NotificationPriority.medium,
        optionalCta: "View Job",
        isRead: true,
      ),
      NotificationItem(
        id: "notif_8",
        type: NotificationType.interviewScheduled,
        title: "Interview Scheduled",
        description: "HR screening scheduled with Amit Patel for tomorrow at 11:30 AM IST.",
        time: "Yesterday, 11:00 AM",
        section: "Yesterday",
        priority: NotificationPriority.medium,
        optionalCta: "View Interview",
        isRead: true,
      ),
      NotificationItem(
        id: "notif_9",
        type: NotificationType.offerSent,
        title: "Offer Sent for Signature",
        description: "Formal offer packet emailed to Sneha Reddy with 48-hour expiration timeline.",
        time: "Yesterday, 9:20 AM",
        section: "Yesterday",
        priority: NotificationPriority.high,
        optionalCta: "View Candidate",
        isRead: true,
      ),

      // --- EARLIER ---
      NotificationItem(
        id: "notif_10",
        type: NotificationType.interviewCancelled,
        title: "Interview Rescheduled/Cancelled",
        description: "Candidate Rohan Gupta requested to reschedule tomorrow's system design interview.",
        time: "3 days ago",
        section: "Earlier",
        priority: NotificationPriority.high,
        optionalCta: "View Interview",
        isRead: true,
      ),
      NotificationItem(
        id: "notif_11",
        type: NotificationType.offerRejected,
        title: "Offer Declined",
        description: "Candidate declined offer due to compensation mismatch. Feedback logged in ATS.",
        time: "4 days ago",
        section: "Earlier",
        priority: NotificationPriority.high,
        isRead: true,
      ),
      NotificationItem(
        id: "notif_12",
        type: NotificationType.systemAnnouncement,
        title: "New ATS Integration Available",
        description: "JobNest now supports 1-click candidate sync with Greenhouse and Lever enterprise suites.",
        time: "5 days ago",
        section: "Earlier",
        priority: NotificationPriority.low,
        isRead: true,
      ),
      NotificationItem(
        id: "notif_13",
        type: NotificationType.profileUpdated,
        title: "Company Profile Updated",
        description: "Organization branding and default email offer templates were modified by HR Admin.",
        time: "1 week ago",
        section: "Earlier",
        priority: NotificationPriority.low,
        isRead: true,
      ),
      NotificationItem(
        id: "notif_14",
        type: NotificationType.subscriptionReminder,
        title: "Enterprise Subscription Notice",
        description: "Your JobNest Enterprise billing cycle renews in 14 days. 12 active recruiter seats included.",
        time: "2 weeks ago",
        section: "Earlier",
        priority: NotificationPriority.medium,
        isRead: true,
      ),
    ];
  }
}
