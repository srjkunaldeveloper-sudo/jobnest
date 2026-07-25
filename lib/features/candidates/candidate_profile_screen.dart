import 'package:flutter/material.dart';

import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_header.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_summary.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_skills.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_experience.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_education.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_resume_preview.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_quick_actions.dart';

import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_ai_resume_analysis.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_ai_candidate_score.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_ai_hiring_probability.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_ai_interview_assistant.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_interview_scheduler.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_ai_recommendations.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_interview_summary.dart';
import 'package:jobnest/features/candidates/widgets/candidate_profile/profile_recent_activity.dart';

class CandidateProfileScreen extends StatelessWidget {
  final String name;
  final String role;
  final String location;
  final String experience;

  const CandidateProfileScreen({
    super.key,
    required this.name,
    required this.role,
    required this.location,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Backend se candidate profile fetch hoga using candidate ID.

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  name: name,
                  role: role,
                  location: location,
                  experience: experience,
                ),
                const ProfileSummary(),
                const SizedBox(height: 32),
                
                const ProfileSkills(),
                const SizedBox(height: 32),

                const ProfileExperience(),
                const SizedBox(height: 32),

                const ProfileEducation(),
                const SizedBox(height: 32),

                const ProfileResumePreview(),
                const SizedBox(height: 48),

                // ==========================================
                // AI EVALUATION ENGINE
                // ==========================================
                Divider(color: theme.dividerColor.withValues(alpha: 0.5)),
                const SizedBox(height: 32),
                
                Text(
                  "AI Evaluation Engine",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "ML-powered insights and hiring recommendations.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),

                const ProfileAiResumeAnalysis(),
                const SizedBox(height: 32),

                const ProfileAiCandidateScore(),
                const SizedBox(height: 32),

                const ProfileAiHiringProbability(),
                const SizedBox(height: 32),

                const ProfileAiRecommendations(),
                const SizedBox(height: 32),

                const ProfileAiInterviewAssistant(),
                const SizedBox(height: 32),

                const ProfileInterviewScheduler(),
                const SizedBox(height: 32),
                
                const ProfileInterviewSummary(),
                const SizedBox(height: 48),
                
                // ==========================================
                // RECENT ACTIVITY & ACTIONS
                // ==========================================
                const ProfileRecentActivity(),
                const SizedBox(height: 48),

                const ProfileQuickActions(),
                const SizedBox(height: 64), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
