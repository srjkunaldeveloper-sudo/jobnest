import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileHelpScreen extends StatelessWidget {
  const ProfileHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Support tickets API integration.
    // TODO: FAQ content CMS integration.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Help & Support"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildHelpTile(
                      context,
                      icon: Icons.question_answer_outlined,
                      title: "Help Center & FAQs",
                      subtitle: "Browse answers to common recruiter and ATS questions.",
                      onTap: () => _showFaqSheet(context),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(
                      context,
                      icon: Icons.headset_mic_outlined,
                      title: "Contact Enterprise Support",
                      subtitle: "Chat with our dedicated 24/7 recruiter priority support team.",
                      onTap: () => _showContactSupportSheet(context),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(
                      context,
                      icon: Icons.bug_report_outlined,
                      title: "Report a Bug",
                      subtitle: "Encountered an issue? Let our engineering team know.",
                      onTap: () => _showReportBugSheet(context),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(
                      context,
                      icon: Icons.rate_review_outlined,
                      title: "Send Feedback & Suggestions",
                      subtitle: "Tell us what you love or how we can improve JobNest.",
                      onTap: () => _showSendFeedbackSheet(context),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(
                      context,
                      icon: Icons.gavel_outlined,
                      title: "Terms of Service & Privacy",
                      subtitle: "Read our enterprise data protection and compliance agreements.",
                      onTap: () => _showTermsSheet(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Semantics(
      label: "$title. $subtitle",
      button: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 22),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showFaqSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: "Frequently Asked Questions",
        child: Column(
          children: [
            _buildFaqItem(
              ctx,
              "How do I invite hiring team members?",
              "Navigate to Profile > Team Members & Roles and click 'Invite Recruiter'. Enter their email address and assign a permission role (Admin, Recruiter, or Hiring Manager).",
            ),
            _buildFaqItem(
              ctx,
              "How does AI candidate ranking work?",
              "JobNest uses deep neural networks to match candidate resume skills, experience, and education against the specific job description requirements, producing an objective 0-100 match score.",
            ),
            _buildFaqItem(
              ctx,
              "Can I export candidate pipelines to Excel?",
              "Yes! Go to Services > Custom Reports & BI, select your target requisition, and click 'Export to Excel (XLSX)' or CSV format.",
            ),
            _buildFaqItem(
              ctx,
              "How do I configure email templates?",
              "Go to Profile > Email & Offer Templates to customize automated offer letters, interview invitations, and rejection sequence formatting.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline_rounded, color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              answer,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactSupportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: "Contact Enterprise Support",
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.email_rounded, color: Colors.blueAccent),
              title: const Text("Email Support", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("enterprise-support@jobnest.com"),
              trailing: const Text("24h Response", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone_in_talk_rounded, color: Colors.green),
              title: const Text("Phone Helpline", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("+1 (800) 555-NEST • Mon-Fri 8AM-8PM EST"),
              trailing: const Text("Toll-Free", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.chat_bubble_rounded, color: Colors.purpleAccent),
              title: const Text("Live Chat Support", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("Connect instantly with an enterprise specialist."),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                child: const Text("Online", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Connecting to live support specialist... (Dummy)")),
                  );
                },
                icon: const Icon(Icons.chat_rounded),
                label: const Text("Start Live Chat Now", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReportBugSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: "Report a Bug",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Help us improve JobNest by describing the issue you encountered:", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: "Issue Title",
                hintText: "e.g., Candidate resume not previewing",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Description & Steps to Reproduce",
                hintText: "Please provide as much detail as possible...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Bug report submitted successfully! Thank you.")),
                  );
                },
                icon: const Icon(Icons.send_rounded),
                label: const Text("Submit Bug Report", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSendFeedbackSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: "Send Feedback",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("We would love to hear your thoughts on JobNest's enterprise recruiting suite:", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Your Feedback or Feature Request",
                hintText: "What do you love? What can we do better?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Feedback sent! We appreciate your input.")),
                  );
                },
                icon: const Icon(Icons.favorite_rounded),
                label: const Text("Submit Feedback", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTermsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _BottomSheetContainer(
        title: "Terms of Service & Privacy Policy",
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enterprise Data Protection & Security Agreement", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 12),
            Text(
              "JobNest adheres to strict SOC2 Type II, GDPR, and CCPA compliance standards. All candidate resume data, interview notes, and client communication records are encrypted at rest and in transit using AES-256 bit encryption.\n\nBy accessing the JobNest Enterprise Recruiter suite, your organization agrees to our Standard Master Services Agreement (MSA) and Acceptable Use Guidelines.",
              style: TextStyle(height: 1.5, fontSize: 14),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
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
                  Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
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
