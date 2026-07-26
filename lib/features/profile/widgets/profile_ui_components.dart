import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_empty_state.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';

/// Single Shared Profile UI utility module for Skeletons, Empty States, Error States,
/// Success States, and Refresh Experiences across all 15 Profile screens.
/// Follows JobNest enterprise design language and accessibility standards.

// ============================================================================
// SKELETON COMPONENTS
// ============================================================================

/// 1. Profile Header Skeleton (Avatar, Name, Role, Company, Quick Stats)
class ProfileHeaderSkeleton extends StatelessWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const AppShimmerLoading(
            width: 96,
            height: 96,
            borderRadius: BorderRadius.all(Radius.circular(48)),
          ),
          const SizedBox(height: 16),
          const AppShimmerLoading(width: 180, height: 24),
          const SizedBox(height: 8),
          const AppShimmerLoading(width: 120, height: 16),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatShimmer(),
              _buildStatShimmer(),
              _buildStatShimmer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatShimmer() {
    return Column(
      children: const [
        AppShimmerLoading(width: 40, height: 20),
        SizedBox(height: 4),
        AppShimmerLoading(width: 60, height: 12),
      ],
    );
  }
}

/// 2. Profile Card Skeleton
class ProfileCardSkeleton extends StatelessWidget {
  final double? height;
  const ProfileCardSkeleton({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const AppSkeletonCard(),
    );
  }
}

/// 3. Settings Tile Skeleton (Leading icon, Title/Subtitle, Trailing switch/chevron)
class ProfileSettingsTileSkeleton extends StatelessWidget {
  const ProfileSettingsTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          const AppShimmerLoading(
            width: 40,
            height: 40,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmerLoading(width: 140, height: 16),
                SizedBox(height: 6),
                AppShimmerLoading(width: 200, height: 12),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const AppShimmerLoading(
            width: 36,
            height: 20,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ],
      ),
    );
  }
}

/// 4. List Item Skeleton (Team members, billing items, trusted devices)
class ProfileListItemSkeleton extends StatelessWidget {
  final bool hasTrailingBadge;
  const ProfileListItemSkeleton({super.key, this.hasTrailingBadge = true});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const AppShimmerLoading(
            width: 48,
            height: 48,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmerLoading(width: 130, height: 16),
                SizedBox(height: 6),
                AppShimmerLoading(width: 90, height: 13),
              ],
            ),
          ),
          if (hasTrailingBadge)
            const AppShimmerLoading(
              width: 70,
              height: 24,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
        ],
      ),
    );
  }
}

/// 5. Statistics Card Skeleton (Data Management, Overview metrics)
class ProfileStatisticsCardSkeleton extends StatelessWidget {
  const ProfileStatisticsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppShimmerLoading(width: 36, height: 36, borderRadius: BorderRadius.all(Radius.circular(8))),
              AppShimmerLoading(width: 48, height: 16),
            ],
          ),
          const SizedBox(height: 12),
          const AppShimmerLoading(width: 64, height: 24),
          const SizedBox(height: 6),
          const AppShimmerLoading(width: 100, height: 12),
        ],
      ),
    );
  }
}

