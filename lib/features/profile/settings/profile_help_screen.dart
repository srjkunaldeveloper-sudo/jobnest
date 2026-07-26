import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';

class ProfileHelpScreen extends StatefulWidget {
  const ProfileHelpScreen({super.key});

  @override
  State<ProfileHelpScreen> createState() => _ProfileHelpScreenState();
}

class _ProfileHelpScreenState extends State<ProfileHelpScreen> {
  // Report Problem Form State
  String _problemCategory = "Billing";
  final TextEditingController _problemSubjectController =
      TextEditingController();
  final TextEditingController _problemDescController = TextEditingController();
  bool _hasAttachment = false;

  // Feature Request Form State
  final TextEditingController _featureTitleController = TextEditingController();
  final TextEditingController _featureDescController = TextEditingController();
  String _featurePriority = "Medium Impact";

  // Star Rating State
  int _selectedStars = 5;

  final List<String> _helpCategories = [
    "Recruitment",
    "Jobs",
    "Candidates",
    "Interviews",
    "Billing",
    "Subscription",
    "Verification",
    "Security",
    "Team Management",
    "Company Profile",
  ];

  @override
  void dispose() {
    _problemSubjectController.dispose();
    _problemDescController.dispose();
    _featureTitleController.dispose();
    _featureDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Fetch FAQs.

    // TODO:
    // Support ticket API.

    // TODO:
    // Live chat integration.

    // TODO:
    // Feedback API.

    // TODO:
    // Feature request API.

    // TODO:
    // Knowledge base integration.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support Center"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              provider.toggleSupportHistoryEmptyState();
              _showFeedback(
                context,
                provider.isSupportHistoryEmpty
                    ? "Switched to QA Empty Support Ticket State"
                    : "Restored QA Populated Ticket History",
              );
            },
            icon: Icon(
              provider.isSupportHistoryEmpty
                  ? Icons.confirmation_number_outlined
                  : Icons.confirmation_number_rounded,
              color: provider.isSupportHistoryEmpty
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
            ),
            tooltip: "Toggle Empty Ticket History (QA)",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Support Overview
                _buildSectionHeader(
                  theme,
                  "Enterprise Support Overview",
                  "Real-time SLA status, priority response times, and active ticket diagnostics.",
                  Icons.support_agent_rounded,
                ),
                const SizedBox(height: 14),
                _buildSupportOverviewCard(context, provider),
                const SizedBox(height: 32),

                // Section 2: Quick Actions
                _buildSectionHeader(
                  theme,
                  "Support Quick Actions",
                  "Connect instantly with priority recruiter specialists and community channels.",
                  Icons.bolt_rounded,
                ),
                const SizedBox(height: 14),
                _buildQuickActionsCard(context),
                const SizedBox(height: 32),

                // Section 3: Help Categories
                _buildSectionHeader(
                  theme,
                  "Knowledge Base Categories",
                  "Browse specialized documentation across all JobNest enterprise modules.",
                  Icons.category_outlined,
                ),
                const SizedBox(height: 14),
                _buildHelpCategoriesCard(context),
                const SizedBox(height: 32),

                // Section 4: FAQ Section
                _buildSectionHeader(
                  theme,
                  "Frequently Asked Questions",
                  "Quick answers to common recruiter workflows and platform administration.",
                  Icons.question_answer_outlined,
                ),
                const SizedBox(height: 14),
                _buildFaqSection(context),
                const SizedBox(height: 32),

                // Section 5: Guides & Tutorials
                _buildSectionHeader(
                  theme,
                  "Interactive Guides & Tutorials",
                  "Step-by-step masterclasses to maximize your talent acquisition velocity.",
                  Icons.menu_book_rounded,
                ),
                const SizedBox(height: 14),
                _buildGuidesSection(context),
                const SizedBox(height: 32),

                // Section 6: Support Tickets
                _buildSectionHeader(
                  theme,
                  "Support Ticket History",
                  "Track active enterprise inquiries, SLA status, and engineering resolutions.",
                  Icons.confirmation_number_outlined,
                ),
                const SizedBox(height: 14),
                _buildSupportTicketsSection(context, provider),
                const SizedBox(height: 32),

