import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/services/tools/resume_analyzer_screen.dart';
import 'package:jobnest/features/services/tools/interview_assistant_screen.dart';
import 'package:jobnest/features/services/tools/screening_setup_screen.dart';
import 'package:jobnest/features/services/tools/communication_hub_screen.dart';
import 'package:jobnest/features/services/tools/decision_support_screen.dart';
import 'package:jobnest/features/services/widgets/services_hub_sections.dart';

// Universal Placeholder Screen for upcoming AI tools
class AiToolPlaceholderScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const AiToolPlaceholderScreen({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 64, color: color),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    "Coming in next phase",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(AppIcons.arrow_back_rounded, size: 18),
                  label: const Text("Back"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
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

class AiToolsDashboardScreen extends StatefulWidget {
  final bool isEmbedded;
  const AiToolsDashboardScreen({super.key, this.isEmbedded = false});

  @override
  State<AiToolsDashboardScreen> createState() => _AiToolsDashboardScreenState();
}

class _AiToolsDashboardScreenState extends State<AiToolsDashboardScreen> {
  // ===== BACKEND TODO COMMENTS =====
  // TODO:
  // AI Resume API

  // TODO:
  // Interview AI API

  // TODO:
  // Screening API

  // TODO:
  // Communication API

  // TODO:
  // Analytics API

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // All 10 AI Tools required for All AI Tools catalog
    final allTools = [
      (
        "Resume Analyzer",
        "AI-powered resume parsing and qualification ranking against job specs.",
        "Ranking",
        AppIcons.document_scanner_rounded,
        Colors.deepPurpleAccent,
        const ResumeAnalyzerScreen(),
      ),
      (
        "Interview Assistant",
        "Real-time interview question generation and live candidate evaluation scoring.",
        "Interviewing",
        AppIcons.forum_rounded,
        Colors.blueAccent,
        const InterviewAssistantScreen(),
      ),
      (
        "Screening",
        "One-way video interview setup with automated AI transcript sentiment review.",
        "Screening",
        AppIcons.video_camera_front_rounded,
        Colors.green,
        const ScreeningSetupScreen(),
      ),
      (
        "Decision Support",
        "Comparative metric scorecards to evaluate top candidate trade-offs side by side.",
        "Analytics",
        AppIcons.balance_rounded,
        Colors.orangeAccent,
        const DecisionSupportScreen(),
      ),
      (
        "Communication Hub",
        "Unified messaging platform for automated candidate nurture sequences and updates.",
        "Messaging",
        AppIcons.email_rounded,
        Colors.indigo,
        const CommunicationHubScreen(),
      ),
      (
        "Offer Letter Generator",
        "Generate legally compliant, personalized offer letters with AI salary benchmarking.",
        "Onboarding",
        AppIcons.description_rounded,
        Colors.teal,
        const AiToolPlaceholderScreen(
          title: "Offer Letter Generator",
          description: "Generate legally compliant, personalized offer letters with AI salary benchmarking.",
          icon: AppIcons.description_rounded,
          color: Colors.teal,
        ),
      ),
      (
        "Job Description Generator",
        "Create SEO-optimized, bias-free job descriptions tailored to your target talent pool.",
        "Recruitment",
        AppIcons.work_outline_rounded,
        Colors.cyan.shade700,
        const AiToolPlaceholderScreen(
          title: "Job Description Generator",
          description: "Create SEO-optimized, bias-free job descriptions tailored to your target talent pool.",
          icon: AppIcons.work_outline_rounded,
          color: Colors.cyan,
        ),
      ),
      (
        "Email Writer",
        "Draft personalized reach-outs, rejection letters, and interview follow-up emails instantly.",
        "Communication",
        AppIcons.mark_email_unread_rounded,
        Colors.purpleAccent.shade700,
        const AiToolPlaceholderScreen(
          title: "Email Writer",
          description: "Draft personalized reach-outs, rejection letters, and interview follow-up emails instantly.",
          icon: AppIcons.mark_email_unread_rounded,
          color: Colors.purpleAccent,
        ),
      ),
      (
        "Candidate Summary",
        "Generate concise 1-page executive briefs from multi-page resumes and portfolios.",
        "Screening",
        AppIcons.summarize_rounded,
        Colors.redAccent,
        const AiToolPlaceholderScreen(
          title: "Candidate Summary",
          description: "Generate concise 1-page executive briefs from multi-page resumes and portfolios.",
          icon: AppIcons.summarize_rounded,
          color: Colors.redAccent,
        ),
      ),
      (
        "Hiring Insights",
        "Predictive analytics on time-to-hire, offer acceptance rates, and salary market trends.",
        "Intelligence",
        AppIcons.trending_up_rounded,
        Colors.amber.shade800,
        const AiToolPlaceholderScreen(
          title: "Hiring Insights",
          description: "Predictive analytics on time-to-hire, offer acceptance rates, and salary market trends.",
          icon: AppIcons.trending_up_rounded,
          color: Colors.amber,
        ),
      ),
    ];

    // Quick Actions (6 tools)
    final quickActions = [
      (
        "Resume Analyzer",
        "Parse & Rank Resumes",
        AppIcons.document_scanner_rounded,
        Colors.deepPurpleAccent,
        const ResumeAnalyzerScreen(),
      ),
      (
        "Interview Assistant",
        "Live Q&A Generation",
        AppIcons.forum_rounded,
        Colors.blueAccent,
        const InterviewAssistantScreen(),
      ),
      (
        "Candidate Screening",
        "Video Setup & Review",
        AppIcons.video_camera_front_rounded,
        Colors.green,
        const ScreeningSetupScreen(),
      ),
      (
        "Decision Support",
        "Compare Candidates",
        AppIcons.balance_rounded,
        Colors.orangeAccent,
        const DecisionSupportScreen(),
      ),
      (
        "Communication Hub",
        "Automated Nurture",
        AppIcons.email_rounded,
        Colors.indigo,
        const CommunicationHubScreen(),
      ),
      (
        "Templates",
        "500+ SEO Templates",
        AppIcons.post_add_rounded,
        Colors.teal,
        const JobTemplatesPlaceholderScreen(),
      ),
    ];

    // Recently Used (3 tools with dummy history)
    final recentlyUsed = [
      (
        "Resume Analyzer",
        "10 mins ago",
        "Completed (32 Resumes)",
        AppIcons.document_scanner_rounded,
        Colors.deepPurpleAccent,
        const ResumeAnalyzerScreen(),
      ),
      (
        "Interview Assistant",
        "2 hours ago",
        "Active Session",
        AppIcons.forum_rounded,
        Colors.blueAccent,
        const InterviewAssistantScreen(),
      ),
      (
        "Candidate Screening",
        "Yesterday",
        "12 Screened",
        AppIcons.video_camera_front_rounded,
        Colors.green,
        const ScreeningSetupScreen(),
      ),
    ];

    // Recommended Tools (4 tools)
    final recommendedTools = [
      (
        "Resume Analyzer",
        "Step 1: Parse & Rank Candidates",
        AppIcons.document_scanner_rounded,
        Colors.deepPurpleAccent,
        const ResumeAnalyzerScreen(),
      ),
      (
        "Interview Assistant",
        "Step 2: Generate Live Q&A",
        AppIcons.forum_rounded,
        Colors.blueAccent,
        const InterviewAssistantScreen(),
      ),
      (
        "Pipeline Insights",
        "Step 3: Analyze Stage Velocity",
        AppIcons.insights_rounded,
        Colors.purpleAccent.shade700,
        const AiToolPlaceholderScreen(
          title: "Pipeline Insights",
          description: "Analyze stage velocity and candidate conversion metrics across your open pipelines.",
          icon: AppIcons.insights_rounded,
          color: Colors.purpleAccent,
        ),
      ),
      (
        "Communication Hub",
        "Step 4: Automated Candidate Nurture",
        AppIcons.email_rounded,
        Colors.indigo,
        const CommunicationHubScreen(),
      ),
    ];

    // AI Tips (4 cards)
    final tips = [
      (
        "Save time using AI",
        "Automate top-of-funnel resume screening to reclaim up to 15 hours per recruiter each week.",
        AppIcons.timer_rounded,
        Colors.amber.shade800,
      ),
      (
        "Generate interview questions",
        "Use AI to craft behavioral and technical questions tailored specifically to candidate resume gaps.",
        AppIcons.psychology_rounded,
        Colors.blueAccent,
      ),
      (
        "Analyse multiple resumes",
        "Upload batch PDF resumes to instantly generate a side-by-side comparative qualification ranking table.",
        AppIcons.batch_prediction_rounded,
        Colors.deepPurpleAccent,
      ),
      (
        "Improve candidate communication",
        "Maintain 100% response rates by automating personalized stage update and rejection emails.",
        AppIcons.auto_awesome_rounded,
        Colors.green,
      ),
    ];

    // Filter tools when search query is entered
    final filteredTools = _searchQuery.isEmpty
        ? allTools
        : allTools.where((tool) {
            final q = _searchQuery.toLowerCase();
            return tool.$1.toLowerCase().contains(q) ||
                tool.$2.toLowerCase().contains(q) ||
                tool.$3.toLowerCase().contains(q);
          }).toList();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ====================================================================
        // SEARCH AI TOOLS
        // ====================================================================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (val) {
              setState(() {
                _searchQuery = val.trim();
              });
            },
            decoration: InputDecoration(
              hintText: "Search AI tools by title, category, or description...",
              border: InputBorder.none,
              icon: Icon(AppIcons.search_rounded, color: theme.colorScheme.primary),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(AppIcons.clear_rounded, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = "";
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // If search is active, show filtered results grid
        if (_searchQuery.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search Results (${filteredTools.length})",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = "";
                  });
                },
                icon: const Icon(AppIcons.refresh_rounded, size: 16),
                label: const Text("Reset Search"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (filteredTools.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Icon(AppIcons.search_off_rounded, size: 48, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(height: 12),
                    Text("No AI tools matching '$_searchQuery'", style: theme.textTheme.titleMedium),
                  ],
                ),
              ),
            )
          else
            _buildToolsGrid(context, filteredTools),
          const SizedBox(height: 40),
        ] else ...[
          // ====================================================================
          // AI USAGE SUMMARY CARD
          // ====================================================================
          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(AppIcons.auto_awesome_rounded, color: theme.colorScheme.primary, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AI Workspace Analytics",
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Recruiter productivity & efficiency summary",
                              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(AppIcons.trending_up_rounded, size: 14, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            "+14% Time Saved",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(color: theme.dividerColor.withValues(alpha: 0.6)),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    int columns = constraints.maxWidth >= 900 ? 4 : (constraints.maxWidth >= 550 ? 2 : 1);
                    double itemWidth = (constraints.maxWidth - ((columns - 1) * 16)) / columns;
                    return Wrap(
                      spacing: 16,
                      runSpacing: 20,
                      children: [
                        _buildSummaryMetric(context, "Resumes Analysed", "142 / 200", 0.71, Colors.deepPurpleAccent, itemWidth),
                        _buildSummaryMetric(context, "Interviews Generated", "28 / 50", 0.56, Colors.blueAccent, itemWidth),
                        _buildSummaryMetric(context, "Candidates Screened", "84 / 100", 0.84, Colors.green, itemWidth),
                        _buildSummaryMetric(context, "Time Saved This Week", "18.5 Hours", 0.92, Colors.orangeAccent, itemWidth),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),

          // ====================================================================
          // QUICK ACTIONS
          // ====================================================================
          _buildSectionTitle(theme, "Quick Actions", "Launch frequently used hiring workflows in one click."),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: quickActions.map((action) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 220,
                    child: AppCard(
                      padding: EdgeInsets.zero,
                      child: InkWell(
                        onTap: () => _navigateToScreen(context, action.$5),
                        borderRadius: BorderRadius.circular(16),
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
                                    color: action.$4.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(action.$3, color: action.$4, size: 24),
                                ),
                                Icon(
                                  AppIcons.arrow_forward_rounded,
                                  size: 18,
                                  color: theme.colorScheme.primary,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              action.$1,
                              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              action.$2,
                              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 36),

          // ====================================================================
          // RECENTLY USED
          // ====================================================================
          _buildSectionTitle(theme, "Recently Used", "Continue your recent candidate evaluations and screening sessions."),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = constraints.maxWidth >= 900 ? 3 : (constraints.maxWidth >= 600 ? 2 : 1);
              double itemWidth = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: recentlyUsed.map((item) {
                  return SizedBox(
                    width: itemWidth,
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: item.$5.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(item.$4, color: item.$5, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.$1,
                                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Last used: ${item.$2}",
                                  style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.$3,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () => _navigateToScreen(context, item.$6),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text("Open", style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 36),

          // ====================================================================
          // ALL AI TOOLS (GRID LAYOUT)
          // ====================================================================
          _buildSectionTitle(theme, "All AI Tools", "Complete suite of artificial intelligence models for recruitment and onboarding."),
          const SizedBox(height: 16),
          _buildToolsGrid(context, allTools),
          const SizedBox(height: 36),

          // ====================================================================
          // RECOMMENDED TOOLS
          // ====================================================================
          _buildSectionTitle(theme, "Recommended AI Tools", "Most recruiters analyse resumes before conducting live interviews. Suggested workflow:"),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = constraints.maxWidth >= 900 ? 4 : (constraints.maxWidth >= 600 ? 2 : 1);
              double itemWidth = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: recommendedTools.map((item) {
                  return SizedBox(
                    width: itemWidth,
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: item.$4.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(item.$3, color: item.$4, size: 22),
                              ),
                              Icon(AppIcons.arrow_forward_ios_rounded, size: 14, color: theme.colorScheme.primary),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            item.$1,
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.$2,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => _navigateToScreen(context, item.$5),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text("Launch Step", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 36),

          // ====================================================================
          // TIPS & UPDATES
          // ====================================================================
          _buildSectionTitle(theme, "Tips & Best Practices", "Maximize hiring intelligence and reduce time-to-hire with these techniques."),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = constraints.maxWidth >= 800 ? 2 : 1;
              double itemWidth = (constraints.maxWidth - ((columns - 1) * 16)) / columns;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: tips.map((tip) {
                  return SizedBox(
                    width: itemWidth,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: tip.$4.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: tip.$4.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: tip.$4.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(tip.$3, color: tip.$4, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tip.$1,
                                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tip.$2,
                                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
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
            },
          ),
          const SizedBox(height: 60),
        ],
      ],
    );

    if (widget.isEmbedded) {
      return content;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("AI Tools Dashboard"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildSummaryMetric(BuildContext context, String title, String value, double progress, Color color, double width) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolsGrid(BuildContext context, List<(String, String, String, IconData, Color, Widget)> tools) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth >= 950 ? 3 : (constraints.maxWidth >= 600 ? 2 : 1);
        double itemWidth = (constraints.maxWidth - ((columns - 1) * 16)) / columns;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: tools.map((tool) {
            return SizedBox(
              width: itemWidth,
              child: AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: tool.$5.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(tool.$4, color: tool.$5, size: 26),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tool.$3,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tool.$1,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tool.$2,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _navigateToScreen(context, tool.$6),
                        icon: const Icon(AppIcons.arrow_forward_rounded, size: 16),
                        label: const Text("Open Tool"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.onPrimaryContainer,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
