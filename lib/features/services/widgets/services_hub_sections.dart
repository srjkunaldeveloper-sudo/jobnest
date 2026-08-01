import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/services/providers/services_data_provider.dart';
import 'package:jobnest/features/services/tools/resume_analyzer_screen.dart';
import 'package:jobnest/features/services/tools/interview_assistant_screen.dart';
import 'package:jobnest/features/services/tools/screening_setup_screen.dart';
import 'package:jobnest/features/services/tools/communication_hub_screen.dart';
import 'package:jobnest/features/services/tools/decision_support_screen.dart';
import 'package:jobnest/features/services/tools/ai_tools_dashboard_screen.dart';
import 'package:jobnest/features/services/hrms/employee_management_screen.dart';
import 'package:jobnest/features/services/hrms/attendance_screen.dart';
import 'package:jobnest/features/services/hrms/task_manager_screen.dart';
import 'package:jobnest/features/services/hrms/performance_dashboard_screen.dart';
import 'package:jobnest/features/services/crm/client_dashboard_screen.dart';
import 'package:jobnest/features/services/crm/client_management_screen.dart';
import 'package:jobnest/features/services/crm/crm_pipeline_screen.dart';
import 'package:jobnest/features/services/crm/communication_timeline_screen.dart';
import 'package:jobnest/features/services/crm/follow_ups_screen.dart';
import 'package:jobnest/features/services/productivity/workflow_automation_screen.dart';
import 'package:jobnest/features/services/productivity/reports_dashboard_screen.dart';
import 'package:jobnest/features/services/productivity/ai_insights_screen.dart';
import 'package:jobnest/features/services/productivity/activity_logs_screen.dart';