                // Section 7: Report a Problem Form
                _buildSectionHeader(
                  theme,
                  "Report a Problem",
                  "Submit priority support inquiries directly to our enterprise engineering desk.",
                  Icons.bug_report_outlined,
                ),
                const SizedBox(height: 14),
                _buildReportProblemCard(context, provider),
                const SizedBox(height: 32),

                // Section 8: Feature Request
                _buildSectionHeader(
                  theme,
                  "Suggest a Feature Request",
                  "Share your vision to shape the future roadmap of JobNest Enterprise.",
                  Icons.lightbulb_outline_rounded,
                ),
                const SizedBox(height: 14),
                _buildFeatureRequestCard(context),
                const SizedBox(height: 32),

                // Section 9: App Information
                _buildSectionHeader(
                  theme,
                  "Application & System Information",
                  "Version diagnostics, deployment environment, and build telemetry.",
                  Icons.info_outline_rounded,
                ),
                const SizedBox(height: 14),
                _buildAppInfoCard(context),
                const SizedBox(height: 32),

                // Section 10: Legal & Compliance
                _buildSectionHeader(
                  theme,
                  "Legal Agreements & Compliance",
                  "Review enterprise data privacy agreements, SOC2 compliance, and licensing.",
                  Icons.gavel_outlined,
                ),
                const SizedBox(height: 14),
                _buildLegalCard(context),
                const SizedBox(height: 32),

                // Section 11: Rate App
                _buildSectionHeader(
                  theme,
                  "Rate JobNest Enterprise",
                  "Share your review on product review portals or refer fellow recruiters.",
                  Icons.star_outline_rounded,
                ),
                const SizedBox(height: 14),
                _buildRateAppCard(context),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSupportOverviewCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final openTicketsCount = provider.isSupportHistoryEmpty
        ? "0"
        : "${provider.supportTicketsList.where((t) => t.status == 'Open' || t.status == 'Pending').length}";

