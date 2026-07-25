import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String location;
  final String experience;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
    required this.location,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
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
                        name[0],
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
                          Text(
                            name,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            role,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "$experience • $location",
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildIconButton(context, Icons.bookmark_border_rounded, () {}),
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
              _buildInfoChip(context, Icons.event_available_rounded, "Immediate Joiner"),
              _buildInfoChip(context, Icons.account_balance_wallet_rounded, "₹18L - ₹24L Expected"),
            ],
          ),
        ],
      ),
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
