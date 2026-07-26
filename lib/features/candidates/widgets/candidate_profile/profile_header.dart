import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';

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
    final provider = context.watch<RecruitmentDataProvider>();
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
                              const SizedBox(width: 12),
                              _buildStageBadge(theme, stage),
                            ],
                          ),
                          const SizedBox(height: 8),
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
                    child: _buildIconButton(
                      context, 
                      isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, 
                      () {
                        if (candidate != null) {
                          provider.toggleBookmarkCandidate(candidate!.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(isBookmarked ? "Removed bookmark for $name" : "Bookmarked $name")),
                          );
                        }
                      },
                      iconColor: isBookmarked ? theme.colorScheme.primary : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Semantics(
                    label: "Share Candidate Profile",
                    button: true,
                    child: _buildIconButton(context, Icons.share_rounded, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Profile link copied to clipboard for $name.")),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Semantics(
                    label: "More Options",
                    button: true,
                    child: _buildIconButton(context, Icons.more_vert_rounded, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Additional enterprise options...")),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
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

  Widget _buildIconButton(BuildContext context, IconData icon, VoidCallback onTap, {Color? iconColor}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: iconColor ?? theme.colorScheme.onSurface),
        onPressed: onTap,
        splashRadius: 22,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
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
          const SizedBox(width: 8),
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

  Widget _buildStageBadge(ThemeData theme, String stage) {
    Color badgeColor = Colors.blueAccent;
    IconData badgeIcon = Icons.group_outlined;
    final s = stage.toLowerCase();

    if (s == "applied") {
      badgeColor = Colors.blueGrey;
      badgeIcon = Icons.inbox_rounded;
    } else if (s == "screening") {
      badgeColor = Colors.blueAccent;
      badgeIcon = Icons.fact_check_outlined;
    } else if (s == "interview") {
      badgeColor = Colors.deepPurpleAccent;
      badgeIcon = Icons.people_alt_outlined;
    } else if (s == "offer") {
      badgeColor = Colors.amber.shade700;
      badgeIcon = Icons.verified_outlined;
    } else if (s == "hired") {
      badgeColor = Colors.green;
      badgeIcon = Icons.check_circle_rounded;
    } else if (s == "rejected") {
      badgeColor = Colors.redAccent;
      badgeIcon = Icons.cancel_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 14, color: badgeColor),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              stage.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: badgeColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
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
