import 'package:flutter/material.dart';
import 'package:jobnest/features/services/models/service_item.dart';
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

class ServicesDataProvider extends ChangeNotifier {
  static final ServicesDataProvider _instance = ServicesDataProvider._internal();
  factory ServicesDataProvider() => _instance;
  
  ServicesDataProvider._internal() {
    _initDefaultServices();
  }

  // ===== BACKEND TODO COMMENTS =====
  // TODO:
  // Services API integration.

  // TODO:
  // Dynamic service availability.

  // TODO:
  // Favorites backend sync.

  // TODO:
  // Service analytics.

  final List<ServiceItem> _services = [];
  String _searchQuery = "";
  String _selectedCategory = "All";
  bool _isLoading = false;
  bool _isError = false;

  final List<String> categories = [
    "All",
    "Favorites",
    "Recruitment",
    "AI Tools",
    "HRMS",
    "CRM",
    "Automation",
    "Reports",
    "Communication",
    "Productivity",
    "Recently Used",
  ];

  List<ServiceItem> get services => List.unmodifiable(_services);
  List<ServiceItem> get featuredServices => _services.where((s) => s.isFeatured).toList();
  List<ServiceItem> get recentServices => _services.where((s) => s.isRecent).toList();
  
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  List<ServiceItem> get filteredServices {
    return _services.where((item) {
      // 1. Search Query Filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase().trim();
        final matchTitle = item.title.toLowerCase().contains(query);
        final matchDesc = item.description.toLowerCase().contains(query);
        final matchCat = item.categories.any((c) => c.toLowerCase().contains(query));
        if (!matchTitle && !matchDesc && !matchCat) {
          return false;
        }
      }

      // 2. Category Filter
      if (_selectedCategory == "All") {
        return true;
      } else if (_selectedCategory == "Favorites") {
        return item.isFavorite;
      } else if (_selectedCategory == "Recently Used") {
        return item.isRecent;
      } else {
        return item.categories.contains(_selectedCategory);
      }
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearchQuery() {
    _searchQuery = "";
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final idx = _services.indexWhere((s) => s.id == id);
    if (idx != -1) {
      _services[idx] = _services[idx].copyWith(isFavorite: !_services[idx].isFavorite);
      notifyListeners();
    }
  }

  void markAsLaunched(String id) {
    final idx = _services.indexWhere((s) => s.id == id);
    if (idx != -1) {
      _services[idx] = _services[idx].copyWith(
        isRecent: true,
        lastUsedTime: "Just now",
      );
      notifyListeners();
    }
  }

  Future<void> refreshServices() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    _isLoading = false;
    _initDefaultServices(preserveFavorites: true);
    notifyListeners();
  }

  void simulateLoading() {
    _isLoading = true;
    _isError = false;
    notifyListeners();
  }

  void simulateError() {
    _isLoading = false;
    _isError = true;
    notifyListeners();
  }

  void simulateEmpty() {
    _isLoading = false;
    _isError = false;
    _services.clear();
    notifyListeners();
  }

  void restoreDefaults() {
    _isLoading = false;
    _isError = false;
    _searchQuery = "";
    _selectedCategory = "All";
    _initDefaultServices(preserveFavorites: false);
    notifyListeners();
  }

  void _initDefaultServices({bool preserveFavorites = false}) {
    final Set<String> existingFavorites = {};
    if (preserveFavorites) {
      for (final s in _services) {
        if (s.isFavorite) existingFavorites.add(s.id);
      }
    }

    _services.clear();
    final defaultList = [
      ServiceItem(
        id: "srv_resume_analyzer",
        title: "Resume Analyzer AI",
        description: "Automatically extract skills and rank candidates based on deep learning matching.",
        icon: Icons.document_scanner_rounded,
        color: Colors.deepPurpleAccent,
        categories: ["AI Tools", "Recruitment"],
        benefits: [
          "Rank top applicants automatically using deep learning matching algorithms",
          "Extract technical skills, certifications, and career experience in seconds",
          "Eliminate manual resume screening bias and save 10+ hours weekly",
        ],
        isAvailable: true,
        isNew: true,
        isFeatured: true,
        isFavorite: existingFavorites.contains("srv_resume_analyzer"),
        screen: const ResumeAnalyzerScreen(),
      ),
      ServiceItem(
        id: "srv_interview_assistant",
        title: "Interview Assistant",
        description: "Real-time question generation and post-interview candidate competency scoring.",
        icon: Icons.forum_rounded,
        color: Colors.blueAccent,
        categories: ["AI Tools", "Recruitment", "Communication"],
        benefits: [
          "Generate tailored technical and behavioral questions in real-time during live interviews",
          "Receive automated candidate competency and communication scoring post-interview",
          "Integrate seamlessly with Zoom, Microsoft Teams, and Google Meet scheduling",
        ],
        isAvailable: true,
        isFeatured: true,
        isRecent: true,
        lastUsedTime: "2 hours ago",
        isFavorite: existingFavorites.contains("srv_interview_assistant") || !preserveFavorites, // Default 1 favorite for demo
        screen: const InterviewAssistantScreen(),
      ),
      ServiceItem(
        id: "srv_screening_setup",
        title: "Screening Setup",
        description: "Automate asynchronous one-way video screening workflows for high-volume roles.",
        icon: Icons.video_camera_front_rounded,
        color: Colors.green,
        categories: ["Recruitment", "Automation"],
        benefits: [
          "Automate asynchronous one-way video interviews for preliminary candidate qualification",
          "Customize pre-screening video questionnaires for any specialized job requisition",
          "Auto-grade applicant responses with AI speech-to-text keyword analysis",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_screening_setup"),
        screen: const ScreeningSetupScreen(),
      ),
      ServiceItem(
        id: "srv_communication_hub",
        title: "Communication Hub",
        description: "Unified enterprise portal for candidate email threads, SMS, and WhatsApp messaging.",
        icon: Icons.email_rounded,
        color: Colors.indigo,
        categories: ["Communication", "CRM"],
        benefits: [
          "Unified inbox for email, SMS, and WhatsApp candidate outreach campaigns",
          "Track message open rates, link clicks, and candidate response timestamps",
          "Sync communication history automatically with candidate ATS profiles",
        ],
        isAvailable: true,
        isRecent: true,
        lastUsedTime: "Yesterday",
        isFavorite: existingFavorites.contains("srv_communication_hub"),
        screen: const CommunicationHubScreen(),
      ),
      ServiceItem(
        id: "srv_decision_support",
        title: "Decision Support",
        description: "Compare shortlisted candidates side-by-side with objective AI hiring metrics.",
        icon: Icons.balance_rounded,
        color: Colors.orangeAccent,
        categories: ["AI Tools", "Recruitment", "Reports"],
        benefits: [
          "Side-by-side comparative candidate scorecard evaluation across technical competencies",
          "Objective AI bias-free recommendation engines for hiring managers and recruiters",
          "Export detailed hiring justification reports and audit trails in 1-click",
        ],
        isAvailable: true,
        isNew: true,
        isFeatured: true,
        isFavorite: existingFavorites.contains("srv_decision_support"),
        screen: const DecisionSupportScreen(),
      ),
      ServiceItem(
        id: "srv_job_templates",
        title: "Job Templates",
        description: "Access 500+ pre-built SEO-optimized Job Descriptions and email sequence formats.",
        icon: Icons.post_add_rounded,
        color: Colors.teal,
        categories: ["Recruitment", "Templates"],
        benefits: [
          "Access 500+ SEO-optimized Job Description templates across all technology domains",
          "Pre-built email sequences for offer letters, interview invitations, and rejections",
          "Customize company branding and legal compliance boilerplate dynamically",
        ],
        isAvailable: false, // Coming Soon
        isRecent: true,
        lastUsedTime: "3 days ago",
        isFavorite: existingFavorites.contains("srv_job_templates"),
      ),
      ServiceItem(
        id: "srv_employee_mgmt",
        title: "Employee Management",
        description: "Seamless onboarding workflows and lifecycle tracking for newly hired talent.",
        icon: Icons.manage_accounts_rounded,
        color: Colors.redAccent,
        categories: ["HRMS", "Productivity"],
        benefits: [
          "Digital onboarding workflows and document verification for newly hired candidates",
          "Centralized employee records, equipment assignment, and asset tracking",
          "Automate 30-60-90 day performance review scheduling and probationary evaluations",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_employee_mgmt"),
        screen: const EmployeeManagementScreen(),
      ),
      ServiceItem(
        id: "srv_attendance",
        title: "Attendance Tracker",
        description: "Real-time time tracking, biometric integration, and leave management system.",
        icon: Icons.access_time_filled_rounded,
        color: Colors.pink,
        categories: ["HRMS", "Productivity"],
        benefits: [
          "Real-time attendance tracking with biometric integration and web clock-in capabilities",
          "Automated leave request workflows, holiday calendars, and manager approvals",
          "Export payroll-ready timesheets with overtime and shift differential calculations",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_attendance"),
        screen: const AttendanceScreen(),
      ),
      ServiceItem(
        id: "srv_task_manager",
        title: "Recruiter Task Manager",
        description: "Internal recruiter to-do lists, priority alerts, and collaborative hiring workflows.",
        icon: Icons.checklist_rounded,
        color: Colors.amber.shade800,
        categories: ["Productivity", "HRMS"],
        benefits: [
          "Daily recruiter priority task lists, SLA countdowns, and deadline notifications",
          "Collaborative hiring team task delegation, mentions, and progress tracking",
          "Kanban view for operational recruitment workflows and requisition roadblocks",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_task_manager"),
        screen: const TaskManagerScreen(),
      ),
      ServiceItem(
        id: "srv_client_dashboard",
        title: "Client Dashboard",
        description: "Holistic overview of active client accounts, revenue pipelines, and hiring SLAs.",
        icon: Icons.dashboard_customize_rounded,
        color: Colors.cyan.shade700,
        categories: ["CRM", "Reports"],
        benefits: [
          "Holistic overview of active client accounts, revenue pipelines, and billing milestones",
          "Track SLA compliance, time-to-fill targets, and candidate submission acceptance rates",
          "Share branded interactive client portals for real-time candidate resume review",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_client_dashboard"),
        screen: const ClientDashboardScreen(),
      ),
      ServiceItem(
        id: "srv_client_mgmt",
        title: "Client Management",
        description: "Complete database of client accounts, contracts, terms, and hiring manager notes.",
        icon: Icons.business_rounded,
        color: Colors.blueAccent,
        categories: ["CRM"],
        benefits: [
          "Complete database of corporate client accounts, MSA contracts, and billing terms",
          "Log meetings, call transcripts, and hiring manager cultural preferences",
          "Set automated account review reminders and contract renewal notifications",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_client_mgmt"),
        screen: const ClientManagementScreen(),
      ),
      ServiceItem(
        id: "srv_hiring_pipeline",
        title: "Hiring Pipeline CRM",
        description: "Visual Kanban board for tracking open deals, client requisitions, and submissions.",
        icon: Icons.view_kanban_rounded,
        color: Colors.purpleAccent.shade700,
        categories: ["CRM", "Recruitment"],
        benefits: [
          "Visual Kanban drag-and-drop pipeline for open job requisitions and client deals",
          "Identify bottleneck stages in your recruitment funnel with conversion analytics",
          "Automate stage transition notifications to clients, hiring managers, and candidates",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_hiring_pipeline"),
        screen: const CrmPipelineScreen(),
      ),
      ServiceItem(
        id: "srv_communications",
        title: "Client Communications",
        description: "Timeline audit trail of all client interactions, emails, calls, and meeting notes.",
        icon: Icons.forum_rounded,
        color: Colors.indigo,
        categories: ["CRM", "Communication"],
        benefits: [
          "Complete timeline audit trail of all corporate client and stakeholder interactions",
          "Log phone calls, email threads, and executive meeting notes in a single repository",
          "Never lose account context when transitioning requisitions between recruiters",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_communications"),
        screen: const CommunicationTimelineScreen(),
      ),
      ServiceItem(
        id: "srv_follow_ups",
        title: "Automated Follow Ups",
        description: "Smart automated reminders for pending candidate feedback and recruiter to-dos.",
        icon: Icons.task_alt_rounded,
        color: Colors.teal,
        categories: ["CRM", "Productivity"],
        benefits: [
          "Smart automated reminders for pending candidate interview feedback from managers",
          "Schedule automated nurture drip sequences with passive high-value talent pools",
          "Daily digest of overdue client deliverables and candidate touchpoints",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_follow_ups"),
        screen: const FollowUpsScreen(),
      ),
      ServiceItem(
        id: "srv_custom_reports",
        title: "Custom Reports & BI",
        description: "Export presentation-ready recruitment analytics to PDF, Excel, and CSV formats.",
        icon: Icons.summarize_rounded,
        color: Colors.brown,
        categories: ["Reports", "Productivity"],
        benefits: [
          "Generate presentation-ready recruitment analytics and executive summaries in seconds",
          "Export custom filtered datasets to PDF, Excel (XLSX), or CSV formats with 1-click",
          "Schedule automated weekly performance reports delivered directly to stakeholder inboxes",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_custom_reports"),
        screen: const ReportsDashboardScreen(),
      ),
      ServiceItem(
        id: "srv_automation_engine",
        title: "Automation Engine",
        description: "Build trigger-based workflow rules and email sequences without writing code.",
        icon: Icons.auto_mode_rounded,
        color: Colors.deepOrangeAccent,
        categories: ["Automation", "Productivity", "AI Tools"],
        benefits: [
          "Build intuitive trigger-based workflow rules and conditional actions without writing code",
          "Auto-send polite rejection emails when job requisitions are officially closed",
          "Automatically transition candidates to technical screening when assessments are passed",
        ],
        isAvailable: true,
        isNew: true,
        isFavorite: existingFavorites.contains("srv_automation_engine"),
        screen: const WorkflowAutomationScreen(),
      ),
      ServiceItem(
        id: "srv_ai_insights",
        title: "AI Predictive Insights",
        description: "Predictive hiring analytics, talent supply forecasting, and salary benchmarking.",
        icon: Icons.psychology_rounded,
        color: Colors.amber.shade700,
        categories: ["AI Tools", "Reports"],
        benefits: [
          "Predictive hiring analytics, time-to-fill forecasting, and talent supply-demand heatmaps",
          "AI recommendations on compensation benchmarking and offer competitiveness by region",
          "Identify top-performing sourcing channels and measure quality of hire ROI",
        ],
        isAvailable: true,
        isNew: true,
        isFavorite: existingFavorites.contains("srv_ai_insights"),
        screen: const AiInsightsScreen(),
      ),
      ServiceItem(
        id: "srv_activity_logs",
        title: "Enterprise Activity Logs",
        description: "Comprehensive immutable audit trail of all system events and recruiter actions.",
        icon: Icons.history_rounded,
        color: Colors.blueGrey,
        categories: ["Reports", "Productivity"],
        benefits: [
          "Comprehensive enterprise audit trail of all user logins, actions, and system events",
          "Track candidate data exports, profile modifications, and security permission changes",
          "Maintain strict SOC2 and GDPR compliance with immutable timestamped event logging",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_activity_logs"),
        screen: const ActivityLogsScreen(),
      ),
      ServiceItem(
        id: "srv_settings",
        title: "Services & Tool Settings",
        description: "Configure notification channels, SMTP servers, ATS integrations, and permissions.",
        icon: Icons.settings_rounded,
        color: Colors.grey.shade700,
        categories: ["Productivity"],
        benefits: [
          "Configure notification channels, email SMTP gateways, and enterprise ATS API keys",
          "Manage user roles, recruiter access permissions, and departmental seat licenses",
          "Customize workflow stages, rejection reasons, and default company branding templates",
        ],
        isAvailable: true,
        isFavorite: existingFavorites.contains("srv_settings"),
        screen: const ServicesSettingsScreen(),
      ),
    ];

    _services.addAll(defaultList);
  }
}
