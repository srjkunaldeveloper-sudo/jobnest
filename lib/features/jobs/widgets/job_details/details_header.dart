import 'package:flutter/material.dart';


class DetailsHeader extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final String status;

  const DetailsHeader({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isActive = status.toLowerCase() == "active";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$company • $location",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildIconButton(context, Icons.edit_rounded, () {}),
                const SizedBox(width: 8),
                _buildIconButton(context, Icons.share_rounded, () {}),
                const SizedBox(width: 8),
                _buildIconButton(context, Icons.more_vert_rounded, () {}),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _buildInfoChip(context, Icons.monetization_on_rounded, salary),
            _buildInfoChip(context, Icons.work_rounded, jobType),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isActive ? Icons.check_circle_rounded : Icons.cancel_rounded,
                    size: 16,
                    color: isActive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, VoidCallback onTap) {
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
        icon: Icon(icon, size: 20, color: theme.colorScheme.onSurface),
        onPressed: onTap,
        splashRadius: 20,
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
