import 'package:flutter/material.dart';

import 'package:jobnest/features/services/tools/resume_analyzer_screen.dart';
import 'package:jobnest/features/services/tools/interview_assistant_screen.dart';
import 'package:jobnest/features/services/tools/screening_setup_screen.dart';
import 'package:jobnest/features/services/tools/communication_hub_screen.dart';
import 'package:jobnest/features/services/tools/decision_support_screen.dart';
import 'package:jobnest/features/services/hrms/employee_management_screen.dart';
import 'package:jobnest/features/services/hrms/attendance_screen.dart';
import 'package:jobnest/features/services/hrms/task_manager_screen.dart';
import 'package:jobnest/features/services/crm/client_dashboard_screen.dart';
import 'package:jobnest/features/services/crm/client_management_screen.dart';
import 'package:jobnest/features/services/crm/crm_pipeline_screen.dart';
import 'package:jobnest/features/services/crm/communication_timeline_screen.dart';
import 'package:jobnest/features/services/crm/follow_ups_screen.dart';
import 'package:jobnest/features/services/productivity/workflow_automation_screen.dart';
import 'package:jobnest/features/services/productivity/reports_dashboard_screen.dart';
import 'package:jobnest/features/services/productivity/ai_insights_screen.dart';
import 'package:jobnest/features/services/productivity/activity_logs_screen.dart';
import 'package:jobnest/features/services/productivity/services_settings_screen.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Future me tools backend se load honge.
    // TODO: Tool permissions backend se manage hongi.
    final List<Map<String, dynamic>> services = [
      {
        "title": "Resume Analyzer",
        "desc": "Extract skills and rank via deep learning.",
        "icon": Icons.document_scanner_rounded,
        "color": Colors.deepPurpleAccent,
        "screen": const ResumeAnalyzerScreen(),
      },
      {
        "title": "Interview Assistant",
        "desc": "Real-time question generation.",
        "icon": Icons.forum_rounded,
        "color": Colors.blueAccent,
        "screen": const InterviewAssistantScreen(),
      },
      {
        "title": "Screening Setup",
        "desc": "Automated video screening tools.",
        "icon": Icons.video_camera_front_rounded,
        "color": Colors.green,
        "screen": const ScreeningSetupScreen(),
      },
      {
        "title": "Communication Hub",
        "desc": "Unified email & message portal.",
        "icon": Icons.email_rounded,
        "color": Colors.indigo,
        "screen": const CommunicationHubScreen(),
      },
      {
        "title": "Decision Support",
        "desc": "Compare candidates objectively.",
        "icon": Icons.balance_rounded,
        "color": Colors.orangeAccent,
        "screen": const DecisionSupportScreen(),
      },
      {
        "title": "Job Templates",
        "desc": "Pre-built JDs and email formats.",
        "icon": Icons.post_add_rounded,
        "color": Colors.teal,
      },
      {
        "title": "Employee Management",
        "desc": "Onboarding and lifecycle tracking.",
        "icon": Icons.manage_accounts_rounded,
        "color": Colors.redAccent,
        "screen": const EmployeeManagementScreen(),
      },
      {
        "title": "Attendance",
        "desc": "Time tracking & leave management.",
        "icon": Icons.access_time_filled_rounded,
        "color": Colors.pink,
        "screen": const AttendanceScreen(),
      },
      {
        "title": "Task Manager",
        "desc": "Internal recruiter to-do lists.",
        "icon": Icons.checklist_rounded,
        "color": Colors.amber,
        "screen": const TaskManagerScreen(),
      },
      {
        "title": "Client Dashboard",
        "desc": "Manage client relationships.",
        "icon": Icons.dashboard_customize_rounded,
        "color": Colors.cyan,
        "screen": const ClientDashboardScreen(),
      },
      {
        "title": "Client Management",
        "desc": "Track active client accounts.",
        "icon": Icons.business_rounded,
        "color": Colors.blueAccent,
        "screen": const ClientManagementScreen(),
      },
      {
        "title": "Hiring Pipeline",
        "desc": "Kanban board for open deals.",
        "icon": Icons.view_kanban_rounded,
        "color": Colors.purpleAccent,
        "screen": const CrmPipelineScreen(),
      },
      {
        "title": "Communications",
        "desc": "Timeline of client interactions.",
        "icon": Icons.forum_rounded,
        "color": Colors.indigo,
        "screen": const CommunicationTimelineScreen(),
      },
      {
        "title": "Follow Ups",
        "desc": "Recruiter tasks and to-dos.",
        "icon": Icons.task_alt_rounded,
        "color": Colors.teal,
        "screen": const FollowUpsScreen(),
      },
      {
        "title": "Custom Reports",
        "desc": "Export data to PDF/Excel.",
        "icon": Icons.summarize_rounded,
        "color": Colors.brown,
        "screen": const ReportsDashboardScreen(),
      },
      {
        "title": "Automation Engine",
        "desc": "Trigger-based email sequences.",
        "icon": Icons.auto_mode_rounded,
        "color": Colors.deepOrangeAccent,
        "screen": const WorkflowAutomationScreen(),
      },
      {
        "title": "AI Insights",
        "desc": "Predictive analytics and recommendations.",
        "icon": Icons.psychology_rounded,
        "color": Colors.amber,
        "screen": const AiInsightsScreen(),
      },
      {
        "title": "Activity Logs",
        "desc": "Audit trail of system events.",
        "icon": Icons.history_rounded,
        "color": Colors.blueGrey,
        "screen": const ActivityLogsScreen(),
      },
      {
        "title": "Settings",
        "desc": "Preferences and configurations.",
        "icon": Icons.settings_rounded,
        "color": Colors.grey,
        "screen": const ServicesSettingsScreen(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Services",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth >= 1000) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth >= 600) {
              crossAxisCount = 3;
            } else {
              crossAxisCount = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0, // Square cards
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return _buildServiceGridCard(
                  context,
                  title: service["title"],
                  description: service["desc"],
                  icon: service["icon"],
                  color: service["color"],
                  onTap: () {
                    if (service.containsKey("screen")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => service["screen"] as Widget),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceGridCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: theme.dividerColor,
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
