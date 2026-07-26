import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDataProvider extends ChangeNotifier {
  static final ProfileDataProvider _instance = ProfileDataProvider._internal();
  factory ProfileDataProvider() => _instance;

  ProfileDataProvider._internal() {
    _loadNotificationPreferences();
  }

  // ===== BACKEND TODO COMMENTS =====
  // TODO:
  // Fetch recruiter profile.

  // TODO:
  // Update profile API.

  // TODO:
  // Upload profile photo.

  // TODO:
  // Notification preferences API.

  // TODO:
  // Company profile sync.

  // Recruiter Profile State
  String fullName = "Sonu Surya";
  String designation = "Senior Tech Recruiter";
  String companyName = "TechNova Solutions";
  String email = "sonusurya@technova.com";
  String phone = "+91 98765 43210";
  String employeeId = "EMP-2024-8901";
  String department = "Human Resources";
  String role = "Senior Recruiter";
  String experience = "8+ Years";
  String location = "Bangalore, India";
  String joiningDate = "October 12, 2021";
  String bio = "";
  
  // Company Details State
  String industry = "Software & Technology";
  String companySize = "500 - 1000 Employees";
  String website = "https://technova.dev";
  String headquarters = "Koramangala, Bangalore";
  String foundedYear = "2015";
  String officialPhone = "+91 80 4123 4567";
  String officeAddress = "Plot 42, Cyber Park, Electronic City Phase 1";
  String city = "Bangalore";
  String state = "Karnataka";
  String country = "India";
  String companyPan = "AAACT1234K";
  String companyTan = "BLRT12345F";

  // Company Branding State
  String companyOverview = "TechNova Solutions is a global leader in AI-driven HR technology and enterprise workforce automation.";
  String companyDescription = "Founded in 2015, we empower Fortune 500 companies to streamline their talent acquisition pipelines, reduce hiring bias, and enhance recruiter productivity through intelligent matching algorithms.";
  String missionStatement = "To revolutionize global recruitment by connecting talent with opportunity through transparent, AI-empowered workflows.";
  String visionStatement = "To become the world's most trusted recruitment operating system by 2030.";
  String workCulture = "We thrive in a collaborative, remote-first environment where autonomy, continuous learning, and innovation are celebrated daily.";
  String companyValues = "1. Customer Obsession\n2. Radical Transparency\n3. Relentless Innovation\n4. Diversity & Inclusion";

  // Company Media Placeholders State
  bool isCompanyMediaEmpty = false;
  final List<Map<String, String>> defaultCompanyMedia = [
    {
      "title": "Company Logo",
      "subtitle": "High-Res Vector Brand Asset",
      "type": "logo",
      "badge": "Primary Logo",
    },
    {
      "title": "Recruitment Banner",
      "subtitle": "Cover Image for Candidate Portal",
      "type": "image",
      "badge": "Cover Image",
    },
    {
      "title": "Office Images",
      "subtitle": "Bangalore HQ & Collaborative Spaces",
      "type": "gallery",
      "badge": "12 Photos",
    },
    {
      "title": "Office Tour",
      "subtitle": "Inside TechNova Work Culture Video",
      "type": "video",
      "badge": "Video Tour",
    },
  ];

  // Profile Completeness
  int completenessPercentage = 85;
  List<String> missingItems = [
    "Company Logo",
    "Phone Number Verification",
    "Recruiter Bio",
  ];

  // Notification Switches State
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool interviewReminders = true;
  bool marketingUpdates = false;

  // QA Simulation States
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  // Team & Role Management State
  bool isTeamEmpty = false;
  String teamSearchQuery = "";
  String teamRoleFilter = "All"; // "All", "Admin", "HR Manager", "Recruiter", "Hiring Manager", "Viewer"

  List<TeamMemberItem> teamMembers = [
    TeamMemberItem(
      id: "1",
      name: "Sonu Surya",
      email: "sonusurya@technova.com",
      role: "Admin",
      status: "Active",
      permissions: getDefaultPermissionsForRole("Admin"),
    ),
    TeamMemberItem(
      id: "2",
      name: "Ananya Sharma",
      email: "ananya.s@technova.com",
      role: "HR Manager",
      status: "Active",
      permissions: getDefaultPermissionsForRole("HR Manager"),
    ),
    TeamMemberItem(
      id: "3",
      name: "Rahul Verma",
      email: "rahul.v@technova.com",
      role: "Recruiter",
      status: "Active",
      hasCustomPermissions: true,
      permissions: getDefaultPermissionsForRole("Recruiter").map((p) {
        if (p.category == "Jobs") {
          return p.copyWith(canDelete: false);
        }
        if (p.category == "Candidates") {
          return p.copyWith(canEdit: true);
        }
        return p;
      }).toList(),
    ),
    TeamMemberItem(
      id: "4",
      name: "Vikram Singhania",
      email: "vikram.s@technova.com",
      role: "Hiring Manager",
      status: "Active",
      permissions: getDefaultPermissionsForRole("Hiring Manager"),
    ),
    TeamMemberItem(
      id: "5",
      name: "Priya Patel",
      email: "priya.p@technova.com",
      role: "Viewer",
      status: "Invited",
      permissions: getDefaultPermissionsForRole("Viewer"),
    ),
  ];

  // Verification & Trust System State
  bool isVerificationEmpty = false;

  List<VerificationItem> verificationItems = [
    VerificationItem(
      id: "val_email",
      title: "Recruiter Email",
      type: "Recruiter",
      status: "Verified",
      description: "Official work email address verified via enterprise domain OTP.",
      lastUpdated: "2 days ago",
    ),
    VerificationItem(
      id: "val_phone",
      title: "Recruiter Phone",
      type: "Recruiter",
      status: "Verified",
      description: "Direct mobile contact verified via SMS authentication gateway.",
      lastUpdated: "5 days ago",
    ),
    VerificationItem(
      id: "val_comp_email",
      title: "Company Email",
      type: "Company",
      status: "Verified",
      description: "Corporate domain ownership verified via DNS TXT record matching.",
      lastUpdated: "1 week ago",
    ),
    VerificationItem(
      id: "val_comp_web",
      title: "Company Website",
      type: "Company",
      status: "Verified",
      description: "Official website domain verified via SSL handshake & site meta tag.",
      lastUpdated: "1 week ago",
    ),
    VerificationItem(
      id: "val_comp_reg",
      title: "Company Registration",
      type: "Company",
      status: "Verified",
      description: "Certificate of Incorporation cross-referenced with business registry.",
      lastUpdated: "2 weeks ago",
    ),
    VerificationItem(
      id: "val_comp_pan",
      title: "Company PAN",
      type: "Company",
      status: "Verified",
      description: "Permanent Account Number validated against national tax records.",
      lastUpdated: "Yesterday",
    ),
    VerificationItem(
      id: "val_comp_addr",
      title: "Company Address",
      type: "Company",
      status: "Not Verified",
      description: "Physical headquarters proof requiring utility bill or lease agreement.",
      lastUpdated: "Never",
    ),
  ];

  List<DocumentPlaceholderItem> documentPlaceholders = [
    DocumentPlaceholderItem(
      id: "doc_reg",
      name: "Company Registration",
      type: "Certificate of Incorporation / Reg. Deed",
      status: "Uploaded",
      lastUpdated: "2 weeks ago",
    ),
    DocumentPlaceholderItem(
      id: "doc_pan",
      name: "PAN",
      type: "Corporate Permanent Account Number",
      status: "Pending Review",
      lastUpdated: "Yesterday",
    ),
    DocumentPlaceholderItem(
      id: "doc_gst",
      name: "GST",
      type: "Goods & Services Tax Registration Certificate",
      status: "Uploaded",
      lastUpdated: "1 week ago",
    ),
    DocumentPlaceholderItem(
      id: "doc_lic",
      name: "Business License",
      type: "Municipal / Industry Operations License",
      status: "Not Uploaded",
      lastUpdated: "Never",
    ),
    DocumentPlaceholderItem(
      id: "doc_addr",
      name: "Office Proof",
      type: "Utility Bill / Lease Agreement (< 3 months old)",
      status: "Not Uploaded",
      lastUpdated: "Never",
    ),
  ];

  // Subscription & Billing System State
  bool isSubscriptionEmpty = false;
  bool isSubscriptionTrial = false;
  String currentPlanName = "Business Edition";
  String currentPlanStatus = "Active";
  String billingCycle = "Monthly Billing (Renews automatically)";
  String renewalDate = "November 1, 2026";
  String activeSince = "January 15, 2025";
  String planExpiry = "November 1, 2026";
  int trialDaysRemaining = 14;

  List<PlanLimitItem> planLimits = [
    PlanLimitItem(name: "Active Job Limit", currentUsage: 18, maxLimit: 50, unit: "Jobs"),
    PlanLimitItem(name: "Candidate Database Limit", currentUsage: 640, maxLimit: 1000, unit: "Candidates"),
    PlanLimitItem(name: "Recruiter Seats", currentUsage: 4, maxLimit: 15, unit: "Seats"),
    PlanLimitItem(name: "Resume Downloads", currentUsage: 125, maxLimit: 250, unit: "Downloads"),
    PlanLimitItem(name: "AI Credits", currentUsage: 820, maxLimit: 1500, unit: "Credits"),
    PlanLimitItem(name: "Priority Support", currentUsage: 1, maxLimit: 1, unit: "24/7 SLA"),
  ];

  List<SubscriptionPlanItem> availablePlans = [
    SubscriptionPlanItem(
      id: "plan_starter",
      name: "Starter",
      monthlyPrice: "\$99 / mo",
      featureSummary: "Essential recruitment tools for boutique hiring teams and independent recruiters.",
      recruiterSeats: "2 Seats",
      jobPostingLimit: "10 Active Jobs",
      candidateLimit: "500 Candidates",
      aiFeatures: "Basic AI Matching",
      supportLevel: "Email Support",
      isCurrentPlan: false,
    ),
    SubscriptionPlanItem(
      id: "plan_prof",
      name: "Professional",
      monthlyPrice: "\$299 / mo",
      featureSummary: "Advanced sourcing and automated pipeline tracking for growing businesses.",
      recruiterSeats: "5 Seats",
      jobPostingLimit: "30 Active Jobs",
      candidateLimit: "2,500 Candidates",
      aiFeatures: "Advanced AI Ranking",
      supportLevel: "24/5 Live Chat",
      isCurrentPlan: false,
    ),
    SubscriptionPlanItem(
      id: "plan_biz",
      name: "Business Edition",
      monthlyPrice: "\$599 / mo",
      featureSummary: "Full enterprise recruiting suite with priority SLA and team role management.",
      recruiterSeats: "15 Seats",
      jobPostingLimit: "50 Active Jobs",
      candidateLimit: "1,000 Candidates",
      aiFeatures: "Full AI Suite & Sourcing",
      supportLevel: "24/7 Priority SLA",
      isCurrentPlan: true,
    ),
    SubscriptionPlanItem(
      id: "plan_ent",
      name: "Enterprise",
      monthlyPrice: "\$999 / mo",
      featureSummary: "Custom enterprise deployment with unlimited scalability and dedicated support.",
      recruiterSeats: "Unlimited",
      jobPostingLimit: "Unlimited",
      candidateLimit: "Unlimited",
      aiFeatures: "Custom AI Models",
      supportLevel: "Dedicated Success Manager",
      isCurrentPlan: false,
    ),
  ];

  List<InvoiceItem> billingHistory = [
    InvoiceItem(invoiceId: "INV-2026-1001", billingDate: "Oct 01, 2026", amount: "\$599.00", status: "Paid"),
    InvoiceItem(invoiceId: "INV-2026-0901", billingDate: "Sep 01, 2026", amount: "\$599.00", status: "Paid"),
    InvoiceItem(invoiceId: "INV-2026-0801", billingDate: "Aug 01, 2026", amount: "\$599.00", status: "Refunded"),
    InvoiceItem(invoiceId: "INV-2026-0701", billingDate: "Jul 01, 2026", amount: "\$599.00", status: "Failed"),
    InvoiceItem(invoiceId: "INV-2026-0601", billingDate: "Jun 01, 2026", amount: "\$599.00", status: "Paid"),
  ];

  List<PaymentMethodPlaceholderItem> paymentMethods = [
    PaymentMethodPlaceholderItem(
      id: "pay_card",
      type: "Credit/Debit Card",
      title: "Visa ending in •••• 4242",
      subtitle: "Expires 08/28 • Corporate Billing",
      icon: Icons.credit_card_rounded,
      isDefault: true,
    ),
    PaymentMethodPlaceholderItem(
      id: "pay_upi",
      type: "UPI",
      title: "technova.recruiting@okaxis",
      subtitle: "Instant bank transfer via verified UPI ID",
      icon: Icons.qr_code_2_rounded,
      isDefault: false,
    ),
    PaymentMethodPlaceholderItem(
      id: "pay_net",
      type: "Net Banking",
      title: "HDFC Corporate Banking",
      subtitle: "Direct enterprise treasury account debit",
      icon: Icons.account_balance_rounded,
      isDefault: false,
    ),
    PaymentMethodPlaceholderItem(
      id: "pay_wallet",
      type: "Wallet",
      title: "JobNest Enterprise Credits Wallet",
      subtitle: "Balance: \$1,250.00 available credit",
      icon: Icons.account_balance_wallet_rounded,
      isDefault: false,
    ),
  ];

  // Communication Settings System State
  bool isCommunicationEmpty = false;
  bool quietHoursEnabled = true;
  String quietHoursStartTime = "10:00 PM";
  String quietHoursEndTime = "08:00 AM";
  String quietHoursTimezone = "(UTC+05:30) India Standard Time";
  bool muteNonUrgentDuringQuietHours = true;

  String sigRecruiterName = "Kunal Sharma";
  String sigDesignation = "Senior Technical Recruiter & Lead Talent Partner";
  String sigCompanyName = "TechNova Innovations & Cloud Systems India";
  String sigPhone = "+91 98765 43210";
  String sigWebsite = "https://careers.technova.com";
  String communicationLanguage = "English (United States)";

  List<CommunicationChannelItem> communicationChannels = [
    CommunicationChannelItem(
      id: "chan_email",
      name: "Email",
      description: "Send automated transactional emails and requisition updates",
      icon: Icons.email_outlined,
      isEnabled: true,
    ),
    CommunicationChannelItem(
      id: "chan_sms",
      name: "SMS",
      description: "Instant text alerts for time-sensitive interview reminders",
      icon: Icons.sms_outlined,
      isEnabled: true,
    ),
    CommunicationChannelItem(
      id: "chan_push",
      name: "Push Notifications",
      description: "Real-time mobile app push alerts for candidate activities",
      icon: Icons.notifications_active_outlined,
      isEnabled: true,
    ),
    CommunicationChannelItem(
      id: "chan_whatsapp",
      name: "WhatsApp",
      description: "Direct WhatsApp Business API messaging for fast engagement",
      icon: Icons.chat_rounded,
      isEnabled: false,
    ),
    CommunicationChannelItem(
      id: "chan_inapp",
      name: "In-App Messages",
      description: "Internal portal notifications and candidate chat interface",
      icon: Icons.inbox_outlined,
      isEnabled: true,
    ),
  ];

  // Job Preferences System State
  bool isJobPreferencesEmpty = false;
  String defaultEmploymentType = "Full-Time";
  String defaultWorkplaceType = "Hybrid";
  String defaultExperienceLevel = "3–5 Years";
  String defaultEducationRequirement = "Bachelor's Degree / B.Tech";
  String defaultNoticePeriod = "30 Days or Immediate";
  String defaultHiringPriority = "High Priority";

  String defaultMinSalary = "12,00,000";
  String defaultMaxSalary = "24,00,000";
  String defaultSalaryCurrency = "INR (₹)";
  String defaultSalaryType = "Annual";

  List<String> defaultSkills = ["Flutter", "Java", "React", "Node.js", "Python", "UI/UX"];
  List<String> defaultPreferredLocations = ["Bangalore", "Hyderabad", "Pune", "Delhi NCR", "Mumbai"];

  bool autoCloseJob = false;
  bool autoArchiveFilledJobs = true;
  bool candidateDuplicateDetection = true;
  bool requireResume = true;
  bool requireCoverLetter = false;
  bool enableQuickApply = true;

  String defaultInterviewMode = "Online";
  String defaultInterviewDuration = "45 Minutes";
  String defaultJobVisibility = "Public";

  // Security & Privacy System State
  bool twoFactorAuthEnabled = true;
  bool authenticatorAppEnabled = true;
  bool smsOtpEnabled = true;
  bool emailOtpEnabled = false;
  bool backupCodesGenerated = true;

  String lastPasswordChangeDate = "30 days ago (June 26, 2026)";
  String recoveryEmail = "recruiter.backup@jobnest.com";
  String recoveryPhone = "+91 98765 43210";
  String backupVerificationMethod = "Backup OTP Codes & Security Questions";

  // Privacy Controls
  bool profileVisibility = true;
  bool onlineStatus = true;
  bool activityStatus = true;
  bool searchVisibility = true;
  bool recruiterProfileVisibility = true;

  // Login Alerts
  bool emailLoginAlerts = true;
  bool newDeviceAlerts = true;
  bool suspiciousActivityAlerts = true;
  bool passwordChangeAlerts = true;

  List<SecurityActivityItem> loginHistoryList = [
    SecurityActivityItem(
      id: "log_1",
      deviceName: "MacBook Pro M3 Max",
      browser: "Chrome 126.0 (macOS)",
      os: "macOS Sonoma 14.5",
      loginTime: "Just now",
      location: "Bangalore, India",
      status: "Current Session",
    ),
    SecurityActivityItem(
      id: "log_2",
      deviceName: "iPhone 15 Pro Max",
      browser: "JobNest iOS App v4.2",
      os: "iOS 17.5.1",
      loginTime: "2 hours ago",
      location: "Bangalore, India",
      status: "Previous Login",
    ),
    SecurityActivityItem(
      id: "log_3",
      deviceName: "Windows 11 Workstation",
      browser: "Edge 125.0",
      os: "Windows 11 Pro",
      loginTime: "Yesterday, 10:45 AM",
      location: "Hyderabad, India",
      status: "Previous Login",
    ),
    SecurityActivityItem(
      id: "log_4",
      deviceName: "Unknown Android Device",
      browser: "Chrome 124.0",
      os: "Android 14",
      loginTime: "3 days ago, 02:15 AM",
      location: "Moscow, Russia",
      status: "Failed Login",
    ),
  ];

  List<SecuritySessionItem> activeSessionsList = [
    SecuritySessionItem(
      id: "sess_1",
      deviceName: "MacBook Pro M3 Max",
      platform: "macOS Sonoma 14.5",
      browser: "Chrome 126.0",
      loginTime: "Active now (Started 4 hours ago)",
      location: "Bangalore, India • IP 192.168.1.104",
      isCurrentDevice: true,
    ),
    SecuritySessionItem(
      id: "sess_2",
      deviceName: "iPhone 15 Pro Max",
      platform: "iOS 17.5.1",
      browser: "JobNest iOS App v4.2",
      loginTime: "Active 2 hours ago",
      location: "Bangalore, India • IP 172.16.0.45",
      isCurrentDevice: false,
    ),
    SecuritySessionItem(
      id: "sess_3",
      deviceName: "iPad Air (5th Gen)",
      platform: "iPadOS 17.4",
      browser: "Safari 17.4",
      loginTime: "Active yesterday",
      location: "Pune, India • IP 10.0.0.12",
      isCurrentDevice: false,
    ),
  ];

  // Data Management System State
  bool isBackupEmpty = false;
  String lastBackupDate = "2 hours ago (June 26, 2026, 18:30 IST)";
  String backupStatusLabel = "Successful / Up to date";
  String backupFrequency = "Daily";

  // Retention Policies
  String retentionCandidateData = "1 Year";
  String retentionJobData = "Never";
  String retentionClosedJobs = "180 Days";
  String retentionRejectedCandidates = "90 Days";
  String retentionAutoDeleteOld = "Never";

  // Data Privacy Controls
  bool dataAnalyticsCollection = true;
  bool dataUsageStatistics = true;
  bool dataCrashReports = true;
  bool dataPersonalizedSuggestions = true;
  bool dataAnonymousImprovement = false;

  // Support & Help Center State
  bool isSupportHistoryEmpty = false;

  List<SupportTicketItem> supportTicketsList = [
    SupportTicketItem(
      id: "#TICK-8492",
      subject: "Enterprise billing invoice tax exemption inquiry",
      category: "Billing",
      priority: "High",
      createdDate: "2 hours ago",
      status: "Open",
    ),
    SupportTicketItem(
      id: "#TICK-8104",
      subject: "Candidate resume parsing delay on PDF uploads",
      category: "Candidates",
      priority: "Medium",
      createdDate: "Yesterday",
      status: "Pending",
    ),
    SupportTicketItem(
      id: "#TICK-7933",
      subject: "Custom email template placeholder formatting",
      category: "Recruitment",
      priority: "Low",
      createdDate: "July 22, 2026",
      status: "Resolved",
    ),
    SupportTicketItem(
      id: "#TICK-7410",
      subject: "Adding new hiring manager role permissions",
      category: "Team Management",
      priority: "Medium",
      createdDate: "July 15, 2026",
      status: "Closed",
    ),
  ];

  // Language & Accessibility State (Phase P12)
  String currentLanguage = "English (US)";
  String regionalCountry = "India";
  String regionalDateFormat = "DD/MM/YYYY";
  String regionalTimeFormat = "24-Hour (14:30)";
  String regionalNumberFormat = "12,34,567.89 (Indian Lakhs/Crores)";
  String regionalFirstDayOfWeek = "Monday";
  String regionalTimezone = "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi";

  double textSizeScale = 1.0;
  String textSizeLabel = "Medium (Standard)";

  bool displayHighContrast = false;
  bool displayReduceMotion = false;
  bool displayLargeButtons = false;
  bool displayCompactLayout = false;
  bool displayShowTooltips = true;

  bool accessScreenReader = false;
  bool accessAccessibleLabels = true;
  bool accessKeyboardNav = true;
  bool accessFocusIndicators = true;
  bool accessVoiceAssistance = false;

  String colorAccessibilityMode = "Default Colors";

  bool animEnabled = true;
  bool animReduceMotion = false;
  String animSpeed = "1.0x Standard";

  String readabilityLineSpacing = "1.5x Standard";
  String readabilityFontWeight = "Medium (500)";
  String readabilityCardDensity = "Standard";
  String readabilityIconSize = "Medium (24px)";

  // Biometric & Device Security State (Phase P13)
  bool isTrustedDevicesEmpty = false;

  bool bioFingerprintEnabled = true;
  bool bioFaceUnlockEnabled = true;
  bool bioPasscodeEnabled = false;

  String bioAppLockTimeout = "After 5 Minutes";
  String bioAutoLockInactivity = "10 Minutes";

  bool bioProtectBilling = true;
  bool bioProtectSubscription = true;
  bool bioProtectDeleteAccount = true;
  bool bioProtectDataExport = true;
  bool bioProtectVerification = false;
  bool bioProtectSecuritySettings = true;

  bool bioAlertEmail = true;
  bool bioAlertPush = true;
  bool bioAlertSms = false;
  bool bioAlertWarning = true;

  bool bioSessionAutoLogout = false;
  bool bioSessionRememberDevice = true;
  bool bioSessionRequireLoginAgain = false;

  List<SecuritySessionItem> trustedDevicesList = [
    SecuritySessionItem(
      id: "dev_mac_01",
      deviceName: "MacBook Pro M3 Max",
      platform: "macOS Sonoma 14.5",
      browser: "Chrome Enterprise 126.0",
      loginTime: "Active Now",
      location: "Bangalore, India (66.249.79.1)",
      isCurrentDevice: true,
      deviceType: "Workstation",
      status: "Current Device",
    ),
    SecuritySessionItem(
      id: "dev_ip_02",
      deviceName: "iPhone 15 Pro Max",
      platform: "iOS 17.5.1",
      browser: "JobNest Mobile Enterprise v4.2",
      loginTime: "2 hours ago",
      location: "Bangalore, India (103.21.244.0)",
      isCurrentDevice: false,
      deviceType: "Mobile Device",
      status: "Trusted Device",
    ),
    SecuritySessionItem(
      id: "dev_win_03",
      deviceName: "Dell XPS 15 Workstation",
      platform: "Windows 11 Enterprise",
      browser: "Microsoft Edge 125.0",
      loginTime: "Yesterday at 18:40 IST",
      location: "Hyderabad, India (49.248.15.0)",
      isCurrentDevice: false,
      deviceType: "Workstation",
      status: "Trusted Device",
    ),
  ];

  List<SecuritySessionItem> deviceLoginHistoryList = [
    SecuritySessionItem(
      id: "hist_01",
      deviceName: "MacBook Pro M3 Max",
      platform: "macOS Sonoma",
      browser: "Chrome Enterprise 126.0",
      loginTime: "Today, 21:05 IST",
      location: "Bangalore, India",
      isCurrentDevice: true,
      deviceType: "Workstation",
      status: "Current Device",
    ),
    SecuritySessionItem(
      id: "hist_02",
      deviceName: "iPhone 15 Pro Max",
      platform: "iOS 17.5.1",
      browser: "JobNest Mobile v4.2",
      loginTime: "Today, 14:15 IST",
      location: "Bangalore, India",
      isCurrentDevice: false,
      deviceType: "Mobile",
      status: "Previous Device",
    ),
    SecuritySessionItem(
      id: "hist_03",
      deviceName: "Unknown Linux Terminal",
      platform: "Ubuntu 24.04 LTS",
      browser: "Firefox 127.0",
      loginTime: "July 24, 03:12 IST",
      location: "Frankfurt, Germany",
      isCurrentDevice: false,
      deviceType: "Server / Script",
      status: "Unknown Device",
    ),
  ];

  List<CommunicationSettingItem> candidateCommunicationSettings = [
    CommunicationSettingItem(
      id: "cand_app_rec",
      title: "Application Received Message",
      description: "Send automatic confirmation when candidate submits application",
      category: "Candidate",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "cand_inv_inv",
      title: "Interview Invitation",
      description: "Dispatch calendar invites and interview meeting links",
      category: "Candidate",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "cand_inv_rem",
      title: "Interview Reminder",
      description: "Send automated reminder 24h and 1h prior to interview",
      category: "Candidate",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "cand_off_not",
      title: "Offer Letter Notification",
      description: "Notify candidate immediately upon formal offer extension",
      category: "Candidate",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "cand_rej_not",
      title: "Rejection Notification",
      description: "Send professional, respectful update when status changes to Rejected",
      category: "Candidate",
      isEnabled: false,
    ),
    CommunicationSettingItem(
      id: "cand_fol_rem",
      title: "Follow-up Reminder",
      description: "Nudge candidates who haven't responded to interview requests within 48 hours",
      category: "Candidate",
      isEnabled: true,
    ),
  ];

  List<CommunicationSettingItem> teamCommunicationSettings = [
    CommunicationSettingItem(
      id: "team_job_cre",
      title: "New Job Created",
      description: "Notify hiring managers and recruiters when a requisition is published",
      category: "Team",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "team_cand_ass",
      title: "Candidate Assigned",
      description: "Alert team member when a candidate is assigned to their review pipeline",
      category: "Team",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "team_inv_sch",
      title: "Interview Scheduled",
      description: "Broadcast interview confirmation to panel members",
      category: "Team",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "team_feed_rem",
      title: "Interview Feedback Reminder",
      description: "Prompt interviewers to submit scorecard ratings within 2 hours post-interview",
      category: "Team",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "team_mentions",
      title: "Team Mentions",
      description: "Receive immediate notification when mentioned in candidate notes or comments",
      category: "Team",
      isEnabled: true,
    ),
    CommunicationSettingItem(
      id: "team_announce",
      title: "Internal Announcements",
      description: "Important corporate updates, SLA alerts, and system maintenance notes",
      category: "Team",
      isEnabled: true,
    ),
  ];

  List<AutomatedMessageTemplateItem> automatedMessages = [
    AutomatedMessageTemplateItem(
      id: "auto_reply",
      title: "Auto Reply",
      trigger: "Triggered when receiving candidate inquiries outside business hours",
      templateBody: "Hi {candidate_name}, thank you for reaching out to {company_name}. Our recruitment team is currently offline. We have received your message and will get back to you within 1 business day.",
      isEnabled: true,
    ),
    AutomatedMessageTemplateItem(
      id: "auto_inv_rem",
      title: "Interview Reminder",
      trigger: "Triggered 24 hours prior to scheduled interview session",
      templateBody: "Dear {candidate_name}, this is a friendly reminder for your upcoming {interview_type} interview for {job_title} tomorrow at {time}. Please ensure you have tested your audio/video link.",
      isEnabled: true,
    ),
    AutomatedMessageTemplateItem(
      id: "auto_app_ack",
      title: "Application Acknowledgement",
      trigger: "Triggered immediately upon successful application submission",
      templateBody: "Hello {candidate_name}, we are excited to receive your application for {job_title} at {company_name}! Our talent acquisition team is reviewing your profile and will update you soon.",
      isEnabled: true,
    ),
    AutomatedMessageTemplateItem(
      id: "auto_thank_you",
      title: "Thank You Message",
      trigger: "Triggered after interview scorecard completion",
      templateBody: "Dear {candidate_name}, thank you for taking the time to interview with {company_name} today. We appreciated learning about your experience and will be in touch with next steps shortly.",
      isEnabled: true,
    ),
  ];

  Future<void> _loadNotificationPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      pushNotifications = prefs.getBool('notif_push') ?? true;
      emailNotifications = prefs.getBool('notif_email') ?? true;
      interviewReminders = prefs.getBool('notif_interviews') ?? true;
      marketingUpdates = prefs.getBool('notif_marketing') ?? false;
      notifyListeners();
    } catch (_) {
      // Fallback to default if prefs fail
    }
  }

  Future<void> setPushNotifications(bool value) async {
    pushNotifications = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_push', value);
  }

  Future<void> setEmailNotifications(bool value) async {
    emailNotifications = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_email', value);
  }

  Future<void> setInterviewReminders(bool value) async {
    interviewReminders = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_interviews', value);
  }

  Future<void> setMarketingUpdates(bool value) async {
    marketingUpdates = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_marketing', value);
  }

  void updatePersonalInfo({
    String? name,
    String? newEmail,
    String? newPhone,
    String? newDesignation,
    String? newLocation,
  }) {
    if (name != null && name.isNotEmpty) fullName = name;
    if (newEmail != null && newEmail.isNotEmpty) email = newEmail;
    if (newPhone != null && newPhone.isNotEmpty) phone = newPhone;
    if (newDesignation != null && newDesignation.isNotEmpty) designation = newDesignation;
    if (newLocation != null && newLocation.isNotEmpty) location = newLocation;
    notifyListeners();
  }

  void updateCompanyInfo({
    String? name,
    String? newIndustry,
    String? size,
    String? web,
    String? hq,
    String? year,
    String? phone,
    String? address,
    String? cityVal,
    String? stateVal,
    String? countryVal,
    String? pan,
    String? tan,
  }) {
    if (name != null && name.isNotEmpty) companyName = name;
    if (newIndustry != null && newIndustry.isNotEmpty) industry = newIndustry;
    if (size != null && size.isNotEmpty) companySize = size;
    if (web != null && web.isNotEmpty) website = web;
    if (hq != null && hq.isNotEmpty) headquarters = hq;
    if (year != null && year.isNotEmpty) foundedYear = year;
    if (phone != null && phone.isNotEmpty) officialPhone = phone;
    if (address != null && address.isNotEmpty) officeAddress = address;
    if (cityVal != null && cityVal.isNotEmpty) city = cityVal;
    if (stateVal != null && stateVal.isNotEmpty) state = stateVal;
    if (countryVal != null && countryVal.isNotEmpty) country = countryVal;
    if (pan != null && pan.isNotEmpty) companyPan = pan;
    if (tan != null && tan.isNotEmpty) companyTan = tan;
    notifyListeners();
  }

  void updateCompanyBranding({
    String? overview,
    String? description,
    String? mission,
    String? vision,
    String? culture,
    String? values,
  }) {
    if (overview != null) companyOverview = overview;
    if (description != null) companyDescription = description;
    if (mission != null) missionStatement = mission;
    if (vision != null) visionStatement = vision;
    if (culture != null) workCulture = culture;
    if (values != null) companyValues = values;
    notifyListeners();
  }

  void toggleCompanyMediaEmpty() {
    isCompanyMediaEmpty = !isCompanyMediaEmpty;
    notifyListeners();
  }

  List<TeamMemberItem> get filteredTeamMembers {
    if (isTeamEmpty) return [];
    return teamMembers.where((m) {
      final matchesSearch = teamSearchQuery.isEmpty ||
          m.name.toLowerCase().contains(teamSearchQuery.toLowerCase()) ||
          m.email.toLowerCase().contains(teamSearchQuery.toLowerCase()) ||
          m.role.toLowerCase().contains(teamSearchQuery.toLowerCase());
      final matchesFilter = teamRoleFilter == "All" || m.role == teamRoleFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  List<RoleSummary> get roleSummaries {
    int countFor(String role) => isTeamEmpty ? 0 : teamMembers.where((m) => m.role == role).length;
    return [
      RoleSummary(
        name: "Admin",
        description: "Unrestricted access to all modules, billing, security, and team management.",
        permissionSummary: "Full access across all 10 categories",
        memberCount: countFor("Admin"),
      ),
      RoleSummary(
        name: "HR Manager",
        description: "Supervises recruitment workflows, team visibility, and analytical reporting.",
        permissionSummary: "Recruitment management, Team visibility, Reports",
        memberCount: countFor("HR Manager"),
      ),
      RoleSummary(
        name: "Recruiter",
        description: "Manages day-to-day candidate pipelines, job postings, and interview schedules.",
        permissionSummary: "Jobs, Candidates, Interviews, and Notifications",
        memberCount: countFor("Recruiter"),
      ),
      RoleSummary(
        name: "Hiring Manager",
        description: "Reviews assigned candidates, submits interview evaluations, and approves hiring decisions.",
        permissionSummary: "Candidate review, Interview feedback, Hiring decisions",
        memberCount: countFor("Hiring Manager"),
      ),
      RoleSummary(
        name: "Viewer",
        description: "Read-only visibility into job requisitions and candidate statuses without editing rights.",
        permissionSummary: "Read-only access to Jobs, Candidates, and Reports",
        memberCount: countFor("Viewer"),
      ),
    ];
  }

  void updateTeamSearchQuery(String query) {
    teamSearchQuery = query;
    notifyListeners();
  }

  void updateTeamRoleFilter(String filter) {
    teamRoleFilter = filter;
    notifyListeners();
  }

  void toggleTeamEmptyState() {
    isTeamEmpty = !isTeamEmpty;
    notifyListeners();
  }

  void assignRoleToMember(String memberId, String newRole) {
    final index = teamMembers.indexWhere((m) => m.id == memberId);
    if (index != -1) {
      final member = teamMembers[index];
      teamMembers[index] = TeamMemberItem(
        id: member.id,
        name: member.name,
        email: member.email,
        role: newRole,
        status: member.status,
        hasCustomPermissions: false,
        permissions: getDefaultPermissionsForRole(newRole),
      );
      notifyListeners();
    }
  }

  void updateMemberPermission(String memberId, String category, String action, bool value) {
    final index = teamMembers.indexWhere((m) => m.id == memberId);
    if (index != -1) {
      final member = teamMembers[index];
      final newPermissions = member.permissions.map((p) {
        if (p.category == category) {
          switch (action) {
            case 'view':
              return p.copyWith(canView: value);
            case 'create':
              return p.copyWith(canCreate: value);
            case 'edit':
              return p.copyWith(canEdit: value);
            case 'delete':
              return p.copyWith(canDelete: value);
          }
        }
        return p;
      }).toList();

      teamMembers[index] = TeamMemberItem(
        id: member.id,
        name: member.name,
        email: member.email,
        role: member.role,
        status: member.status,
        hasCustomPermissions: true,
        permissions: newPermissions,
      );
      notifyListeners();
    }
  }

  void addTeamMember({required String name, required String email, required String role}) {
    final newId = (teamMembers.length + 10).toString();
    teamMembers.add(
      TeamMemberItem(
        id: newId,
        name: name,
        email: email,
        role: role,
        status: "Invited",
        permissions: getDefaultPermissionsForRole(role),
      ),
    );
    isTeamEmpty = false;
    notifyListeners();
  }

  void deleteTeamMember(String memberId) {
    teamMembers.removeWhere((m) => m.id == memberId);
    notifyListeners();
  }

  // Verification & Trust Getters and Methods
  int get trustScore {
    if (isVerificationEmpty || verificationItems.isEmpty) return 0;
    final verifiedCount = verificationItems.where((v) => v.status == "Verified").length;
    if (verifiedCount == 6 && verificationItems.length == 7) return 85;
    return (verifiedCount * 100) ~/ verificationItems.length;
  }

  String get verificationStatusSummary {
    if (isVerificationEmpty || trustScore == 0) return "Not Verified";
    if (trustScore == 100) return "Verified";
    return "Partially Verified";
  }

  List<String> get recruiterTrustBadges => [
        "Verified Recruiter",
        "Verified Admin",
        "Recruitment Specialist",
      ];

  List<String> get companyTrustBadges => [
        "Verified Employer",
        "Trusted Recruiter",
        "Enterprise",
        "Startup",
      ];

  void toggleVerificationEmptyState() {
    isVerificationEmpty = !isVerificationEmpty;
    notifyListeners();
  }

  void startAllVerification() {
    isVerificationEmpty = false;
    for (var i = 0; i < verificationItems.length; i++) {
      if (verificationItems[i].status == "Not Verified") {
        verificationItems[i] = VerificationItem(
          id: verificationItems[i].id,
          title: verificationItems[i].title,
          type: verificationItems[i].type,
          status: "Pending",
          description: verificationItems[i].description,
          lastUpdated: "Just now",
        );
      }
    }
    notifyListeners();
  }

  void verifyItem(String itemId, String action) {
    final index = verificationItems.indexWhere((v) => v.id == itemId);
    if (index != -1) {
      final item = verificationItems[index];
      String newStatus = item.status;
      if (action == "Verify" || action == "Resubmit") {
        newStatus = "Pending";
      } else if (action == "Approve" || action == "Force Verify") {
        newStatus = "Verified";
      }
      verificationItems[index] = VerificationItem(
        id: item.id,
        title: item.title,
        type: item.type,
        status: newStatus,
        description: item.description,
        lastUpdated: "Just now",
      );
      notifyListeners();
    }
  }

  void uploadDocumentPlaceholder(String docId) {
    final index = documentPlaceholders.indexWhere((d) => d.id == docId);
    if (index != -1) {
      final doc = documentPlaceholders[index];
      documentPlaceholders[index] = DocumentPlaceholderItem(
        id: doc.id,
        name: doc.name,
        type: doc.type,
        status: "Pending Review",
        lastUpdated: "Just now",
      );
      notifyListeners();
    }
  }

  // Subscription & Billing Methods
  void toggleSubscriptionEmptyState() {
    isSubscriptionEmpty = !isSubscriptionEmpty;
    if (isSubscriptionEmpty) {
      currentPlanStatus = "Cancelled";
    } else {
      currentPlanStatus = isSubscriptionTrial ? "Trial" : "Active";
    }
    notifyListeners();
  }

  void toggleSubscriptionTrialState() {
    isSubscriptionTrial = !isSubscriptionTrial;
    if (isSubscriptionTrial) {
      currentPlanStatus = "Trial";
      currentPlanName = "Business Edition (Trial)";
    } else {
      currentPlanStatus = "Active";
      currentPlanName = "Business Edition";
    }
    notifyListeners();
  }

  void upgradePlan(String planId) {
    isSubscriptionEmpty = false;
    isSubscriptionTrial = false;
    currentPlanStatus = "Active";
    for (var i = 0; i < availablePlans.length; i++) {
      final plan = availablePlans[i];
      final isSel = plan.id == planId || plan.name == planId;
      if (isSel) currentPlanName = plan.name;
      availablePlans[i] = SubscriptionPlanItem(
        id: plan.id,
        name: plan.name,
        monthlyPrice: plan.monthlyPrice,
        featureSummary: plan.featureSummary,
        recruiterSeats: plan.recruiterSeats,
        jobPostingLimit: plan.jobPostingLimit,
        candidateLimit: plan.candidateLimit,
        aiFeatures: plan.aiFeatures,
        supportLevel: plan.supportLevel,
        isCurrentPlan: isSel,
      );
    }
    notifyListeners();
  }

  void downgradePlan(String planId) {
    upgradePlan(planId);
  }

  void renewPlan() {
    currentPlanStatus = "Active";
    renewalDate = "November 1, 2027";
    planExpiry = "November 1, 2027";
    notifyListeners();
  }

  void cancelSubscription() {
    currentPlanStatus = "Cancelled";
    isSubscriptionEmpty = true;
    notifyListeners();
  }

  void setDefaultPaymentMethod(String methodId) {
    for (var i = 0; i < paymentMethods.length; i++) {
      final pm = paymentMethods[i];
      paymentMethods[i] = PaymentMethodPlaceholderItem(
        id: pm.id,
        type: pm.type,
        title: pm.title,
        subtitle: pm.subtitle,
        icon: pm.icon,
        isDefault: pm.id == methodId,
      );
    }
    notifyListeners();
  }

  // Communication Settings Methods
  void toggleCommunicationEmptyState() {
    isCommunicationEmpty = !isCommunicationEmpty;
    notifyListeners();
  }

  void toggleCommunicationChannel(String id, bool val) {
    for (var i = 0; i < communicationChannels.length; i++) {
      if (communicationChannels[i].id == id) {
        final c = communicationChannels[i];
        communicationChannels[i] = CommunicationChannelItem(
          id: c.id,
          name: c.name,
          description: c.description,
          icon: c.icon,
          isEnabled: val,
        );
        break;
      }
    }
    notifyListeners();
  }

  void toggleCandidateCommunicationSetting(String id, bool val) {
    for (var i = 0; i < candidateCommunicationSettings.length; i++) {
      if (candidateCommunicationSettings[i].id == id) {
        final s = candidateCommunicationSettings[i];
        candidateCommunicationSettings[i] = CommunicationSettingItem(
          id: s.id,
          title: s.title,
          description: s.description,
          category: s.category,
          isEnabled: val,
        );
        break;
      }
    }
    notifyListeners();
  }

  void toggleTeamCommunicationSetting(String id, bool val) {
    for (var i = 0; i < teamCommunicationSettings.length; i++) {
      if (teamCommunicationSettings[i].id == id) {
        final s = teamCommunicationSettings[i];
        teamCommunicationSettings[i] = CommunicationSettingItem(
          id: s.id,
          title: s.title,
          description: s.description,
          category: s.category,
          isEnabled: val,
        );
        break;
      }
    }
    notifyListeners();
  }

  void updateAutomatedMessageTemplate(String id, String newBody) {
    for (var i = 0; i < automatedMessages.length; i++) {
      if (automatedMessages[i].id == id) {
        final m = automatedMessages[i];
        automatedMessages[i] = AutomatedMessageTemplateItem(
          id: m.id,
          title: m.title,
          trigger: m.trigger,
          templateBody: newBody,
          isEnabled: m.isEnabled,
        );
        break;
      }
    }
    notifyListeners();
  }

  void toggleAutomatedMessageTemplate(String id, bool val) {
    for (var i = 0; i < automatedMessages.length; i++) {
      if (automatedMessages[i].id == id) {
        final m = automatedMessages[i];
        automatedMessages[i] = AutomatedMessageTemplateItem(
          id: m.id,
          title: m.title,
          trigger: m.trigger,
          templateBody: m.templateBody,
          isEnabled: val,
        );
        break;
      }
    }
    notifyListeners();
  }

  void updateQuietHours({
    bool? enabled,
    String? startTime,
    String? endTime,
    String? timezone,
    bool? muteNonUrgent,
  }) {
    if (enabled != null) quietHoursEnabled = enabled;
    if (startTime != null) quietHoursStartTime = startTime;
    if (endTime != null) quietHoursEndTime = endTime;
    if (timezone != null) quietHoursTimezone = timezone;
    if (muteNonUrgent != null) muteNonUrgentDuringQuietHours = muteNonUrgent;
    notifyListeners();
  }

  void updateEmailSignature({
    required String name,
    required String designation,
    required String company,
    required String phone,
    required String website,
  }) {
    sigRecruiterName = name;
    sigDesignation = designation;
    sigCompanyName = company;
    sigPhone = phone;
    sigWebsite = website;
    notifyListeners();
  }

  void updateCommunicationLanguage(String lang) {
    communicationLanguage = lang;
    notifyListeners();
  }

  // Job Preferences Methods
  void toggleJobPreferencesEmptyState() {
    isJobPreferencesEmpty = !isJobPreferencesEmpty;
    notifyListeners();
  }

  void updateJobPreferenceDropdowns({
    String? employmentType,
    String? workplaceType,
    String? experienceLevel,
    String? educationReq,
    String? noticePeriod,
    String? hiringPriority,
    String? currency,
    String? salaryType,
    String? interviewMode,
    String? interviewDuration,
    String? jobVisibility,
  }) {
    if (employmentType != null) defaultEmploymentType = employmentType;
    if (workplaceType != null) defaultWorkplaceType = workplaceType;
    if (experienceLevel != null) defaultExperienceLevel = experienceLevel;
    if (educationReq != null) defaultEducationRequirement = educationReq;
    if (noticePeriod != null) defaultNoticePeriod = noticePeriod;
    if (hiringPriority != null) defaultHiringPriority = hiringPriority;
    if (currency != null) defaultSalaryCurrency = currency;
    if (salaryType != null) defaultSalaryType = salaryType;
    if (interviewMode != null) defaultInterviewMode = interviewMode;
    if (interviewDuration != null) defaultInterviewDuration = interviewDuration;
    if (jobVisibility != null) defaultJobVisibility = jobVisibility;
    notifyListeners();
  }

  void updateDefaultSalaryRange(String minSal, String maxSal) {
    defaultMinSalary = minSal;
    defaultMaxSalary = maxSal;
    notifyListeners();
  }

  void addDefaultSkill(String skill) {
    if (skill.trim().isNotEmpty && !defaultSkills.contains(skill.trim())) {
      defaultSkills.add(skill.trim());
      notifyListeners();
    }
  }

  void removeDefaultSkill(String skill) {
    defaultSkills.remove(skill);
    notifyListeners();
  }

  void addDefaultLocation(String loc) {
    if (loc.trim().isNotEmpty && !defaultPreferredLocations.contains(loc.trim())) {
      defaultPreferredLocations.add(loc.trim());
      notifyListeners();
    }
  }

  void removeDefaultLocation(String loc) {
    defaultPreferredLocations.remove(loc);
    notifyListeners();
  }

  void toggleHiringSetting(String settingKey, bool val) {
    switch (settingKey) {
      case 'autoClose':
        autoCloseJob = val;
        break;
      case 'autoArchive':
        autoArchiveFilledJobs = val;
        break;
      case 'duplicateDetect':
        candidateDuplicateDetection = val;
        break;
      case 'reqResume':
        requireResume = val;
        break;
      case 'reqCover':
        requireCoverLetter = val;
        break;
      case 'quickApply':
        enableQuickApply = val;
        break;
    }
    notifyListeners();
  }

  void resetJobPreferencesToDefault() {
    isJobPreferencesEmpty = false;
    defaultEmploymentType = "Full-Time";
    defaultWorkplaceType = "Hybrid";
    defaultExperienceLevel = "3–5 Years";
    defaultEducationRequirement = "Bachelor's Degree / B.Tech";
    defaultNoticePeriod = "30 Days or Immediate";
    defaultHiringPriority = "High Priority";
    defaultMinSalary = "12,00,000";
    defaultMaxSalary = "24,00,000";
    defaultSalaryCurrency = "INR (₹)";
    defaultSalaryType = "Annual";
    defaultSkills = ["Flutter", "Java", "React", "Node.js", "Python", "UI/UX"];
    defaultPreferredLocations = ["Bangalore", "Hyderabad", "Pune", "Delhi NCR", "Mumbai"];
    autoCloseJob = false;
    autoArchiveFilledJobs = true;
    candidateDuplicateDetection = true;
    requireResume = true;
    requireCoverLetter = false;
    enableQuickApply = true;
    defaultInterviewMode = "Online";
    defaultInterviewDuration = "45 Minutes";
    defaultJobVisibility = "Public";
    notifyListeners();
  }

  // Security & Privacy Methods
  int get securityScore {
    int score = 40; // Base score for valid account
    if (twoFactorAuthEnabled) score += 20;
    if (recoveryEmail.isNotEmpty) score += 15;
    if (recoveryPhone.isNotEmpty) score += 15;
    if (newDeviceAlerts && suspiciousActivityAlerts) score += 10;
    return score.clamp(0, 100);
  }

  String get securityStatusLabel {
    final s = securityScore;
    if (s >= 90) return "Excellent";
    if (s >= 75) return "Good";
    return "Needs Attention";
  }

  void toggleSecurity2FA(String type, bool val) {
    switch (type) {
      case 'main':
        twoFactorAuthEnabled = val;
        break;
      case 'app':
        authenticatorAppEnabled = val;
        break;
      case 'sms':
        smsOtpEnabled = val;
        break;
      case 'email':
        emailOtpEnabled = val;
        break;
      case 'backup':
        backupCodesGenerated = val;
        break;
    }
    notifyListeners();
  }

  void togglePrivacyControl(String key, bool val) {
    switch (key) {
      case 'profile':
        profileVisibility = val;
        break;
      case 'online':
        onlineStatus = val;
        break;
      case 'activity':
        activityStatus = val;
        break;
      case 'search':
        searchVisibility = val;
        break;
      case 'recruiter':
        recruiterProfileVisibility = val;
        break;
    }
    notifyListeners();
  }

  void toggleLoginAlert(String key, bool val) {
    switch (key) {
      case 'email':
        emailLoginAlerts = val;
        break;
      case 'device':
        newDeviceAlerts = val;
        break;
      case 'suspicious':
        suspiciousActivityAlerts = val;
        break;
      case 'password':
        passwordChangeAlerts = val;
        break;
    }
    notifyListeners();
  }

  void updateAccountRecovery({String? email, String? phone, String? method}) {
    if (email != null) recoveryEmail = email;
    if (phone != null) recoveryPhone = phone;
    if (method != null) backupVerificationMethod = method;
    notifyListeners();
  }

  void terminateSession(String sessionId) {
    activeSessionsList.removeWhere((item) => item.id == sessionId && !item.isCurrentDevice);
    notifyListeners();
  }

  void terminateOtherSessions() {
    activeSessionsList.removeWhere((item) => !item.isCurrentDevice);
    notifyListeners();
  }

  void resetSecurityToDefaults() {
    twoFactorAuthEnabled = true;
    authenticatorAppEnabled = true;
    smsOtpEnabled = true;
    emailOtpEnabled = false;
    backupCodesGenerated = true;
    lastPasswordChangeDate = "30 days ago (June 26, 2026)";
    recoveryEmail = "recruiter.backup@jobnest.com";
    recoveryPhone = "+91 98765 43210";
    backupVerificationMethod = "Backup OTP Codes & Security Questions";
    profileVisibility = true;
    onlineStatus = true;
    activityStatus = true;
    searchVisibility = true;
    recruiterProfileVisibility = true;
    emailLoginAlerts = true;
    newDeviceAlerts = true;
    suspiciousActivityAlerts = true;
    passwordChangeAlerts = true;
    notifyListeners();
  }

  // Data Management Methods
  void toggleBackupEmptyState() {
    isBackupEmpty = !isBackupEmpty;
    if (!isBackupEmpty) {
      lastBackupDate = "Just now (${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')})";
      backupStatusLabel = "Successful / Up to date";
    }
    notifyListeners();
  }

  void updateBackupFrequency(String freq) {
    backupFrequency = freq;
    notifyListeners();
  }

  void updateDataRetentionPolicy({
    String? candidateData,
    String? jobData,
    String? closedJobs,
    String? rejectedCandidates,
    String? autoDelete,
  }) {
    if (candidateData != null) retentionCandidateData = candidateData;
    if (jobData != null) retentionJobData = jobData;
    if (closedJobs != null) retentionClosedJobs = closedJobs;
    if (rejectedCandidates != null) retentionRejectedCandidates = rejectedCandidates;
    if (autoDelete != null) retentionAutoDeleteOld = autoDelete;
    notifyListeners();
  }

  void toggleDataPrivacyControl(String key, bool val) {
    switch (key) {
      case 'analytics':
        dataAnalyticsCollection = val;
        break;
      case 'usage':
        dataUsageStatistics = val;
        break;
      case 'crash':
        dataCrashReports = val;
        break;
      case 'suggestions':
        dataPersonalizedSuggestions = val;
        break;
      case 'anonymous':
        dataAnonymousImprovement = val;
        break;
    }
    notifyListeners();
  }

  void resetDataManagementToDefaults() {
    isBackupEmpty = false;
    lastBackupDate = "2 hours ago (June 26, 2026, 18:30 IST)";
    backupStatusLabel = "Successful / Up to date";
    backupFrequency = "Daily";
    retentionCandidateData = "1 Year";
    retentionJobData = "Never";
    retentionClosedJobs = "180 Days";
    retentionRejectedCandidates = "90 Days";
    retentionAutoDeleteOld = "Never";
    dataAnalyticsCollection = true;
    dataUsageStatistics = true;
    dataCrashReports = true;
    dataPersonalizedSuggestions = true;
    dataAnonymousImprovement = false;
    notifyListeners();
  }

  // Support & Help Center Methods
  void toggleSupportHistoryEmptyState() {
    isSupportHistoryEmpty = !isSupportHistoryEmpty;
    notifyListeners();
  }

  void addSupportTicket({
    required String subject,
    required String category,
    required String priority,
  }) {
    final newId = "#TICK-${8500 + supportTicketsList.length}";
    supportTicketsList.insert(
      0,
      SupportTicketItem(
        id: newId,
        subject: subject,
        category: category,
        priority: priority,
        createdDate: "Just now",
        status: "Open",
      ),
    );
    isSupportHistoryEmpty = false;
    notifyListeners();
  }

  void resetSupportToDefaults() {
    isSupportHistoryEmpty = false;
    supportTicketsList = [
      SupportTicketItem(
        id: "#TICK-8492",
        subject: "Enterprise billing invoice tax exemption inquiry",
        category: "Billing",
        priority: "High",
        createdDate: "2 hours ago",
        status: "Open",
      ),
      SupportTicketItem(
        id: "#TICK-8104",
        subject: "Candidate resume parsing delay on PDF uploads",
        category: "Candidates",
        priority: "Medium",
        createdDate: "Yesterday",
        status: "Pending",
      ),
      SupportTicketItem(
        id: "#TICK-7933",
        subject: "Custom email template placeholder formatting",
        category: "Recruitment",
        priority: "Low",
        createdDate: "July 22, 2026",
        status: "Resolved",
      ),
      SupportTicketItem(
        id: "#TICK-7410",
        subject: "Adding new hiring manager role permissions",
        category: "Team Management",
        priority: "Medium",
        createdDate: "July 15, 2026",
        status: "Closed",
      ),
    ];
    notifyListeners();
  }

  // Language & Accessibility Methods
  void updateLanguageAccessibility({
    String? language,
    String? country,
    String? dateFormat,
    String? timeFormat,
    String? numberFormat,
    String? firstDayOfWeek,
    String? timezone,
    double? textSize,
    String? textSizeLbl,
    String? colorMode,
    String? animationSpeed,
    String? lineSpacing,
    String? fontWeight,
    String? cardDensity,
    String? iconSize,
  }) {
    if (language != null) currentLanguage = language;
    if (country != null) regionalCountry = country;
    if (dateFormat != null) regionalDateFormat = dateFormat;
    if (timeFormat != null) regionalTimeFormat = timeFormat;
    if (numberFormat != null) regionalNumberFormat = numberFormat;
    if (firstDayOfWeek != null) regionalFirstDayOfWeek = firstDayOfWeek;
    if (timezone != null) regionalTimezone = timezone;
    if (textSize != null) textSizeScale = textSize;
    if (textSizeLbl != null) textSizeLabel = textSizeLbl;
    if (colorMode != null) colorAccessibilityMode = colorMode;
    if (animationSpeed != null) animSpeed = animationSpeed;
    if (lineSpacing != null) readabilityLineSpacing = lineSpacing;
    if (fontWeight != null) readabilityFontWeight = fontWeight;
    if (cardDensity != null) readabilityCardDensity = cardDensity;
    if (iconSize != null) readabilityIconSize = iconSize;
    notifyListeners();
  }

  void toggleDisplayOption(String key, bool val) {
    switch (key) {
      case 'contrast': displayHighContrast = val; break;
      case 'motion': displayReduceMotion = val; animReduceMotion = val; break;
      case 'buttons': displayLargeButtons = val; break;
      case 'compact': displayCompactLayout = val; break;
      case 'tooltips': displayShowTooltips = val; break;
    }
    notifyListeners();
  }

  void toggleAccessibilityFeature(String key, bool val) {
    switch (key) {
      case 'reader': accessScreenReader = val; break;
      case 'labels': accessAccessibleLabels = val; break;
      case 'keyboard': accessKeyboardNav = val; break;
      case 'focus': accessFocusIndicators = val; break;
      case 'voice': accessVoiceAssistance = val; break;
    }
    notifyListeners();
  }

  void toggleAnimationSetting(String key, bool val) {
    switch (key) {
      case 'enabled': animEnabled = val; break;
      case 'motion': animReduceMotion = val; displayReduceMotion = val; break;
    }
    notifyListeners();
  }

  void resetLanguageAccessibilityToDefaults() {
    currentLanguage = "English (US)";
    regionalCountry = "India";
    regionalDateFormat = "DD/MM/YYYY";
    regionalTimeFormat = "24-Hour (14:30)";
    regionalNumberFormat = "12,34,567.89 (Indian Lakhs/Crores)";
    regionalFirstDayOfWeek = "Monday";
    regionalTimezone = "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi";
    textSizeScale = 1.0;
    textSizeLabel = "Medium (Standard)";
    displayHighContrast = false;
    displayReduceMotion = false;
    displayLargeButtons = false;
    displayCompactLayout = false;
    displayShowTooltips = true;
    accessScreenReader = false;
    accessAccessibleLabels = true;
    accessKeyboardNav = true;
    accessFocusIndicators = true;
    accessVoiceAssistance = false;
    colorAccessibilityMode = "Default Colors";
    animEnabled = true;
    animReduceMotion = false;
    animSpeed = "1.0x Standard";
    readabilityLineSpacing = "1.5x Standard";
    readabilityFontWeight = "Medium (500)";
    readabilityCardDensity = "Standard";
    readabilityIconSize = "Medium (24px)";
    notifyListeners();
  }

  // Biometric & Device Security Methods
  void toggleTrustedDevicesEmptyState() {
    isTrustedDevicesEmpty = !isTrustedDevicesEmpty;
    notifyListeners();
  }

  void registerCurrentDeviceAsTrusted() {
    isTrustedDevicesEmpty = false;
    if (trustedDevicesList.isEmpty) {
      trustedDevicesList = [
        SecuritySessionItem(
          id: "dev_mac_01",
          deviceName: "MacBook Pro M3 Max",
          platform: "macOS Sonoma 14.5",
          browser: "Chrome Enterprise 126.0",
          loginTime: "Active Now",
          location: "Bangalore, India (66.249.79.1)",
          isCurrentDevice: true,
          deviceType: "Workstation",
          status: "Current Device",
        ),
      ];
    }
    notifyListeners();
  }

  void removeTrustedDevice(String id) {
    trustedDevicesList.removeWhere((item) => item.id == id);
    if (trustedDevicesList.isEmpty) {
      isTrustedDevicesEmpty = true;
    }
    notifyListeners();
  }

  void removeAllTrustedDevices() {
    trustedDevicesList.clear();
    isTrustedDevicesEmpty = true;
    notifyListeners();
  }

  void disableAllBiometrics() {
    bioFingerprintEnabled = false;
    bioFaceUnlockEnabled = false;
    bioPasscodeEnabled = false;
    notifyListeners();
  }

  void updateDeviceSecuritySetting({
    bool? fingerprint,
    bool? faceUnlock,
    bool? passcode,
    String? appLockTimeout,
    String? autoLockInactivity,
    bool? protectBilling,
    bool? protectSubscription,
    bool? protectDelete,
    bool? protectExport,
    bool? protectVerification,
    bool? protectSecurity,
    bool? alertEmail,
    bool? alertPush,
    bool? alertSms,
    bool? alertWarning,
    bool? sessionLogout,
    bool? sessionRemember,
    bool? sessionRequireLogin,
  }) {
    if (fingerprint != null) bioFingerprintEnabled = fingerprint;
    if (faceUnlock != null) bioFaceUnlockEnabled = faceUnlock;
    if (passcode != null) bioPasscodeEnabled = passcode;
    if (appLockTimeout != null) bioAppLockTimeout = appLockTimeout;
    if (autoLockInactivity != null) bioAutoLockInactivity = autoLockInactivity;
    if (protectBilling != null) bioProtectBilling = protectBilling;
    if (protectSubscription != null) bioProtectSubscription = protectSubscription;
    if (protectDelete != null) bioProtectDeleteAccount = protectDelete;
    if (protectExport != null) bioProtectDataExport = protectExport;
    if (protectVerification != null) bioProtectVerification = protectVerification;
    if (protectSecurity != null) bioProtectSecuritySettings = protectSecurity;
    if (alertEmail != null) bioAlertEmail = alertEmail;
    if (alertPush != null) bioAlertPush = alertPush;
    if (alertSms != null) bioAlertSms = alertSms;
    if (alertWarning != null) bioAlertWarning = alertWarning;
    if (sessionLogout != null) bioSessionAutoLogout = sessionLogout;
    if (sessionRemember != null) bioSessionRememberDevice = sessionRemember;
    if (sessionRequireLogin != null) bioSessionRequireLoginAgain = sessionRequireLogin;
    notifyListeners();
  }

  void resetDeviceSecurityToDefaults() {
    isTrustedDevicesEmpty = false;
    bioFingerprintEnabled = true;
    bioFaceUnlockEnabled = true;
    bioPasscodeEnabled = false;
    bioAppLockTimeout = "After 5 Minutes";
    bioAutoLockInactivity = "10 Minutes";
    bioProtectBilling = true;
    bioProtectSubscription = true;
    bioProtectDeleteAccount = true;
    bioProtectDataExport = true;
    bioProtectVerification = false;
    bioProtectSecuritySettings = true;
    bioAlertEmail = true;
    bioAlertPush = true;
    bioAlertSms = false;
    bioAlertWarning = true;
    bioSessionAutoLogout = false;
    bioSessionRememberDevice = true;
    bioSessionRequireLoginAgain = false;
    trustedDevicesList = [
      SecuritySessionItem(
        id: "dev_mac_01",
        deviceName: "MacBook Pro M3 Max",
        platform: "macOS Sonoma 14.5",
        browser: "Chrome Enterprise 126.0",
        loginTime: "Active Now",
        location: "Bangalore, India (66.249.79.1)",
        isCurrentDevice: true,
        deviceType: "Workstation",
        status: "Current Device",
      ),
      SecuritySessionItem(
        id: "dev_ip_02",
        deviceName: "iPhone 15 Pro Max",
        platform: "iOS 17.5.1",
        browser: "JobNest Mobile Enterprise v4.2",
        loginTime: "2 hours ago",
        location: "Bangalore, India (103.21.244.0)",
        isCurrentDevice: false,
        deviceType: "Mobile Device",
        status: "Trusted Device",
      ),
      SecuritySessionItem(
        id: "dev_win_03",
        deviceName: "Dell XPS 15 Workstation",
        platform: "Windows 11 Enterprise",
        browser: "Microsoft Edge 125.0",
        loginTime: "Yesterday at 18:40 IST",
        location: "Hyderabad, India (49.248.15.0)",
        isCurrentDevice: false,
        deviceType: "Workstation",
        status: "Trusted Device",
      ),
    ];
    notifyListeners();
  }

  Future<void> refreshProfile() async {
    isLoading = true;
    isError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    isLoading = false;
    notifyListeners();
  }

  void simulateLoading() {
    isLoading = true;
    isError = false;
    notifyListeners();
  }

  void simulateError() {
    isLoading = false;
    isError = true;
    notifyListeners();
  }

  void simulateEmpty() {
    isLoading = false;
    isError = false;
    isEmpty = true;
    notifyListeners();
  }

  void restoreDefaults() {
    isLoading = false;
    isError = false;
    isEmpty = false;
    fullName = "Sonu Surya";
    designation = "Senior Tech Recruiter";
    companyName = "TechNova Solutions";
    email = "sonusurya@technova.com";
    phone = "+91 98765 43210";
    completenessPercentage = 85;
    missingItems = [
      "Company Logo",
      "Phone Number Verification",
      "Recruiter Bio",
    ];
    industry = "Software & Technology";
    companySize = "500 - 1000 Employees";
    website = "https://technova.dev";
    headquarters = "Koramangala, Bangalore";
    foundedYear = "2015";
    officialPhone = "+91 80 4123 4567";
    officeAddress = "Plot 42, Cyber Park, Electronic City Phase 1";
    city = "Bangalore";
    state = "Karnataka";
    country = "India";
    companyPan = "AAACT1234K";
    companyTan = "BLRT12345F";
    companyOverview = "TechNova Solutions is a global leader in AI-driven HR technology and enterprise workforce automation.";
    companyDescription = "Founded in 2015, we empower Fortune 500 companies to streamline their talent acquisition pipelines, reduce hiring bias, and enhance recruiter productivity through intelligent matching algorithms.";
    missionStatement = "To revolutionize global recruitment by connecting talent with opportunity through transparent, AI-empowered workflows.";
    visionStatement = "To become the world's most trusted recruitment operating system by 2030.";
    workCulture = "We thrive in a collaborative, remote-first environment where autonomy, continuous learning, and innovation are celebrated daily.";
    companyValues = "1. Customer Obsession\n2. Radical Transparency\n3. Relentless Innovation\n4. Diversity & Inclusion";
    isCompanyMediaEmpty = false;
    isTeamEmpty = false;
    teamSearchQuery = "";
    teamRoleFilter = "All";
    teamMembers = [
      TeamMemberItem(
        id: "1",
        name: "Sonu Surya",
        email: "sonusurya@technova.com",
        role: "Admin",
        status: "Active",
        permissions: getDefaultPermissionsForRole("Admin"),
      ),
      TeamMemberItem(
        id: "2",
        name: "Ananya Sharma",
        email: "ananya.s@technova.com",
        role: "HR Manager",
        status: "Active",
        permissions: getDefaultPermissionsForRole("HR Manager"),
      ),
      TeamMemberItem(
        id: "3",
        name: "Rahul Verma",
        email: "rahul.v@technova.com",
        role: "Recruiter",
        status: "Active",
        hasCustomPermissions: true,
        permissions: getDefaultPermissionsForRole("Recruiter").map((p) {
          if (p.category == "Jobs") {
            return p.copyWith(canDelete: false);
          }
          if (p.category == "Candidates") {
            return p.copyWith(canEdit: true);
          }
          return p;
        }).toList(),
      ),
      TeamMemberItem(
        id: "4",
        name: "Vikram Singhania",
        email: "vikram.s@technova.com",
        role: "Hiring Manager",
        status: "Active",
        permissions: getDefaultPermissionsForRole("Hiring Manager"),
      ),
      TeamMemberItem(
        id: "5",
        name: "Priya Patel",
        email: "priya.p@technova.com",
        role: "Viewer",
        status: "Invited",
        permissions: getDefaultPermissionsForRole("Viewer"),
      ),
    ];
    isVerificationEmpty = false;
    verificationItems = [
      VerificationItem(
        id: "val_email",
        title: "Recruiter Email",
        type: "Recruiter",
        status: "Verified",
        description: "Official work email address verified via enterprise domain OTP.",
        lastUpdated: "2 days ago",
      ),
      VerificationItem(
        id: "val_phone",
        title: "Recruiter Phone",
        type: "Recruiter",
        status: "Verified",
        description: "Direct mobile contact verified via SMS authentication gateway.",
        lastUpdated: "5 days ago",
      ),
      VerificationItem(
        id: "val_comp_email",
        title: "Company Email",
        type: "Company",
        status: "Verified",
        description: "Corporate domain ownership verified via DNS TXT record matching.",
        lastUpdated: "1 week ago",
      ),
      VerificationItem(
        id: "val_comp_web",
        title: "Company Website",
        type: "Company",
        status: "Verified",
        description: "Official website domain verified via SSL handshake & site meta tag.",
        lastUpdated: "1 week ago",
      ),
      VerificationItem(
        id: "val_comp_reg",
        title: "Company Registration",
        type: "Company",
        status: "Verified",
        description: "Certificate of Incorporation cross-referenced with business registry.",
        lastUpdated: "2 weeks ago",
      ),
      VerificationItem(
        id: "val_comp_pan",
        title: "Company PAN",
        type: "Company",
        status: "Verified",
        description: "Permanent Account Number validated against national tax records.",
        lastUpdated: "Yesterday",
      ),
      VerificationItem(
        id: "val_comp_addr",
        title: "Company Address",
        type: "Company",
        status: "Not Verified",
        description: "Physical headquarters proof requiring utility bill or lease agreement.",
        lastUpdated: "Never",
      ),
    ];
    documentPlaceholders = [
      DocumentPlaceholderItem(
        id: "doc_reg",
        name: "Company Registration",
        type: "Certificate of Incorporation / Reg. Deed",
        status: "Uploaded",
        lastUpdated: "2 weeks ago",
      ),
      DocumentPlaceholderItem(
        id: "doc_pan",
        name: "PAN",
        type: "Corporate Permanent Account Number",
        status: "Pending Review",
        lastUpdated: "Yesterday",
      ),
      DocumentPlaceholderItem(
        id: "doc_gst",
        name: "GST",
        type: "Goods & Services Tax Registration Certificate",
        status: "Uploaded",
        lastUpdated: "1 week ago",
      ),
      DocumentPlaceholderItem(
        id: "doc_lic",
        name: "Business License",
        type: "Municipal / Industry Operations License",
        status: "Not Uploaded",
        lastUpdated: "Never",
      ),
      DocumentPlaceholderItem(
        id: "doc_addr",
        name: "Office Proof",
        type: "Utility Bill / Lease Agreement (< 3 months old)",
        status: "Not Uploaded",
        lastUpdated: "Never",
      ),
    ];
    isSubscriptionEmpty = false;
    isSubscriptionTrial = false;
    currentPlanName = "Business Edition";
    currentPlanStatus = "Active";
    billingCycle = "Monthly Billing (Renews automatically)";
    renewalDate = "November 1, 2026";
    activeSince = "January 15, 2025";
    planExpiry = "November 1, 2026";
    trialDaysRemaining = 14;
    planLimits = [
      PlanLimitItem(name: "Active Job Limit", currentUsage: 18, maxLimit: 50, unit: "Jobs"),
      PlanLimitItem(name: "Candidate Database Limit", currentUsage: 640, maxLimit: 1000, unit: "Candidates"),
      PlanLimitItem(name: "Recruiter Seats", currentUsage: 4, maxLimit: 15, unit: "Seats"),
      PlanLimitItem(name: "Resume Downloads", currentUsage: 125, maxLimit: 250, unit: "Downloads"),
      PlanLimitItem(name: "AI Credits", currentUsage: 820, maxLimit: 1500, unit: "Credits"),
      PlanLimitItem(name: "Priority Support", currentUsage: 1, maxLimit: 1, unit: "24/7 SLA"),
    ];
    availablePlans = [
      SubscriptionPlanItem(
        id: "plan_starter",
        name: "Starter",
        monthlyPrice: "\$99 / mo",
        featureSummary: "Essential recruitment tools for boutique hiring teams and independent recruiters.",
        recruiterSeats: "2 Seats",
        jobPostingLimit: "10 Active Jobs",
        candidateLimit: "500 Candidates",
        aiFeatures: "Basic AI Matching",
        supportLevel: "Email Support",
        isCurrentPlan: false,
      ),
      SubscriptionPlanItem(
        id: "plan_prof",
        name: "Professional",
        monthlyPrice: "\$299 / mo",
        featureSummary: "Advanced sourcing and automated pipeline tracking for growing businesses.",
        recruiterSeats: "5 Seats",
        jobPostingLimit: "30 Active Jobs",
        candidateLimit: "2,500 Candidates",
        aiFeatures: "Advanced AI Ranking",
        supportLevel: "24/5 Live Chat",
        isCurrentPlan: false,
      ),
      SubscriptionPlanItem(
        id: "plan_biz",
        name: "Business Edition",
        monthlyPrice: "\$599 / mo",
        featureSummary: "Full enterprise recruiting suite with priority SLA and team role management.",
        recruiterSeats: "15 Seats",
        jobPostingLimit: "50 Active Jobs",
        candidateLimit: "1,000 Candidates",
        aiFeatures: "Full AI Suite & Sourcing",
        supportLevel: "24/7 Priority SLA",
        isCurrentPlan: true,
      ),
      SubscriptionPlanItem(
        id: "plan_ent",
        name: "Enterprise",
        monthlyPrice: "\$999 / mo",
        featureSummary: "Custom enterprise deployment with unlimited scalability and dedicated support.",
        recruiterSeats: "Unlimited",
        jobPostingLimit: "Unlimited",
        candidateLimit: "Unlimited",
        aiFeatures: "Custom AI Models",
        supportLevel: "Dedicated Success Manager",
        isCurrentPlan: false,
      ),
    ];
    billingHistory = [
      InvoiceItem(invoiceId: "INV-2026-1001", billingDate: "Oct 01, 2026", amount: "\$599.00", status: "Paid"),
      InvoiceItem(invoiceId: "INV-2026-0901", billingDate: "Sep 01, 2026", amount: "\$599.00", status: "Paid"),
      InvoiceItem(invoiceId: "INV-2026-0801", billingDate: "Aug 01, 2026", amount: "\$599.00", status: "Refunded"),
      InvoiceItem(invoiceId: "INV-2026-0701", billingDate: "Jul 01, 2026", amount: "\$599.00", status: "Failed"),
      InvoiceItem(invoiceId: "INV-2026-0601", billingDate: "Jun 01, 2026", amount: "\$599.00", status: "Paid"),
    ];
    paymentMethods = [
      PaymentMethodPlaceholderItem(
        id: "pay_card",
        type: "Credit/Debit Card",
        title: "Visa ending in •••• 4242",
        subtitle: "Expires 08/28 • Corporate Billing",
        icon: Icons.credit_card_rounded,
        isDefault: true,
      ),
      PaymentMethodPlaceholderItem(
        id: "pay_upi",
        type: "UPI",
        title: "technova.recruiting@okaxis",
        subtitle: "Instant bank transfer via verified UPI ID",
        icon: Icons.qr_code_2_rounded,
        isDefault: false,
      ),
      PaymentMethodPlaceholderItem(
        id: "pay_net",
        type: "Net Banking",
        title: "HDFC Corporate Banking",
        subtitle: "Direct enterprise treasury account debit",
        icon: Icons.account_balance_rounded,
        isDefault: false,
      ),
      PaymentMethodPlaceholderItem(
        id: "pay_wallet",
        type: "Wallet",
        title: "JobNest Enterprise Credits Wallet",
        subtitle: "Balance: \$1,250.00 available credit",
        icon: Icons.account_balance_wallet_rounded,
        isDefault: false,
      ),
    ];
    isCommunicationEmpty = false;
    quietHoursEnabled = true;
    quietHoursStartTime = "10:00 PM";
    quietHoursEndTime = "08:00 AM";
    quietHoursTimezone = "(UTC+05:30) India Standard Time";
    muteNonUrgentDuringQuietHours = true;
    sigRecruiterName = "Kunal Sharma";
    sigDesignation = "Senior Technical Recruiter & Lead Talent Partner";
    sigCompanyName = "TechNova Innovations & Cloud Systems India";
    sigPhone = "+91 98765 43210";
    sigWebsite = "https://careers.technova.com";
    communicationLanguage = "English (United States)";
    communicationChannels = [
      CommunicationChannelItem(
        id: "chan_email",
        name: "Email",
        description: "Send automated transactional emails and requisition updates",
        icon: Icons.email_outlined,
        isEnabled: true,
      ),
      CommunicationChannelItem(
        id: "chan_sms",
        name: "SMS",
        description: "Instant text alerts for time-sensitive interview reminders",
        icon: Icons.sms_outlined,
        isEnabled: true,
      ),
      CommunicationChannelItem(
        id: "chan_push",
        name: "Push Notifications",
        description: "Real-time mobile app push alerts for candidate activities",
        icon: Icons.notifications_active_outlined,
        isEnabled: true,
      ),
      CommunicationChannelItem(
        id: "chan_whatsapp",
        name: "WhatsApp",
        description: "Direct WhatsApp Business API messaging for fast engagement",
        icon: Icons.chat_rounded,
        isEnabled: false,
      ),
      CommunicationChannelItem(
        id: "chan_inapp",
        name: "In-App Messages",
        description: "Internal portal notifications and candidate chat interface",
        icon: Icons.inbox_outlined,
        isEnabled: true,
      ),
    ];
    candidateCommunicationSettings = [
      CommunicationSettingItem(
        id: "cand_app_rec",
        title: "Application Received Message",
        description: "Send automatic confirmation when candidate submits application",
        category: "Candidate",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "cand_inv_inv",
        title: "Interview Invitation",
        description: "Dispatch calendar invites and interview meeting links",
        category: "Candidate",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "cand_inv_rem",
        title: "Interview Reminder",
        description: "Send automated reminder 24h and 1h prior to interview",
        category: "Candidate",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "cand_off_not",
        title: "Offer Letter Notification",
        description: "Notify candidate immediately upon formal offer extension",
        category: "Candidate",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "cand_rej_not",
        title: "Rejection Notification",
        description: "Send professional, respectful update when status changes to Rejected",
        category: "Candidate",
        isEnabled: false,
      ),
      CommunicationSettingItem(
        id: "cand_fol_rem",
        title: "Follow-up Reminder",
        description: "Nudge candidates who haven't responded to interview requests within 48 hours",
        category: "Candidate",
        isEnabled: true,
      ),
    ];
    teamCommunicationSettings = [
      CommunicationSettingItem(
        id: "team_job_cre",
        title: "New Job Created",
        description: "Notify hiring managers and recruiters when a requisition is published",
        category: "Team",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "team_cand_ass",
        title: "Candidate Assigned",
        description: "Alert team member when a candidate is assigned to their review pipeline",
        category: "Team",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "team_inv_sch",
        title: "Interview Scheduled",
        description: "Broadcast interview confirmation to panel members",
        category: "Team",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "team_feed_rem",
        title: "Interview Feedback Reminder",
        description: "Prompt interviewers to submit scorecard ratings within 2 hours post-interview",
        category: "Team",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "team_mentions",
        title: "Team Mentions",
        description: "Receive immediate notification when mentioned in candidate notes or comments",
        category: "Team",
        isEnabled: true,
      ),
      CommunicationSettingItem(
        id: "team_announce",
        title: "Internal Announcements",
        description: "Important corporate updates, SLA alerts, and system maintenance notes",
        category: "Team",
        isEnabled: true,
      ),
    ];
    automatedMessages = [
      AutomatedMessageTemplateItem(
        id: "auto_reply",
        title: "Auto Reply",
        trigger: "Triggered when receiving candidate inquiries outside business hours",
        templateBody: "Hi {candidate_name}, thank you for reaching out to {company_name}. Our recruitment team is currently offline. We have received your message and will get back to you within 1 business day.",
        isEnabled: true,
      ),
      AutomatedMessageTemplateItem(
        id: "auto_inv_rem",
        title: "Interview Reminder",
        trigger: "Triggered 24 hours prior to scheduled interview session",
        templateBody: "Dear {candidate_name}, this is a friendly reminder for your upcoming {interview_type} interview for {job_title} tomorrow at {time}. Please ensure you have tested your audio/video link.",
        isEnabled: true,
      ),
      AutomatedMessageTemplateItem(
        id: "auto_app_ack",
        title: "Application Acknowledgement",
        trigger: "Triggered immediately upon successful application submission",
        templateBody: "Hello {candidate_name}, we are excited to receive your application for {job_title} at {company_name}! Our talent acquisition team is reviewing your profile and will update you soon.",
        isEnabled: true,
      ),
      AutomatedMessageTemplateItem(
        id: "auto_thank_you",
        title: "Thank You Message",
        trigger: "Triggered after interview scorecard completion",
        templateBody: "Dear {candidate_name}, thank you for taking the time to interview with {company_name} today. We appreciated learning about your experience and will be in touch with next steps shortly.",
        isEnabled: true,
      ),
    ];
    resetJobPreferencesToDefault();
    resetSecurityToDefaults();
    resetDataManagementToDefaults();
    resetSupportToDefaults();
    resetLanguageAccessibilityToDefaults();
    resetDeviceSecurityToDefaults();
  }
}

class PermissionItem {
  final String category;
  bool canView;
  bool canCreate;
  bool canEdit;
  bool canDelete;

  PermissionItem({
    required this.category,
    this.canView = false,
    this.canCreate = false,
    this.canEdit = false,
    this.canDelete = false,
  });

  PermissionItem copyWith({
    bool? canView,
    bool? canCreate,
    bool? canEdit,
    bool? canDelete,
  }) {
    return PermissionItem(
      category: category,
      canView: canView ?? this.canView,
      canCreate: canCreate ?? this.canCreate,
      canEdit: canEdit ?? this.canEdit,
      canDelete: canDelete ?? this.canDelete,
    );
  }
}

class TeamMemberItem {
  final String id;
  String name;
  String email;
  String role;
  String status;
  String avatarUrl;
  bool hasCustomPermissions;
  List<PermissionItem> permissions;

  TeamMemberItem({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.status = "Active",
    this.avatarUrl = "",
    this.hasCustomPermissions = false,
    required this.permissions,
  });
}

class RoleSummary {
  final String name;
  final String description;
  final String permissionSummary;
  final int memberCount;

  RoleSummary({
    required this.name,
    required this.description,
    required this.permissionSummary,
    required this.memberCount,
  });
}

List<PermissionItem> getDefaultPermissionsForRole(String role) {
  final categories = [
    "Dashboard",
    "Jobs",
    "Candidates",
    "Interviews",
    "Reports",
    "Notifications",
    "Company Settings",
    "Team Management",
    "Billing",
    "Security",
  ];

  return categories.map((cat) {
    if (role == "Admin") {
      return PermissionItem(category: cat, canView: true, canCreate: true, canEdit: true, canDelete: true);
    } else if (role == "HR Manager") {
      final isCore = ["Dashboard", "Jobs", "Candidates", "Interviews", "Reports", "Notifications", "Team Management"].contains(cat);
      return PermissionItem(
        category: cat,
        canView: true,
        canCreate: isCore,
        canEdit: isCore,
        canDelete: isCore,
      );
    } else if (role == "Recruiter") {
      final isCore = ["Dashboard", "Jobs", "Candidates", "Interviews", "Notifications"].contains(cat);
      return PermissionItem(
        category: cat,
        canView: isCore || cat == "Reports",
        canCreate: isCore,
        canEdit: isCore,
        canDelete: isCore,
      );
    } else if (role == "Hiring Manager") {
      final isCore = ["Dashboard", "Jobs", "Candidates", "Interviews", "Notifications"].contains(cat);
      return PermissionItem(
        category: cat,
        canView: isCore,
        canCreate: false,
        canEdit: isCore,
        canDelete: false,
      );
    } else {
      final isCore = ["Dashboard", "Jobs", "Candidates", "Interviews", "Reports", "Notifications"].contains(cat);
      return PermissionItem(
        category: cat,
        canView: isCore,
        canCreate: false,
        canEdit: false,
        canDelete: false,
      );
    }
  }).toList();
}

class VerificationItem {
  final String id;
  final String title;
  final String type;
  String status;
  final String description;
  final String lastUpdated;

  VerificationItem({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.description,
    required this.lastUpdated,
  });
}

class DocumentPlaceholderItem {
  final String id;
  final String name;
  final String type;
  String status;
  final String lastUpdated;

  DocumentPlaceholderItem({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.lastUpdated,
  });
}

class SubscriptionPlanItem {
  final String id;
  final String name;
  final String monthlyPrice;
  final String featureSummary;
  final String recruiterSeats;
  final String jobPostingLimit;
  final String candidateLimit;
  final String aiFeatures;
  final String supportLevel;
  final bool isCurrentPlan;

  SubscriptionPlanItem({
    required this.id,
    required this.name,
    required this.monthlyPrice,
    required this.featureSummary,
    required this.recruiterSeats,
    required this.jobPostingLimit,
    required this.candidateLimit,
    required this.aiFeatures,
    required this.supportLevel,
    this.isCurrentPlan = false,
  });
}

class PlanLimitItem {
  final String name;
  final int currentUsage;
  final int maxLimit;
  final String unit;

  PlanLimitItem({
    required this.name,
    required this.currentUsage,
    required this.maxLimit,
    this.unit = "",
  });
}

class InvoiceItem {
  final String invoiceId;
  final String billingDate;
  final String amount;
  String status;

  InvoiceItem({
    required this.invoiceId,
    required this.billingDate,
    required this.amount,
    required this.status,
  });
}

class PaymentMethodPlaceholderItem {
  final String id;
  final String type;
  final String title;
  final String subtitle;
  final IconData icon;
  bool isDefault;

  PaymentMethodPlaceholderItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDefault = false,
  });
}