class ServicesSectionHeader extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onViewAll;

  const ServicesSectionHeader({
    super.key,
    required this.title,
    required this.description,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Semantics(
              label: "View all $title",
              button: true,
              child: TextButton(
                onPressed: onViewAll,
                style: TextButton.styleFrom(
                  minimumSize: const Size(48, 36),
                ),
                child: const Text("View All", style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _HubSubTile extends StatelessWidget {
  final String title;
  final String summary;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _HubSubTile({
    required this.title,
    required this.summary,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      summary,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                AppIcons.arrow_forward_ios_rounded,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobTemplatesPlaceholderScreen extends StatelessWidget {
  const JobTemplatesPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: AI APIs for dynamic template generation and SEO optimization.
    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        // backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Job & Email Templates Library"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(AppIcons.post_add_rounded, size: 64, color: theme.colorScheme.primary),
                const SizedBox(height: 24),
                Text(
                  "Enterprise Template Library",
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "Access 500+ pre-built SEO-optimized Job Descriptions, email sequences, and offer letter formats.\nFull dynamic editing and AI generation will be available in Phase P2.",
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(AppIcons.arrow_back_rounded, size: 18),
                  label: const Text("Return to Services Hub"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 1. AI TOOLS SECTION (SHORTCUTS ONLY)
// ============================================================================
class ServicesAiToolsSection extends StatelessWidget {
  const ServicesAiToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // AI APIs.

    final shortcuts = [
      (
        "Resume Analyzer",
        "AI Candidate Ranking",
        AppIcons.document_scanner_rounded,
        Colors.deepPurpleAccent,
        const ResumeAnalyzerScreen(),
      ),
      (
        "Interview Assistant",
        "Live Q&A & Scoring",
        AppIcons.forum_rounded,
        Colors.blueAccent,
        const InterviewAssistantScreen(),
      ),
      (
        "Screening Setup",
        "One-Way Video Setup",
        AppIcons.video_camera_front_rounded,
        Colors.green,
        const ScreeningSetupScreen(),
      ),
      (
        "Communication Hub",
        "Unified Messaging",
        AppIcons.email_rounded,
        Colors.indigo,
        const CommunicationHubScreen(),
      ),
      (
        "Decision Support",
        "Comparative Metric Scorecards",
        AppIcons.balance_rounded,
        Colors.orangeAccent,
        const DecisionSupportScreen(),
      ),
      (
        "Templates",
        "500+ SEO Templates",
        AppIcons.post_add_rounded,
        Colors.teal,
        const JobTemplatesPlaceholderScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicesSectionHeader(
          title: "AI Tools",
          description: "Automated shortcuts for intelligence-driven applicant ranking, live interviewing, and decision support.",
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AiToolsDashboardScreen()),
            );
          },
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int columns = constraints.maxWidth >= 900 ? 3 : (constraints.maxWidth >= 550 ? 2 : 1);
            double itemWidth = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: shortcuts.map((item) {
                return SizedBox(
                  width: itemWidth,
                  child: _HubSubTile(
                    title: item.$1,
                    summary: item.$2,
                    icon: item.$3,
                    color: item.$4,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item.$5),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================================
// 2. HRMS SECTION (OVERVIEW CARD WITH DUMMY COUNTS)
// ============================================================================
class ServicesHrmsSection extends StatelessWidget {
  const ServicesHrmsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<ServicesDataProvider>();

    // TODO:
    // HRMS APIs.

    final items = [
      (
        "Employee Management",
        "248 Active",
        AppIcons.people_alt_rounded,
        Colors.redAccent,
        const EmployeeManagementScreen(),
      ),
      (
        "Attendance",
        "98.4% On-time",
        AppIcons.access_time_filled_rounded,
        Colors.pink,
        const AttendanceScreen(),
      ),
      (
        "Task Management",
        "14 Pending",
        AppIcons.checklist_rounded,
        Colors.amber.shade800,
        const TaskManagerScreen(),
      ),
      (
        "Performance",
        "Q3 Reviews Open",
        AppIcons.trending_up_rounded,
        Colors.teal,
        const PerformanceDashboardScreen(),
      ),
      (
        "Reports",
        "12 Monthly Reports",
        AppIcons.analytics_rounded,
        Colors.indigo,
        const ReportsDashboardScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicesSectionHeader(
          title: "HRMS",
          description: "Centralized human resource management for attendance, onboarding, and recruiter task workflows.",
          onViewAll: () => provider.setSelectedCategory("HRMS"),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(AppIcons.manage_accounts_rounded, color: theme.colorScheme.primary, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Enterprise HRMS Portal",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth >= 900 ? 3 : (constraints.maxWidth >= 550 ? 2 : 1);
                  double itemWidth = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: items.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        child: _HubSubTile(
                          title: item.$1,
                          summary: item.$2,
                          icon: item.$3,
                          color: item.$4,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => item.$5),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 3. CRM SECTION (OVERVIEW CARD WITH DUMMY COUNTS)
// ============================================================================
class ServicesCrmSection extends StatelessWidget {
  const ServicesCrmSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<ServicesDataProvider>();

    // TODO:
    // CRM APIs.

    final items = [
      (
        "Candidates",
        "1,420 In Pool",
        AppIcons.person_search_rounded,
        Colors.blueAccent,
        const ClientDashboardScreen(),
      ),
      (
        "Clients",
        "38 Accounts",
        AppIcons.business_rounded,
        Colors.cyan.shade700,
        const ClientManagementScreen(),
      ),
      (
        "Pipeline",
        "24 Open Deals",
        AppIcons.view_kanban_rounded,
        Colors.purpleAccent.shade700,
        const CrmPipelineScreen(),
      ),
      (
        "Communication",
        "84 Unread",
        AppIcons.forum_rounded,
        Colors.indigo,
        const CommunicationTimelineScreen(),
      ),
      (
        "Requirements",
        "16 Active Reqs",
        AppIcons.assignment_rounded,
        Colors.orange,
        const FollowUpsScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicesSectionHeader(
          title: "CRM",
          description: "Manage corporate client accounts, hiring pipelines, and stakeholder communications in real-time.",
          onViewAll: () => provider.setSelectedCategory("CRM"),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(AppIcons.handshake_rounded, color: theme.colorScheme.primary, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Recruitment CRM & Pipeline",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth >= 900 ? 3 : (constraints.maxWidth >= 550 ? 2 : 1);
                  double itemWidth = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: items.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        child: _HubSubTile(
                          title: item.$1,
                          summary: item.$2,
                          icon: item.$3,
                          color: item.$4,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => item.$5),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 4. AUTOMATION SECTION (OVERVIEW CARD)
// ============================================================================
class ServicesAutomationSection extends StatelessWidget {
  const ServicesAutomationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<ServicesDataProvider>();

    // TODO:
    // Automation Engine.

    final items = [
      (
        "AI Recommendations",
        "6 Suggestions",
        AppIcons.auto_awesome_rounded,
        Colors.amber.shade800,
        const AiInsightsScreen(),
      ),
      (
        "Alerts",
        "3 Critical",
        AppIcons.notifications_active_rounded,
        Colors.redAccent,
        const WorkflowAutomationScreen(),
      ),
      (
        "Automation Rules",
        "12 Active Rules",
        AppIcons.rule_rounded,
        Colors.deepOrangeAccent,
        const WorkflowAutomationScreen(),
      ),
      (
        "Weekly Reports",
        "Generated Mon",
        AppIcons.calendar_today_rounded,
        Colors.teal,
        const ReportsDashboardScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicesSectionHeader(
          title: "Automation",
          description: "No-code trigger rules, automated rejection emails, and AI recommended follow-up alerts.",
          onViewAll: () => provider.setSelectedCategory("Automation"),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(AppIcons.auto_mode_rounded, color: theme.colorScheme.primary, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Workflow Automation Engine",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth >= 900 ? 2 : (constraints.maxWidth >= 550 ? 2 : 1);
                  double itemWidth = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: items.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        child: _HubSubTile(
                          title: item.$1,
                          summary: item.$2,
                          icon: item.$3,
                          color: item.$4,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => item.$5),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 5. REPORTS & INSIGHTS SECTION (OVERVIEW CARD WITH DUMMY COUNTS)
// ============================================================================
class ServicesReportsSection extends StatelessWidget {
  const ServicesReportsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<ServicesDataProvider>();

    // TODO:
    // Reports APIs.

    final items = [
      (
        "AI Reports",
        "4 Reports",
        AppIcons.psychology_rounded,
        Colors.deepPurpleAccent,
        const AiInsightsScreen(),
      ),
      (
        "HRMS Reports",
        "8 Reports",
        AppIcons.people_outline_rounded,
        Colors.pink,
        const ReportsDashboardScreen(),
      ),
      (
        "CRM Reports",
        "6 Reports",
        AppIcons.bar_chart_rounded,
        Colors.blueAccent,
        const ClientDashboardScreen(),
      ),
      (
        "Usage Analytics",
        "99.8% Uptime",
        AppIcons.data_usage_rounded,
        Colors.green,
        const ActivityLogsScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicesSectionHeader(
          title: "Reports & Insights",
          description: "Comprehensive business intelligence, usage analytics, and presentation-ready recruitment exports.",
          onViewAll: () => provider.setSelectedCategory("Reports"),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(AppIcons.summarize_rounded, color: theme.colorScheme.primary, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Enterprise Analytics Hub",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth >= 900 ? 2 : (constraints.maxWidth >= 550 ? 2 : 1);
                  double itemWidth = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: items.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        child: _HubSubTile(
                          title: item.$1,
                          summary: item.$2,
                          icon: item.$3,
                          color: item.$4,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => item.$5),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
