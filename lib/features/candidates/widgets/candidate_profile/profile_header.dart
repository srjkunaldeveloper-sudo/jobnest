import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';
import 'package:jobnest/features/candidates/widgets/candidate_icon_button.dart';
import 'package:jobnest/features/candidates/widgets/candidate_stage_badge.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String location;
  final String experience;
  final CandidateModel? candidate;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
    required this.location,
    required this.experience,
    this.candidate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<RecruitmentDataProvider>();
    final String company = candidate?.company ?? "TechCorp India";
    final String stage = candidate?.stage ?? "Screening";
    final String salary = candidate?.expectedSalary ?? "₹ 18 - 22 LPA";
    final String appliedDate = candidate?.appliedDate ?? "2 days ago";
    final bool isBookmarked = candidate?.isBookmarked ?? false;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : "?",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  name,
                                  style: theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              AppSpacing.w12,
                              CandidateStageBadge(stage: stage, isUppercase: true),
                            ],
                          ),
                          AppSpacing.h8,
                          Text(
                            "$role at $company",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "$experience Experience • $location • Applied $appliedDate",
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
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
              Row(
                children: [
                  Semantics(
                    label: isBookmarked ? "Remove Bookmark" : "Bookmark Candidate",
                    button: true,
                    child: CandidateIconButton(
                      icon: isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      onTap: () {
                        if (candidate != null) {
                          provider.toggleBookmarkCandidate(candidate!.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(isBookmarked ? "Removed bookmark for $name" : "Bookmarked $name")),
                          );
                        }
                      },
                      iconColor: isBookmarked ? theme.colorScheme.primary : null,
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    ),
                  ),
                  AppSpacing.w8,
                  Semantics(
                    label: "Share Candidate Profile",
                    button: true,
                    child: CandidateIconButton(
                      icon: Icons.share_rounded,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Profile link copied to clipboard for $name.")),
                        );
                      },
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    ),
                  ),
                  AppSpacing.w8,
                  Semantics(
                    label: "More Options",
                    button: true,
                    child: CandidateIconButton(
                      icon: Icons.more_vert_rounded,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Additional enterprise options...")),
                        );
                      },
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.h24,
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _buildInfoChip(context, Icons.event_available_rounded, "Immediate Joiner / 15 Days"),
              _buildInfoChip(context, Icons.account_balance_wallet_rounded, "Expected Salary: $salary"),
              _buildInfoChip(context, Icons.star_rounded, "Rating: ${candidate?.rating ?? 4.8} / 5.0", color: Colors.amber.shade700),
              _buildInfoChip(context, Icons.work_history_rounded, "Stage: $stage", color: theme.colorScheme.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label, {Color? color}) {
    final theme = Theme.of(context);
    final c = color ?? theme.colorScheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: c),
          AppSpacing.w8,
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color != null ? c : theme.colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
