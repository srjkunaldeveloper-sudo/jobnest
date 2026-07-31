import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import '../../data/models/candidate_model.dart';

/// A reusable card widget for displaying a summary of a [CandidateModel].
class CandidateCard extends StatelessWidget {
  final CandidateModel candidate;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CandidateCard({
    super.key,
    required this.candidate,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Status color mapping based on theme semantic colors
    Color statusColor;
    switch (candidate.status.toLowerCase()) {
      case 'applied':
      case 'screening':
        statusColor = theme.colorScheme.tertiary;
        break;
      case 'interviewing':
        statusColor = theme.colorScheme.primary;
        break;
      case 'offer extended':
      case 'hired':
        statusColor = Colors.green; // Defaulting to a standard success color
        break;
      case 'rejected':
      case 'withdrawn':
        statusColor = theme.colorScheme.error;
        break;
      default:
        statusColor = theme.colorScheme.secondary;
    }

    final topSkills = candidate.skills.take(3).toList();
    final hasMoreSkills = candidate.skills.length > 3;

    return Semantics(
      label: 'Candidate card for ${candidate.firstName} ${candidate.lastName}, ${candidate.jobTitle}',
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
        color: theme.colorScheme.surfaceContainerLow,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onView,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Avatar, Name/Title, and Actions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      backgroundImage: candidate.avatarUrl != null && candidate.avatarUrl!.isNotEmpty
                          ? NetworkImage(candidate.avatarUrl!)
                          : null,
                      child: candidate.avatarUrl == null || candidate.avatarUrl!.isEmpty
                          ? Text(
                              '${candidate.firstName.isNotEmpty ? candidate.firstName[0] : ''}${candidate.lastName.isNotEmpty ? candidate.lastName[0] : ''}'
                                  .toUpperCase(),
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${candidate.firstName} ${candidate.lastName}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            candidate.jobTitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (onView != null || onEdit != null || onDelete != null)
                      PopupMenuButton<String>(
                        icon: Icon(
                          AppIcons.more_vert,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        onSelected: (value) {
                          if (value == 'view') onView?.call();
                          if (value == 'edit') onEdit?.call();
                          if (value == 'delete') onDelete?.call();
                        },
                        itemBuilder: (context) => [
                          if (onView != null)
                            const PopupMenuItem(
                              value: 'view',
                              child: Text('View Profile'),
                            ),
                          if (onEdit != null)
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                          if (onDelete != null)
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Badges: Status
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    candidate.status.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Details Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _buildDetailItem(
                          context,
                          icon: AppIcons.business,
                          text: candidate.department,
                        ),
                        _buildDetailItem(
                          context,
                          icon: AppIcons.location_on_outlined,
                          text: candidate.location,
                        ),
                        _buildDetailItem(
                          context,
                          icon: AppIcons.work_history_outlined,
                          text: candidate.experience,
                        ),
                      ],
                    );
                  },
                ),
                
                if (topSkills.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(height: 1),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...topSkills.map((skill) => _buildSkillChip(context, skill)),
                      if (hasMoreSkills)
                        _buildSkillChip(context, '+${candidate.skills.length - 3} more'),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, {required IconData icon, required String text}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.outline,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