/// 6. Form Skeleton (Input labels & text field containers)
class ProfileFormSkeleton extends StatelessWidget {
  final int fieldCount;
  const ProfileFormSkeleton({super.key, this.fieldCount = 3});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(fieldCount, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index == fieldCount - 1 ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmerLoading(width: 110, height: 14),
                SizedBox(height: 8),
                AppShimmerLoading(
                  width: double.infinity,
                  height: 48,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// 7. Button Skeleton (Primary and secondary CTA buttons)
class ProfileButtonSkeleton extends StatelessWidget {
  final double width;
  final double height;
  const ProfileButtonSkeleton({super.key, this.width = double.infinity, this.height = 48});

  @override
  Widget build(BuildContext context) {
    return AppShimmerLoading(
      width: width,
      height: height,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
    );
  }
}

/// 8. Image Placeholder Skeleton (Company banner, logo, media attachments)
class ProfileImagePlaceholderSkeleton extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;
  const ProfileImagePlaceholderSkeleton({
    super.key,
    this.height = 160,
    this.width = double.infinity,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmerLoading(
      width: width ?? double.infinity,
      height: height,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    );
  }
}

// ============================================================================
// EMPTY STATES
// ============================================================================

enum ProfileEmptyType {
  teamMembers,
  companyMedia,
  billingHistory,
  trustedDevices,
  supportTickets,
  verificationRecords,
  savedPreferences,
  custom,
}

/// Reusable Empty State Display for any Profile module section or list
class ProfileEmptyStateDisplay extends StatelessWidget {
  final ProfileEmptyType type;
  final String? customTitle;
  final String? customDescription;
  final IconData? customIcon;
  final String? primaryActionText;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;

  const ProfileEmptyStateDisplay({
    super.key,
    required this.type,
    this.customTitle,
    this.customDescription,
    this.customIcon,
    this.primaryActionText,
    this.onPrimaryAction,
    this.secondaryActionText,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Replace dummy loading with API loading states.
    final config = _getEmptyConfig();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: AppCard(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppEmptyState(
                  icon: customIcon ?? config.icon,
                  title: customTitle ?? config.title,
                  subtitle: customDescription ?? config.description,
                  buttonText: primaryActionText ?? config.primaryText,
                  onButtonPressed: onPrimaryAction ?? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${config.primaryText} triggered (Dummy Action)")),
                    );
                  },
                ),
                if (secondaryActionText != null && onSecondaryAction != null) ...[
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: onSecondaryAction,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: Text(secondaryActionText!),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  _EmptyStateConfig _getEmptyConfig() {
    switch (type) {
      case ProfileEmptyType.teamMembers:
        return _EmptyStateConfig(
          icon: Icons.group_off_rounded,
          title: "No Team Members",
          description: "You haven't invited any recruiters or hiring managers to this organization yet.",
          primaryText: "Invite Member",
        );
      case ProfileEmptyType.companyMedia:
        return _EmptyStateConfig(
          icon: Icons.photo_library_outlined,
          title: "No Company Media",
          description: "Upload workplace photos and culture videos to showcase your brand to top candidates.",
          primaryText: "Upload Media",
        );
      case ProfileEmptyType.billingHistory:
        return _EmptyStateConfig(
          icon: Icons.receipt_long_outlined,
          title: "No Billing History",
          description: "No subscription invoices or payment transactions were found for this billing cycle.",
          primaryText: "View Current Plan",
        );
      case ProfileEmptyType.trustedDevices:
        return _EmptyStateConfig(
          icon: Icons.devices_other_rounded,
          title: "No Trusted Devices",
          description: "You have not registered any biometric devices or hardware keys for 2FA verification.",
          primaryText: "Register Device",
        );
      case ProfileEmptyType.supportTickets:
        return _EmptyStateConfig(
          icon: Icons.support_agent_rounded,
          title: "No Support Tickets",
          description: "You have no active or archived customer support inquiries with the JobNest helpdesk.",
          primaryText: "Create Ticket",
        );
      case ProfileEmptyType.verificationRecords:
        return _EmptyStateConfig(
          icon: Icons.verified_user_outlined,
          title: "No Verification Records",
          description: "Your corporate identity and recruiter credentials have not been submitted for verification.",
          primaryText: "Start Verification",
        );
      case ProfileEmptyType.savedPreferences:
        return _EmptyStateConfig(
          icon: Icons.tune_rounded,
          title: "No Saved Preferences",
          description: "You haven't configured default job requirements or custom hiring templates yet.",
          primaryText: "Configure Defaults",
        );
      case ProfileEmptyType.custom:
        return _EmptyStateConfig(
          icon: Icons.inbox_outlined,
          title: "No Data Found",
          description: "There are no records available to display in this section.",
          primaryText: "Refresh",
        );
    }
  }
}

class _EmptyStateConfig {
  final IconData icon;
  final String title;
  final String description;
  final String primaryText;
  _EmptyStateConfig({
    required this.icon,
    required this.title,
    required this.description,
    required this.primaryText,
  });
}

// ============================================================================
// ERROR STATES
// ============================================================================

enum ProfileErrorType {
  network,
  server,
  permission,
  unknown,
  unavailable,
}

/// Reusable Error State Display for all Profile module exceptions and network failures
class ProfileErrorStateDisplay extends StatelessWidget {
  final ProfileErrorType type;
  final String? customTitle;
  final String? customDescription;
  final VoidCallback? onRetry;
  final VoidCallback? onContactSupport;

  const ProfileErrorStateDisplay({
    super.key,
    required this.type,
    this.customTitle,
    this.customDescription,
    this.onRetry,
    this.onContactSupport,
  });

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Replace local error messages with backend responses.

    // TODO:
    // Connect retry actions to repository layer.
    final config = _getErrorConfig();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: AppCard(
            padding: const EdgeInsets.all(24),
            child: AppErrorState(
              iconData: config.icon,
              title: customTitle ?? config.title,
              message: customDescription ?? config.description,
              primaryButtonText: "Retry Action",
              onRetry: onRetry ?? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Retrying connection to JobNest server (Dummy Action)")),
                );
              },
              secondaryButtonText: "Contact Support",
              onSecondaryAction: onContactSupport ?? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Opening Support Center (Dummy Action)")),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _ErrorStateConfig _getErrorConfig() {
    switch (type) {
      case ProfileErrorType.network:
        return _ErrorStateConfig(
          icon: Icons.wifi_off_rounded,
          title: "Network Error",
          description: "Unable to connect to JobNest enterprise cloud. Please check your network connection and try again.",
        );
      case ProfileErrorType.server:
        return _ErrorStateConfig(
          icon: Icons.dns_rounded,
          title: "Server Error",
          description: "Our enterprise servers encountered a temporary service disruption while syncing your profile.",
        );
      case ProfileErrorType.permission:
        return _ErrorStateConfig(
          icon: Icons.lock_outline_rounded,
          title: "Permission Error",
          description: "You do not have administrative permissions to view or edit this organization's security settings.",
        );
      case ProfileErrorType.unavailable:
        return _ErrorStateConfig(
          icon: Icons.cloud_off_rounded,
          title: "Data Unavailable",
          description: "The requested profile configuration is currently unavailable or has been archived.",
        );
      case ProfileErrorType.unknown:
        return _ErrorStateConfig(
          icon: Icons.error_outline_rounded,
          title: "Unknown Error",
          description: "An unexpected exception occurred while processing your request. Please retry or contact support.",
        );
    }
  }
}

class _ErrorStateConfig {
  final IconData icon;
  final String title;
  final String description;
  _ErrorStateConfig({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ============================================================================
// SUCCESS STATES & NOTIFIERS
// ============================================================================

enum ProfileSuccessType {
  profileUpdated,
  settingsSaved,
  changesApplied,
  verificationSubmitted,
  backupCreated,
  custom,
}

/// Reusable Success Notifier for standardized snackbars and feedback banners
class ProfileSuccessNotifier {
  static void showSuccess(
    BuildContext context, {
    required ProfileSuccessType type,
    String? customMessage,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final theme = Theme.of(context);
    final message = customMessage ?? _getMessage(type);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: theme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: theme.colorScheme.primaryContainer,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }

  static String _getMessage(ProfileSuccessType type) {
    switch (type) {
      case ProfileSuccessType.profileUpdated:
        return "Profile Updated Successfully";
      case ProfileSuccessType.settingsSaved:
        return "Settings Saved";
      case ProfileSuccessType.changesApplied:
        return "Changes Applied";
      case ProfileSuccessType.verificationSubmitted:
        return "Verification Submitted for Review";
      case ProfileSuccessType.backupCreated:
        return "Enterprise Backup Created Successfully";
      case ProfileSuccessType.custom:
        return "Operation Completed Successfully";
    }
  }
}

// ============================================================================
// REFRESH EXPERIENCE
// ============================================================================

/// Reusable pull-to-refresh wrapper for Profile module lists and scrollviews
class ProfileRefreshWrapper extends StatelessWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  final String refreshSuccessMessage;

  const ProfileRefreshWrapper({
    super.key,
    required this.child,
    this.onRefresh,
    this.refreshSuccessMessage = "Profile data refreshed",
  });

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Replace dummy loading with API loading states.
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      strokeWidth: 2.5,
      onRefresh: onRefresh ?? () async {
        // Frontend dummy refresh simulation
        await Future.delayed(const Duration(milliseconds: 600));
        if (context.mounted) {
          ProfileSuccessNotifier.showSuccess(
            context,
            type: ProfileSuccessType.custom,
            customMessage: refreshSuccessMessage,
          );
        }
      },
      child: child,
    );
  }
}