class CommunicationChannelItem {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  bool isEnabled;

  CommunicationChannelItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isEnabled = true,
  });
}

class CommunicationSettingItem {
  final String id;
  final String title;
  final String description;
  final String category;
  bool isEnabled;

  CommunicationSettingItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isEnabled = true,
  });
}

class AutomatedMessageTemplateItem {
  final String id;
  final String title;
  final String trigger;
  String templateBody;
  bool isEnabled;

  AutomatedMessageTemplateItem({
    required this.id,
    required this.title,
    required this.trigger,
    required this.templateBody,
    this.isEnabled = true,
  });
}

class SecurityActivityItem {
  final String id;
  final String deviceName;
  final String browser;
  final String os;
  final String loginTime;
  final String location;
  final String status;

  SecurityActivityItem({
    required this.id,
    required this.deviceName,
    required this.browser,
    required this.os,
    required this.loginTime,
    required this.location,
    required this.status,
  });
}

class SecuritySessionItem {
  final String id;
  final String deviceName;
  final String platform;
  final String browser;
  final String loginTime;
  final String location;
  final bool isCurrentDevice;
  final String deviceType;
  final String status;

  SecuritySessionItem({
    required this.id,
    required this.deviceName,
    required this.platform,
    required this.browser,
    required this.loginTime,
    required this.location,
    required this.isCurrentDevice,
    this.deviceType = "Workstation",
    this.status = "Current Device",
  });
}

class SupportTicketItem {
  final String id;
  final String subject;
  final String category;
  final String priority;
  final String createdDate;
  final String status;

  SupportTicketItem({
    required this.id,
    required this.subject,
    required this.category,
    required this.priority,
    required this.createdDate,
    required this.status,
  });
}