    final items = [
      _OverviewMetric(
        title: "Support Status",
        value: "24x7 Priority",
        subtitle: "Enterprise SLA Active",
        icon: Icons.verified_user_rounded,
        color: Colors.green,
      ),
      _OverviewMetric(
        title: "Avg Response Time",
        value: "< 15 Mins",
        subtitle: "Dedicated recruiter desk",
        icon: Icons.timer_rounded,
        color: Colors.blue,
      ),
      _OverviewMetric(
        title: "Active Tickets",
        value: openTicketsCount,
        subtitle: provider.isSupportHistoryEmpty
            ? "No open support inquiries"
            : "Inquiries in progress",
        icon: Icons.confirmation_number_rounded,
        color: Colors.purple,
      ),
      _OverviewMetric(
        title: "Knowledge Base",
        value: "45+ Guides",
        subtitle: "Updated for v4.2 GA",
        icon: Icons.auto_stories_rounded,
        color: Colors.amber.shade700,
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: items.map((item) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 210, maxWidth: 460),
          child: AppCard(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: item.color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.value,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    final actions = [
      _QuickActionItem(
        title: "Contact Support",
        subtitle: "Priority chat & helpline",
        icon: Icons.headset_mic_rounded,
        color: Colors.blue,
        onTap: () => _showContactSupportSheet(context),
      ),
      _QuickActionItem(
        title: "Live Chat",
        subtitle: "Connect with specialist",
        icon: Icons.chat_bubble_rounded,
        color: Colors.green,
        onTap: () => _showFeedback(
            context, "Connecting to live enterprise chat specialist..."),
      ),
      _QuickActionItem(
        title: "Raise Ticket",
        subtitle: "Submit formal inquiry",
        icon: Icons.confirmation_number_rounded,
        color: Colors.purple,
        onTap: () => _showContactSupportSheet(context),
      ),
      _QuickActionItem(
        title: "Email Support",
        subtitle: "support@jobnest.com",
        icon: Icons.email_rounded,
        color: Colors.orange,
        onTap: () => _showFeedback(
            context, "Opening email client for enterprise-support@jobnest.com"),
      ),
      _QuickActionItem(
        title: "Call Support",
        subtitle: "+1 (800) 555-NEST",
        icon: Icons.phone_in_talk_rounded,
        color: Colors.teal,
        onTap: () => _showFeedback(
            context, "Calling priority helpline +1 (800) 555-NEST..."),
      ),
      _QuickActionItem(
        title: "Community Forum",
        subtitle: "Peer recruiter network",
        icon: Icons.forum_rounded,
        color: Colors.indigo,
        onTap: () => _showFeedback(
            context, "Opening JobNest Enterprise Recruiter Community Forum"),
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: actions.map((action) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: InkWell(
              onTap: action.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: action.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(action.icon, color: action.color, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            action.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            action.subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHelpCategoriesCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select a module to view documentation & troubleshooting guides:",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _helpCategories.map((category) {
              return ActionChip(
                avatar: Icon(Icons.folder_open_rounded,
                    size: 16, color: theme.colorScheme.primary),
                label: Text(
                  category,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
                onPressed: () {
                  _showCategorySheet(context, category);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection(BuildContext context) {
    final faqs = [
      _FaqItem(
        question: "How to post a job?",
        answer:
            "Navigate to the Jobs module from the bottom navigation bar and click '+ Create Requisition'. Fill in the job title, department, employment type, salary range, and required skill tags before clicking 'Publish Requisition'.",
      ),
      _FaqItem(
        question: "How to invite recruiters?",
        answer:
            "Go to Profile > Team Management & Roles, click 'Invite Recruiter', enter their corporate email address, and assign an enterprise permission role (Admin, HR Manager, Recruiter, or Hiring Manager).",
      ),
      _FaqItem(
        question: "How to verify company?",
        answer:
            "Navigate to Profile > Verification & Trust, verify your corporate domain email, and upload official business incorporation documents or employer PAN/TAN records to receive the verified employer badge.",
      ),
      _FaqItem(
        question: "How to upgrade subscription?",
        answer:
            "Go to Profile > Subscription & Billing, compare available tiers (Growth, Professional, Enterprise), select your target plan, and click 'Upgrade Plan' to adjust billing cycles and seat allocations.",
      ),
      _FaqItem(
        question: "How to reset password?",
        answer:
            "Go to Profile > Account Security > Password Management. Enter your current password, then input a new password that includes uppercase letters, numbers, and symbols.",
      ),
      _FaqItem(
        question: "How to export data?",
        answer:
            "Navigate to Profile > Data Management & Storage. Under the 'Export Data' section, select your target file format (PDF, Excel, CSV, or JSON) and click export for candidates, jobs, or full account archives.",
      ),
      _FaqItem(
        question: "How to manage interviews?",
        answer:
            "Open a candidate profile from the Candidates or Jobs talent pipeline, switch to the 'Interviews' tab, dispatch calendar meeting invites, and complete structured scorecard evaluations after the session.",
      ),
    ];

    return Column(
      children: faqs.map((faq) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                childrenPadding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.help_outline_rounded,
                      color: Theme.of(context).colorScheme.primary, size: 20),
                ),
                title: Text(
                  faq.question,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                children: [
                  Text(
                    faq.answer,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.5,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGuidesSection(BuildContext context) {
    final guides = [
      _GuideItem(
          title: "Getting Started with JobNest",
          category: "Recruitment",
          readTime: "5 min read"),
      _GuideItem(
          title: "Create Your First Job Requisition",
          category: "Jobs",
          readTime: "3 min read"),
      _GuideItem(
          title: "Invite & Manage Team Members",
          category: "Team Management",
          readTime: "4 min read"),
      _GuideItem(
          title: "Mastering Candidate Talent Pipelines",
          category: "Candidates",
          readTime: "6 min read"),
      _GuideItem(
          title: "Structured Interview & Scorecard Workflow",
          category: "Interviews",
          readTime: "5 min read"),
      _GuideItem(
          title: "Enterprise Subscription & Seat Allocation Guide",
          category: "Subscription",
          readTime: "4 min read"),
      _GuideItem(
          title: "Company Verification & Trust Badge Setup",
          category: "Verification",
          readTime: "3 min read"),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: guides.map((guide) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 460),
          child: AppCard(
            padding: const EdgeInsets.all(18),
            child: InkWell(
              onTap: () {
                _showArticleDialog(context, guide.title, guide.category);
              },
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.menu_book_rounded,
                        color: Colors.indigo, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                guide.category,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              guide.readTime,
                              style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          guide.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSupportTicketsSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    if (provider.isSupportHistoryEmpty || provider.supportTicketsList.isEmpty) {
      return AppCard(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.confirmation_number_outlined,
                  size: 40, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              "No Support Requests Yet",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "You currently have no open or historical support ticket inquiries. If you encounter any technical issues or billing questions, our 24/7 priority recruiter team is ready to assist.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _showContactSupportSheet(context),
              icon: const Icon(Icons.headset_mic_rounded),
              label: const Text("Contact Support"),
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        ),
      );
    }

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Enterprise Inquiries (${provider.supportTicketsList.length}):",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () => _showContactSupportSheet(context),
                icon: const Icon(Icons.add_circle_outline_rounded, size: 16),
                label: const Text("Raise New Ticket"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.supportTicketsList.length,
            separatorBuilder: (ctx, i) => Divider(
                height: 24,
                color: theme.colorScheme.outline.withValues(alpha: 0.15)),
            itemBuilder: (context, index) {
              final ticket = provider.supportTicketsList[index];
              Color statusColor;
              switch (ticket.status) {
                case 'Open':
                  statusColor = Colors.green;
                  break;
                case 'Pending':
                  statusColor = Colors.orange;
                  break;
                case 'Resolved':
                  statusColor = Colors.blue;
                  break;
                default:
                  statusColor = Colors.grey;
              }

              Color priorityColor;
              switch (ticket.priority) {
                case 'High':
                  priorityColor = Colors.red;
                  break;
                case 'Medium':
                  priorityColor = Colors.orange;
                  break;
                default:
                  priorityColor = Colors.blue;
              }

              return Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 10,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              ticket.id,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                ticket.category,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: priorityColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${ticket.priority} Priority",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: priorityColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ticket.subject,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Created: ${ticket.createdDate}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: statusColor.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      ticket.status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
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

  Widget _buildReportProblemCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Encountered a technical issue or unexpected behavior? Submit a ticket directly to engineering:",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          Text("Problem Category",
              style:
                  theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.3)),
            ),
            child: DropdownButton<String>(
              value: _problemCategory,
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down_rounded),
              items: _helpCategories
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _problemCategory = val);
              },
            ),
          ),
          const SizedBox(height: 16),
          Text("Subject Summary",
              style:
                  theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _problemSubjectController,
            decoration: InputDecoration(
              hintText: "e.g., Error code 500 when exporting candidates to Excel",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
          const SizedBox(height: 16),
          Text("Detailed Description & Steps to Reproduce",
              style:
                  theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _problemDescController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  "Please provide detailed steps, browser version, and expected vs. actual behavior...",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  setState(() => _hasAttachment = !_hasAttachment);
                  _showFeedback(
                    context,
                    _hasAttachment
                        ? "Attached screenshot_error_log_2026.png"
                        : "Removed attachment",
                  );
                },
                icon: Icon(
                    _hasAttachment ? Icons.check_circle_rounded : Icons.attach_file_rounded,
                    size: 18,
                    color: _hasAttachment ? Colors.green : null),
                label: Text(
                  _hasAttachment
                      ? "screenshot_error_log_2026.png attached"
                      : "Attach Screenshots or Logs",
                ),
              ),
              FilledButton.icon(
                onPressed: () {
                  final subject = _problemSubjectController.text.trim();
                  if (subject.isEmpty) {
                    _showFeedback(context, "Please enter a subject summary");
                    return;
                  }
                  provider.addSupportTicket(
                    subject: subject,
                    category: _problemCategory,
                    priority: "High",
                  );
                  _problemSubjectController.clear();
                  _problemDescController.clear();
                  setState(() => _hasAttachment = false);
                  _showFeedback(
                      context, "Support ticket submitted successfully!");
                },
                icon: const Icon(Icons.send_rounded, size: 18),
                label: const Text("Submit Support Report",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRequestCard(BuildContext context) {
    final theme = Theme.of(context);
    final priorities = ["Low Impact", "Medium Impact", "High Impact", "Critical Need"];

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Have an idea to improve candidate pipeline velocity or team collaboration? Suggest a feature:",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          Text("Feature Title",
              style:
                  theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _featureTitleController,
            decoration: InputDecoration(
              hintText: "e.g., Automated WhatsApp candidate reminder sequence",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
          const SizedBox(height: 16),
          Text("Feature Description & Business Value",
              style:
                  theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _featureDescController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  "How would this feature help your recruitment team save time or hire better talent?",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 16),
          Text("Impact Priority",
              style:
                  theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: priorities.map((p) {
              final isSel = _featurePriority == p;
              return ChoiceChip(
                label: Text(p,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSel ? FontWeight.bold : FontWeight.normal)),
                selected: isSel,
                onSelected: (sel) {
                  if (sel) setState(() => _featurePriority = p);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonalIcon(
              onPressed: () {
                final title = _featureTitleController.text.trim();
                if (title.isEmpty) {
                  _showFeedback(context, "Please specify a feature title");
                  return;
                }
                _featureTitleController.clear();
                _featureDescController.clear();
                _showFeedback(context,
                    "Feature request submitted to JobNest Engineering! Thank you.");
              },
              icon: const Icon(Icons.lightbulb_rounded, size: 18),
              label: const Text("Submit Feature Suggestion",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final infos = [
      {"label": "Current Version", "value": "v4.2.0 (Enterprise Recruiter Suite)"},
      {"label": "Build Number", "value": "Build 20260726.4 (Release GA)"},
      {"label": "Release Channel", "value": "Production Enterprise Stable"},
      {"label": "Last Updated", "value": "July 26, 2026 (18:30 IST)"},
      {"label": "Cloud Environment", "value": "AWS us-east-1 (Enterprise Multi-Tenant)"},
    ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: infos.map((info) {
          final isLast = info == infos.last;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      info["label"]!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        info["value"]!,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                    height: 1,
                    color: theme.colorScheme.outline.withValues(alpha: 0.15)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLegalCard(BuildContext context) {
    final theme = Theme.of(context);
    final legals = [
      {
        "title": "Privacy Policy & GDPR Compliance",
        "subtitle": "SOC2 Type II, GDPR, CCPA data protection protocols",
        "icon": Icons.privacy_tip_outlined
      },
      {
        "title": "Terms & Conditions (MSA)",
        "subtitle": "Enterprise Master Services Agreement and terms of use",
        "icon": Icons.description_outlined
      },
      {
        "title": "Open Source Licenses",
        "subtitle": "Third-party software attributions and MIT/Apache 2.0 notices",
        "icon": Icons.code_rounded
      },
      {
        "title": "About JobNest Inc.",
        "subtitle": "Corporate headquarters, leadership, and investor relations",
        "icon": Icons.business_rounded
      },
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: legals.length,
        separatorBuilder: (ctx, i) => Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15)),
        itemBuilder: (context, index) {
          final item = legals[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item["icon"] as IconData,
                  color: theme.colorScheme.primary, size: 22),
            ),
            title: Text(item["title"] as String,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item["subtitle"] as String,
                style: TextStyle(
                    fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              _showLegalSheet(context, item["title"] as String);
            },
          );
        },
      ),
    );
  }

  Widget _buildRateAppCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            "Enjoying JobNest Enterprise Suite?",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Your feedback helps us continuously evolve our ATS workflow and AI matching engines.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starNum = index + 1;
              final isLit = starNum <= _selectedStars;
              return IconButton(
                onPressed: () {
                  setState(() => _selectedStars = starNum);
                  _showFeedback(context, "Rated JobNest $starNum stars!");
                },
                icon: Icon(
                  isLit ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: Colors.amber.shade700,
                  size: 36,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: () {
                  _showFeedback(context,
                      "Opening app review portal (Thank you for your review!)");
                },
                icon: const Icon(Icons.rate_review_rounded, size: 18),
                label: const Text("Write an Enterprise Review"),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _showFeedback(context,
                      "Copied JobNest Enterprise referral link to clipboard!");
                },
                icon: const Icon(Icons.share_rounded, size: 18),
                label: const Text("Share App with Team"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message (Dummy action)"),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCategorySheet(BuildContext context, String category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: "$category Help Articles",
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.article_outlined, color: Colors.blue),
              title: Text("Best practices for $category in v4.2",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("Updated 3 days ago • Enterprise Guide"),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              onTap: () {
                Navigator.pop(ctx);
                _showArticleDialog(context, "Best practices for $category in v4.2", category);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.article_outlined, color: Colors.purple),
              title: Text("Troubleshooting common $category errors",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("Updated 1 week ago • Technical Reference"),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              onTap: () {
                Navigator.pop(ctx);
                _showArticleDialog(context, "Troubleshooting common $category errors", category);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.article_outlined, color: Colors.green),
              title: Text("Automating $category workflows with AI",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("Updated yesterday • Advanced Tutorial"),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              onTap: () {
                Navigator.pop(ctx);
                _showArticleDialog(context, "Automating $category workflows with AI", category);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showArticleDialog(BuildContext context, String title, String category) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.menu_book_rounded, color: Colors.indigo),
            const SizedBox(width: 10),
            Expanded(child: Text(title)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Category: $category  •  Enterprise Knowledge Base",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "This official JobNest Enterprise guide outlines the recommended architectural patterns, SLA guidelines, and recruiter workflows for maximizing efficiency in the talent acquisition lifecycle.\n\nKey Highlights:\n• Configure automated triggers and email sequences.\n• Monitor candidate progression through scorecard ratings.\n• Maintain strict GDPR and SOC2 compliance across team roles.",
                style: TextStyle(height: 1.5, fontSize: 13),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close Guide"),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _showFeedback(context, "Bookmarked '$title' to your reading list!");
            },
            icon: const Icon(Icons.bookmark_add_rounded, size: 16),
            label: const Text("Bookmark Article"),
          ),
        ],
      ),
    );
  }

  void _showContactSupportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: "Contact Enterprise Priority Support",
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.email_rounded, color: Colors.blueAccent),
              title: const Text("Email Priority Desk",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("enterprise-support@jobnest.com"),
              trailing: const Text("< 2h SLA",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(ctx);
                _showFeedback(context, "Opening email client...");
              },
            ),
            const Divider(),
            ListTile(
              leading:
                  const Icon(Icons.phone_in_talk_rounded, color: Colors.green),
              title: const Text("24/7 Telephone Helpline",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("+1 (800) 555-NEST • Global Recruiter Desk"),
              trailing: const Text("Toll-Free",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(ctx);
                _showFeedback(context, "Calling priority helpline...");
              },
            ),
            const Divider(),
            ListTile(
              leading:
                  const Icon(Icons.chat_bubble_rounded, color: Colors.purpleAccent),
              title: const Text("Live Specialist Chat",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle:
                  const Text("Connect instantly with an ATS technical specialist."),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12)),
                child: const Text("Online Now",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _showFeedback(
                    context, "Connecting to live chat specialist...");
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _showFeedback(
                      context, "Connecting to live support specialist... (Dummy)");
                },
                icon: const Icon(Icons.chat_rounded),
                label: const Text("Start Live Chat Now",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLegalSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Official JobNest Enterprise Legal & Compliance Documentation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 12),
            Text(
              "JobNest adheres to strict SOC2 Type II, GDPR, CCPA, and ISO-27001 enterprise compliance frameworks. All candidate resume pipelines, scorecard ratings, and team communication records are encrypted at rest and in transit using AES-256 bit encryption.\n\nBy operating within the JobNest Enterprise Recruiter suite, your organization agrees to our Standard Master Services Agreement (MSA), Service Level Agreement (SLA) terms, and Acceptable Use Policy.\n\nFor legal inquiries or formal GDPR Data Processing Agreement (DPA) execution, contact legal-compliance@jobnest.com.",
              style: TextStyle(
                  height: 1.5,
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Acknowledge & Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewMetric {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  _OverviewMetric({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class _QuickActionItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _QuickActionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _FaqItem {
  final String question;
  final String answer;

  _FaqItem({required this.question, required this.answer});
}

class _GuideItem {
  final String title;
  final String category;
  final String readTime;

  _GuideItem({
    required this.title,
    required this.category,
    required this.readTime,
  });
}

class _BottomSheetContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const _BottomSheetContainer({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title,
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    constraints:
                        const BoxConstraints(minWidth: 48, minHeight: 48),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
