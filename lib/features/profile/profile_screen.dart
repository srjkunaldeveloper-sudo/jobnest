import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';
import 'package:jobnest/core/services/session_manager.dart';
import 'package:jobnest/features/auth/auth_flow_screen.dart';

import 'package:jobnest/features/profile/providers/profile_data_provider.dart';
import 'package:jobnest/features/profile/settings/profile_personal_info_screen.dart';
import 'package:jobnest/features/profile/settings/profile_company_screen.dart';
import 'package:jobnest/features/profile/settings/profile_security_screen.dart';
import 'package:jobnest/features/profile/settings/profile_notifications_screen.dart';
import 'package:jobnest/features/profile/settings/profile_preferences_screen.dart';
import 'package:jobnest/features/profile/settings/profile_subscription_screen.dart';
import 'package:jobnest/features/profile/settings/profile_help_screen.dart';
import 'package:jobnest/features/profile/settings/profile_about_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO COMMENTS =====
    // TODO: Fetch recruiter profile.
    // TODO: Update profile API.
    // TODO: Upload profile photo.
    // TODO: Notification preferences API.
    // TODO: Company profile sync.
    // TODO: Logout token invalidation.

    final provider = context.watch<ProfileDataProvider>();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Recruiter Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile link copied to clipboard! (Dummy)")),
              );
            },
            icon: const Icon(Icons.share_rounded),
            tooltip: "Share Profile",
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          ),
          if (kDebugMode) _buildQaSimulationMenu(context, provider),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: _buildBody(context, provider),
      ),
    );
  }

  Widget _buildQaSimulationMenu(BuildContext context, ProfileDataProvider provider) {
    if (!kDebugMode) return const SizedBox.shrink();
    return PopupMenuButton<String>(
      icon: const Icon(Icons.science_outlined),
      tooltip: "QA Simulation Options",
      constraints: const BoxConstraints(minWidth: 200),
      onSelected: (value) {
        switch (value) {
          case 'loading':
            provider.simulateLoading();
            break;
          case 'error':
            provider.simulateError();
            break;
          case 'empty':
            provider.simulateEmpty();
            break;
          case 'restore':
            provider.restoreDefaults();
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'loading',
          height: 48,
          child: Row(
            children: [
              Icon(Icons.hourglass_empty_rounded, size: 20, color: Colors.blueAccent),
              SizedBox(width: 12),
              Text("QA: Loading Skeleton"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'error',
          height: 48,
          child: Row(
            children: [
              Icon(Icons.error_outline_rounded, size: 20, color: Colors.red),
              SizedBox(width: 12),
              Text("QA: Network Error State"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'empty',
          height: 48,
          child: Row(
            children: [
              Icon(Icons.person_off_outlined, size: 20, color: Colors.orange),
              SizedBox(width: 12),
              Text("QA: Empty Profile State"),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'restore',
          height: 48,
          child: Row(
            children: [
              Icon(Icons.restore_rounded, size: 20, color: Colors.green),
              SizedBox(width: 12),
              Text("QA: Restore Defaults"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, ProfileDataProvider provider) {
    if (provider.isLoading) {
      return _buildSkeletonLoading(context);
    }
    if (provider.isError) {
      return _buildErrorState(context, provider);
    }
    if (provider.isEmpty) {
      return _buildEmptyState(context, provider);
    }

    final theme = Theme.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(context, provider),
              const SizedBox(height: 24),
              
              _buildProfileCompletenessCard(context, provider),
              const SizedBox(height: 32),
              
              Text(
                "Quick Recruitment Stats",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildQuickStats(context),
              const SizedBox(height: 32),
              
              Text(
                "Account & Professional Details",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildAccountInformationCards(context, provider),
              const SizedBox(height: 32),
              
              Text(
                "Settings & Administration",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildGroupedSettingsMenu(context),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileDataProvider provider) {
    final theme = Theme.of(context);
    final initials = provider.fullName.isNotEmpty && provider.fullName.length >= 2 
        ? provider.fullName.trim().split(' ').map((w) => w.isNotEmpty ? w[0] : '').take(2).join() 
        : "SS";

    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  initials.toUpperCase(),
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Semantics(
                label: "Verified Recruiter Badge",
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified_rounded,
                    color: Colors.blueAccent,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          provider.fullName,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text(
          "${provider.designation} at ${provider.companyName}",
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email_outlined, size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                provider.email,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePersonalInfoScreen()));
          },
          icon: const Icon(Icons.edit_outlined, size: 18),
          label: const Text("Edit Recruiter Profile", style: TextStyle(fontWeight: FontWeight.bold)),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(200, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCompletenessCard(BuildContext context, ProfileDataProvider provider) {
    final theme = Theme.of(context);
    final percentage = provider.completenessPercentage;

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12.0,
            runSpacing: 8.0,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.stars_rounded, color: Colors.amber[700], size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Profile Completeness",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: percentage >= 80 ? Colors.green.withValues(alpha: 0.15) : Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$percentage% Complete",
                  style: TextStyle(
                    color: percentage >= 80 ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percentage / 100.0,
              minHeight: 8,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(percentage >= 80 ? Colors.green : Colors.orange),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Complete your profile to unlock full recruiter verification and increase candidate trust.",
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          if (provider.missingItems.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              "Missing Items:",
              style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.missingItems.map((item) {
                return Semantics(
                  label: "Missing Item: $item. Tap to add.",
                  button: true,
                  child: ActionChip(
                    avatar: const Icon(Icons.add_circle_outline_rounded, size: 16),
                    label: Text(item, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      if (item.toLowerCase().contains("logo") || item.toLowerCase().contains("company")) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileCompanyScreen()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePersonalInfoScreen()));
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard(context, "Jobs Posted", "142", Icons.work_rounded, Colors.blueAccent),
            _buildStatCard(context, "Candidates Hired", "84", Icons.how_to_reg_rounded, Colors.green),
            _buildStatCard(context, "Interviews", "312", Icons.forum_rounded, Colors.orange),
            _buildStatCard(context, "Success Rate", "92%", Icons.trending_up_rounded, Colors.purpleAccent),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInformationCards(BuildContext context, ProfileDataProvider provider) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _buildInfoCard(
          context,
          title: "Personal & Contact Information",
          icon: Icons.person_outline_rounded,
          children: [
            _buildInfoRow(context, Icons.email_outlined, "Email Address", provider.email),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.phone_outlined, "Phone Number", provider.phone),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.location_on_outlined, "Work Location", provider.location),
          ],
        ),
        const SizedBox(height: 20),
        _buildInfoCard(
          context,
          title: "Professional Credentials",
          icon: Icons.work_outline_rounded,
          children: [
            _buildInfoRow(context, Icons.badge_outlined, "Employee ID", provider.employeeId),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.corporate_fare_rounded, "Department", provider.department),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.work_history_outlined, "Role / Designation", provider.role),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.star_border_rounded, "Recruiting Experience", provider.experience),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.calendar_today_outlined, "Joining Date", provider.joiningDate),
          ],
        ),
        const SizedBox(height: 20),
        _buildInfoCard(
          context,
          title: "Company Information",
          icon: Icons.business_rounded,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.business_rounded, color: Colors.blueAccent, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.companyName,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Enterprise SaaS Provider • Verified",
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.category_outlined, "Industry Domain", provider.industry),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.people_outline_rounded, "Company Size", provider.companySize),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.language_rounded, "Corporate Website", provider.website),
            Divider(height: 1, color: theme.dividerColor),
            _buildInfoRow(context, Icons.map_outlined, "Headquarters", provider.headquarters),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required IconData icon, required List<Widget> children}) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData iconData, String title, String subtitle) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, color: theme.colorScheme.onSurfaceVariant, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedSettingsMenu(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _buildSettingsGroup(
          context,
          sectionTitle: "GENERAL",
          items: [
            _SettingsItem(
              icon: Icons.person_outline_rounded,
              title: "Personal Information",
              subtitle: "Name, email, phone number, and designation",
              destination: const ProfilePersonalInfoScreen(),
            ),
            _SettingsItem(
              icon: Icons.business_center_outlined,
              title: "Company & Organization",
              subtitle: "Organization details, industry, size, and website",
              destination: const ProfileCompanyScreen(),
            ),
            _SettingsItem(
              icon: Icons.payment_rounded,
              title: "Subscription & Billing",
              subtitle: "Enterprise plan status, invoices, and payment methods",
              destination: const ProfileSubscriptionScreen(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSettingsGroup(
          context,
          sectionTitle: "NOTIFICATIONS",
          items: [
            _SettingsItem(
              icon: Icons.notifications_none_rounded,
              title: "Notification Preferences",
              subtitle: "Push alerts, email digests, and interview reminders",
              destination: const ProfileNotificationsScreen(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSettingsGroup(
          context,
          sectionTitle: "APPEARANCE",
          items: [
            _SettingsItem(
              icon: Icons.palette_outlined,
              title: "App Preferences & Theme",
              subtitle: "Theme mode (Light/Dark), language, date format, and time zone",
              destination: const ProfilePreferencesScreen(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSettingsGroup(
          context,
          sectionTitle: "PRIVACY & SECURITY",
          items: [
            _SettingsItem(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Settings",
              subtitle: "Recruiter profile visibility and anonymized data sharing",
              destination: const ProfileSecurityScreen(),
            ),
            _SettingsItem(
              icon: Icons.security_rounded,
              title: "Account Security",
              subtitle: "Password update, two-factor authentication (2FA), and active sessions",
              destination: const ProfileSecurityScreen(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSettingsGroup(
          context,
          sectionTitle: "SUPPORT & ABOUT",
          items: [
            _SettingsItem(
              icon: Icons.help_outline_rounded,
              title: "Help & Support Center",
              subtitle: "FAQs, 24/7 enterprise support, bug reporting, and feedback",
              destination: const ProfileHelpScreen(),
            ),
            _SettingsItem(
              icon: Icons.info_outline_rounded,
              title: "About JobNest",
              subtitle: "Version 4.2.0, developer info, open source licenses, and terms",
              destination: const ProfileAboutScreen(),
            ),
          ],
        ),
        const SizedBox(height: 24),
        AppCard(
          padding: EdgeInsets.zero,
          child: Semantics(
            label: "Log out of JobNest Enterprise",
            button: true,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 64),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.logout_rounded, color: theme.colorScheme.error, size: 22),
                ),
                title: Text(
                  "Logout from JobNest",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.error,
                  ),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text("Clear local session and terminate access on this device"),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.error),
                onTap: () => _showLogoutDialog(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsGroup(BuildContext context, {required String sectionTitle, required List<_SettingsItem> items}) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              sectionTitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          ...items.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            final isLast = idx == items.length - 1;
            return Column(
              children: [
                Semantics(
                  label: "${item.title}. ${item.subtitle}",
                  button: true,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 64),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, color: theme.colorScheme.onSurface, size: 22),
                      ),
                      title: Text(
                        item.title,
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          item.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.3,
                          ),
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => item.destination));
                      },
                    ),
                  ),
                ),
                if (!isLast) Divider(height: 1, color: theme.dividerColor),
              ],
            );
          }),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out of JobNest?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: TextButton.styleFrom(minimumSize: const Size(64, 48)),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop(); // Close dialog
              await SessionManager.instance.logout();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthFlowScreen()),
                (route) => false,
              );
            },
            style: TextButton.styleFrom(minimumSize: const Size(64, 48)),
            child: const Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoading(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const AppShimmerLoading(width: 128, height: 128, borderRadius: BorderRadius.all(Radius.circular(64))),
              const SizedBox(height: 16),
              const AppShimmerLoading(width: 220, height: 24),
              const SizedBox(height: 8),
              const AppShimmerLoading(width: 320, height: 16),
              const SizedBox(height: 32),
              const AppSkeletonCard(),
              const SizedBox(height: 24),
              const AppSkeletonCard(),
              const SizedBox(height: 24),
              const AppSkeletonCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ProfileDataProvider provider) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: AppErrorState(
        title: "Connection Error",
        message: "Unable to sync recruiter profile data with JobNest enterprise servers. Please check your network connection.",
        primaryButtonText: "Retry Connection",
        onRetry: () => provider.refreshProfile(),
        iconData: Icons.cloud_off_rounded,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ProfileDataProvider provider) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: AppCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_add_alt_1_rounded, size: 56, color: theme.colorScheme.primary),
                ),
                const SizedBox(height: 20),
                Text(
                  "Profile Uninitialized",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your enterprise recruiter profile has not been configured yet. Set up your contact and organization credentials to begin recruiting.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () => provider.restoreDefaults(),
                    icon: const Icon(Icons.build_circle_rounded),
                    label: const Text("Initialize Recruiter Profile", style: TextStyle(fontWeight: FontWeight.bold)),
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

class _SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget destination;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.destination,
  });
}
