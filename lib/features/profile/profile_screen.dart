import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
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

    // ===== BACKEND TODO =====
    // TODO: Recruiter profile backend se load hoga.
    // TODO: Company profile API connect hogi.
    // TODO: User stats analytics backend se aayenge.
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded),
            tooltip: "Share Profile",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(context),
                const SizedBox(height: 32),
                
                Text(
                  "Quick Stats",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildQuickStats(context),
                const SizedBox(height: 32),
                
                Text(
                  "Recruiter Profile",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildRecruiterProfileCard(context),
                const SizedBox(height: 32),
                
                Text(
                  "Company Information",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildCompanyCard(context),
                const SizedBox(height: 32),
                
                Text(
                  "Account & Settings",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildAccountMenu(context),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  "SS",
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  color: Colors.blueAccent,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Sonu Surya",
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          "Senior Tech Recruiter at TechNova Solutions",
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit_outlined, size: 18),
          label: const Text("Edit Profile"),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
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

  Widget _buildRecruiterProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildInfoTile(context, Icons.email_outlined, "Email Address", "sonusurya@technova.com"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.phone_outlined, "Phone Number", "+91 98765 43210"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.badge_outlined, "Employee ID", "EMP-2024-8901"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.corporate_fare_rounded, "Department", "Human Resources"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.work_outline_rounded, "Role", "Senior Recruiter"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.star_border_rounded, "Experience", "8+ Years"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.location_on_outlined, "Location", "Bangalore, India"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.calendar_today_outlined, "Joining Date", "October 12, 2021"),
        ],
      ),
    );
  }

  Widget _buildCompanyCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
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
                        "TechNova Solutions",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Enterprise SaaS provider",
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.category_outlined, "Industry", "Software & Technology"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.people_outline_rounded, "Company Size", "500 - 1000 Employees"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.language_rounded, "Website", "https://technova.dev"),
          Divider(height: 1, color: theme.dividerColor),
          _buildInfoTile(context, Icons.map_outlined, "Headquarters", "Koramangala, Bangalore"),
        ],
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, IconData icon, String title, String subtitle) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.titleSmall?.copyWith(
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

  Widget _buildAccountMenu(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildMenuTile(context, Icons.person_outline_rounded, "Personal Information", const ProfilePersonalInfoScreen()),
          Divider(height: 1, color: theme.dividerColor),
          _buildMenuTile(context, Icons.business_rounded, "Company Profile", const ProfileCompanyScreen()),
          Divider(height: 1, color: theme.dividerColor),
          _buildMenuTile(context, Icons.security_rounded, "Security", const ProfileSecurityScreen()),
          Divider(height: 1, color: theme.dividerColor),
          _buildMenuTile(context, Icons.notifications_none_rounded, "Notifications", const ProfileNotificationsScreen()),
          Divider(height: 1, color: theme.dividerColor),
          _buildMenuTile(context, Icons.settings_outlined, "Preferences", const ProfilePreferencesScreen()),
          Divider(height: 1, color: theme.dividerColor),
          _buildMenuTile(context, Icons.payment_rounded, "Subscription", const ProfileSubscriptionScreen()),
          Divider(height: 1, color: theme.dividerColor),
          _buildMenuTile(context, Icons.help_outline_rounded, "Help & Support", const ProfileHelpScreen()),
          Divider(height: 1, color: theme.dividerColor),
          _buildMenuTile(context, Icons.info_outline_rounded, "About JobNest", const ProfileAboutScreen()),
          Divider(height: 1, color: theme.dividerColor),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            leading: Icon(Icons.logout_rounded, color: theme.colorScheme.error),
            title: Text(
              "Logout",
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, IconData icon, String title, Widget destination) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(icon, color: theme.colorScheme.onSurface),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
    );
  }
}
