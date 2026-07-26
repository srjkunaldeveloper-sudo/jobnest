import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';

class ProfileDeviceSecurityScreen extends StatelessWidget {
  const ProfileDeviceSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Flutter local_auth integration.

    // TODO:
    // Android BiometricPrompt.

    // TODO:
    // iOS Face ID / Touch ID.

    // TODO:
    // Secure token storage.

    // TODO:
    // Device registration API.

    // TODO:
    // Trusted device synchronization.

    // TODO:
    // Session validation.

    // TODO:
    // Biometric re-authentication.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Security & Biometrics"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => provider.toggleTrustedDevicesEmptyState(),
            icon: Icon(provider.isTrustedDevicesEmpty
                ? Icons.devices_rounded
                : Icons.devices_other_outlined),
            tooltip: "Toggle Trusted Devices Empty State (QA)",
          ),
          IconButton(
            onPressed: () => _showResetConfirmDialog(context, provider),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: "Restore Default Device Security Settings",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: DEVICE SECURITY OVERVIEW
                _buildSectionHeader(
                  theme,
                  "Device Security Overview",
                  "Real-time status of hardware biometric enrollment and trusted enterprise workstations.",
                  Icons.shield_rounded,
                ),
                const SizedBox(height: 14),
                _buildOverviewCard(context, provider),
                const SizedBox(height: 32),

                // Section 2: BIOMETRIC LOGIN
                _buildSectionHeader(
                  theme,
                  "Biometric Login Methods",
                  "Fast, secure hardware-based authentication for instant workspace unlock.",
                  Icons.fingerprint_rounded,
                ),
                const SizedBox(height: 14),
                _buildBiometricLoginSection(context, provider),
                const SizedBox(height: 32),

                // Section 3: APP LOCK & AUTO LOCK
                _buildSectionHeader(
                  theme,
                  "Workspace Lock & Inactivity Timeout",
                  "Protect recruiting pipelines when stepping away from your workstation.",
                  Icons.lock_clock_rounded,
                ),
                const SizedBox(height: 14),
                _buildAppLockSection(context, provider),
                const SizedBox(height: 32),

                // Section 4: SENSITIVE ACTION PROTECTION
                _buildSectionHeader(
                  theme,
                  "Sensitive Action Protection",
                  "Require biometric re-authentication before executing critical enterprise operations.",
                  Icons.admin_panel_settings_rounded,
                ),
                const SizedBox(height: 14),
                _buildSensitiveActionSection(context, provider),
                const SizedBox(height: 32),

                // Section 5: TRUSTED DEVICES
                _buildSectionHeader(
                  theme,
                  "Trusted Devices & Workstations",
                  "Devices authorized to access JobNest without repeated verification challenges.",
                  Icons.devices_rounded,
                ),
                const SizedBox(height: 14),
                _buildTrustedDevicesSection(context, provider),
                const SizedBox(height: 32),

                // Section 6: NEW DEVICE ALERTS
                _buildSectionHeader(
                  theme,
                  "New Device & Login Alerts",
                  "Receive notifications whenever an unrecognized device attempts to access your account.",
                  Icons.notifications_active_rounded,
                ),
                const SizedBox(height: 14),
                _buildNewDeviceAlertsSection(context, provider),
                const SizedBox(height: 32),

                // Section 7: SESSION PROTECTION
                _buildSectionHeader(
                  theme,
                  "Session Security & Persistence",
                  "Control how long authentication tokens remain valid across sessions.",
                  Icons.security_rounded,
                ),
                const SizedBox(height: 14),
                _buildSessionProtectionSection(context, provider),
                const SizedBox(height: 32),

                // Section 8: DEVICE HISTORY
                _buildSectionHeader(
                  theme,
                  "Recent Login & Device History",
                  "Audit trail of recent authentication sessions across all platforms and locations.",
                  Icons.history_rounded,
                ),
                const SizedBox(height: 14),
                _buildDeviceHistorySection(context, provider),
                const SizedBox(height: 32),

                // Section 9: SECURITY RECOMMENDATIONS
                _buildSectionHeader(
                  theme,
                  "Security Recommendations",
                  "Proactive steps to fortify your recruiter workspace against unauthorized access.",
                  Icons.lightbulb_outline_rounded,
                ),
                const SizedBox(height: 14),
                _buildRecommendationsSection(context, provider),
                const SizedBox(height: 32),

                // Section 10: EMERGENCY ACTIONS
                _buildSectionHeader(
                  theme,
                  "Emergency Security Actions",
                  "Critical account lockdowns in the event of a lost device or suspected breach.",
                  Icons.warning_rounded,
                ),
                const SizedBox(height: 14),
                _buildEmergencyActionsSection(context, provider),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final activeCount =
        provider.isTrustedDevicesEmpty ? 0 : provider.trustedDevicesList.length;

    int activeBio = 0;
    if (provider.bioFingerprintEnabled) activeBio++;
    if (provider.bioFaceUnlockEnabled) activeBio++;
    if (provider.bioPasscodeEnabled) activeBio++;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
            theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.security_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ENTERPRISE DEVICE SHIELD",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Hardware & Biometric Defense Active",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.shade600),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_user_rounded,
                        size: 16, color: Colors.green.shade700),
                    const SizedBox(width: 6),
                    Text(
                      "Protected",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 16,
            children: [
              _buildOverviewStat(
                context,
                label: "Biometric Status",
                value: "$activeBio Active Methods",
                icon: Icons.fingerprint_rounded,
                color: Colors.blue,
              ),
              _buildOverviewStat(
                context,
                label: "Trusted Devices",
                value: "$activeCount Authorized",
                icon: Icons.devices_rounded,
                color: Colors.purple,
              ),
              _buildOverviewStat(
                context,
                label: "Last Authentication",
                value: "2 Mins Ago (Touch ID)",
                icon: Icons.history_rounded,
                color: Colors.orange,
              ),
              _buildOverviewStat(
                context,
                label: "Security Level",
                value: "High (Tier-1 Shield)",
                icon: Icons.shield_outlined,
                color: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 180, maxWidth: 210),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricLoginSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildBiometricTile(
            context,
            icon: Icons.fingerprint_rounded,
            title: "Fingerprint / Touch ID",
            description: "Hardware sensor recognition for rapid desktop and mobile unlock",
            statusBadge: "Available",
            badgeColor: Colors.green,
            value: provider.bioFingerprintEnabled,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(fingerprint: val);
              _showFeedback(context,
                  val ? "Fingerprint authentication enabled" : "Fingerprint disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildBiometricTile(
            context,
            icon: Icons.face_unlock_rounded,
            title: "Face Unlock / Face ID",
            description: "Infrared facial scanning recognition for hands-free login",
            statusBadge: "Available",
            badgeColor: Colors.green,
            value: provider.bioFaceUnlockEnabled,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(faceUnlock: val);
              _showFeedback(context,
                  val ? "Face unlock authentication enabled" : "Face unlock disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildBiometricTile(
            context,
            icon: Icons.pin_rounded,
            title: "Device Passcode / PIN",
            description: "System PIN, pattern, or alphanumeric fallback lock code",
            statusBadge: provider.bioPasscodeEnabled ? "Available" : "Not Configured",
            badgeColor: provider.bioPasscodeEnabled ? Colors.green : Colors.orange,
            value: provider.bioPasscodeEnabled,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(passcode: val);
              _showFeedback(context,
                  val ? "Device passcode fallback enabled" : "Device passcode disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String statusBadge,
    required Color badgeColor,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        statusBadge,
                        style: TextStyle(
                          color: badgeColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildAppLockSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildSelectorTile(
            context,
            icon: Icons.lock_clock_outlined,
            title: "Require Authentication (App Lock)",
            value: provider.bioAppLockTimeout,
            options: [
              "Immediately",
              "After 1 Minute",
              "After 5 Minutes",
              "After 15 Minutes",
              "After 30 Minutes",
              "Never"
            ],
            onSelect: (val) {
              provider.updateDeviceSecuritySetting(appLockTimeout: val);
              _showFeedback(context, "App lock timeout set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.timer_outlined,
            title: "Auto Lock After Inactivity",
            value: provider.bioAutoLockInactivity,
            options: [
              "1 Minute",
              "5 Minutes",
              "10 Minutes",
              "30 Minutes",
              "Never"
            ],
            onSelect: (val) {
              provider.updateDeviceSecuritySetting(autoLockInactivity: val);
              _showFeedback(context, "Auto lock inactivity set to $val");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSensitiveActionSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildToggleTile(
            context,
            icon: Icons.credit_card_rounded,
            title: "Billing & Payment Modifications",
            subtitle: "Require biometric check before updating corporate invoices or payment cards",
            value: provider.bioProtectBilling,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(protectBilling: val);
              _showFeedback(context,
                  val ? "Billing protection active" : "Billing protection disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.card_membership_rounded,
            title: "Subscription & Seat Licensing Changes",
            subtitle: "Protect against unauthorized enterprise tier upgrades or cancellations",
            value: provider.bioProtectSubscription,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(protectSubscription: val);
              _showFeedback(context,
                  val ? "Subscription protection active" : "Subscription protection disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.delete_forever_rounded,
            title: "Account Deletion & Termination",
            subtitle: "Mandate hardware biometric verification before wiping recruiter data",
            value: provider.bioProtectDeleteAccount,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(protectDelete: val);
              _showFeedback(context,
                  val ? "Account deletion protection active" : "Account deletion protection disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.download_rounded,
            title: "Candidate Database & Resume Export",
            subtitle: "Verify identity before downloading large CSVs or resume archives",
            value: provider.bioProtectDataExport,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(protectExport: val);
              _showFeedback(context,
                  val ? "Data export protection active" : "Data export protection disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.verified_user_outlined,
            title: "Verification Badge Modifications",
            subtitle: "Require authentication before altering corporate domain or identity proofs",
            value: provider.bioProtectVerification,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(protectVerification: val);
              _showFeedback(context,
                  val ? "Verification protection active" : "Verification protection disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.security_rounded,
            title: "Security & 2FA Settings Access",
            subtitle: "Protect password resets and authenticator token re-generation",
            value: provider.bioProtectSecuritySettings,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(protectSecurity: val);
              _showFeedback(context,
                  val ? "Security settings protection active" : "Security settings protection disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrustedDevicesSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    if (provider.isTrustedDevicesEmpty || provider.trustedDevicesList.isEmpty) {
      return AppCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.devices_other_rounded,
                  size: 48, color: Colors.orange),
            ),
            const SizedBox(height: 16),
            Text(
              "No trusted devices found.",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "Your current workstation has not been registered as an authorized device. Registering your device skips repetitive 2FA prompts.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                provider.registerCurrentDeviceAsTrusted();
                _showFeedback(context, "Current device registered as trusted workstation!");
              },
              icon: const Icon(Icons.add_to_queue_rounded, size: 18),
              label: const Text("Register This Device",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: provider.trustedDevicesList.map((dev) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: dev.isCurrentDevice
                            ? Colors.green.withValues(alpha: 0.15)
                            : theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        dev.deviceType.contains("Mobile")
                            ? Icons.smartphone_rounded
                            : Icons.laptop_mac_rounded,
                        color: dev.isCurrentDevice
                            ? Colors.green.shade700
                            : theme.colorScheme.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  dev.deviceName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (dev.isCurrentDevice)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.green.shade600),
                                  ),
                                  child: Text(
                                    "CURRENT DEVICE",
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "TRUSTED",
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${dev.platform} • ${dev.browser}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Type: ${dev.deviceType} • Last Active: ${dev.loginTime}",
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _showRenameDeviceDialog(context, dev.deviceName);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: const Text("Rename Device"),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _showFeedback(
                            context, "${dev.deviceName} marked as trusted!");
                      },
                      icon: const Icon(Icons.verified_outlined, size: 16),
                      label: const Text("Mark as Trusted"),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        provider.removeTrustedDevice(dev.id);
                        _showFeedback(
                            context, "Device '${dev.deviceName}' removed from trusted list");
                      },
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: 16, color: Colors.red),
                      label: const Text("Remove Device",
                          style: TextStyle(color: Colors.red)),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNewDeviceAlertsSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildToggleTile(
            context,
            icon: Icons.email_outlined,
            title: "Email Security Alert",
            subtitle: "Send immediate email warning to primary recruiter address",
            value: provider.bioAlertEmail,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(alertEmail: val);
              _showFeedback(context,
                  val ? "Email alerts enabled" : "Email alerts disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.notifications_on_outlined,
            title: "Push Notification Alert",
            subtitle: "Send instant mobile push alert to active devices upon new login",
            value: provider.bioAlertPush,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(alertPush: val);
              _showFeedback(context,
                  val ? "Push alerts enabled" : "Push alerts disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.sms_outlined,
            title: "SMS Text Alert",
            subtitle: "Send SMS text message with verification timestamp and IP location",
            value: provider.bioAlertSms,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(alertSms: val);
              _showFeedback(context,
                  val ? "SMS alerts enabled" : "SMS alerts disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.warning_amber_rounded,
            title: "In-App Security Warning Banner",
            subtitle: "Display prominent header banner warning upon next dashboard login",
            value: provider.bioAlertWarning,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(alertWarning: val);
              _showFeedback(context,
                  val ? "Warning banner enabled" : "Warning banner disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSessionProtectionSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildToggleTile(
            context,
            icon: Icons.logout_rounded,
            title: "Auto Logout on Browser Exit",
            subtitle: "Automatically terminate session tokens whenever the browser window closes",
            value: provider.bioSessionAutoLogout,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(sessionLogout: val);
              _showFeedback(context,
                  val ? "Auto logout enabled" : "Auto logout disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.remember_me_outlined,
            title: "Remember Trusted Devices",
            subtitle: "Skip repetitive 2FA verification challenges on trusted workstations for 30 days",
            value: provider.bioSessionRememberDevice,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(sessionRemember: val);
              _showFeedback(context,
                  val ? "Remember device active" : "Remember device disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.verified_user_rounded,
            title: "Require Login Again (24h Renewal)",
            subtitle: "Force authentication renewal every 24 hours regardless of active recruiting work",
            value: provider.bioSessionRequireLoginAgain,
            onChanged: (val) {
              provider.updateDeviceSecuritySetting(sessionRequireLogin: val);
              _showFeedback(context,
                  val ? "24h renewal active" : "24h renewal disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceHistorySection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: provider.deviceLoginHistoryList.map((hist) {
        Color badgeColor = Colors.blue;
        if (hist.status == "Current Device") badgeColor = Colors.green;
        if (hist.status == "Unknown Device") badgeColor = Colors.orange;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AppCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    hist.deviceType.contains("Mobile")
                        ? Icons.phone_iphone_rounded
                        : hist.deviceType.contains("Server")
                            ? Icons.terminal_rounded
                            : Icons.desktop_windows_rounded,
                    color: badgeColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              hist.deviceName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: badgeColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              hist.status,
                              style: TextStyle(
                                color: badgeColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${hist.platform} • ${hist.browser}",
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Date: ${hist.loginTime} • Loc: ${hist.location}",
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecommendationsSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final recs = [
      {
        "title": "Enable Fingerprint Login",
        "desc": "Hardware-backed Touch ID prevents credential stuffing and phishing attacks.",
        "icon": Icons.fingerprint_rounded,
        "action": "Review Now",
      },
      {
        "title": "Enable Face Unlock",
        "desc": "Instant infrared biometric recognition for seamless mobile recruiter access.",
        "icon": Icons.face_unlock_rounded,
        "action": "Review Now",
      },
      {
        "title": "Review Trusted Devices",
        "desc": "Periodically audit and prune old or unused workstations to minimize risk.",
        "icon": Icons.devices_rounded,
        "action": "Audit List",
      },
      {
        "title": "Turn On Device Alerts",
        "desc": "Get notified instantly if an unknown IP attempts to log into your account.",
        "icon": Icons.notifications_active_outlined,
        "action": "Configure Alerts",
      },
      {
        "title": "Enable App Lock",
        "desc": "Lock your screen automatically after 5 minutes of inactivity for privacy.",
        "icon": Icons.lock_clock_outlined,
        "action": "Set Timeout",
      },
    ];

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: recs.map((rec) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 440),
          child: AppCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(rec["icon"] as IconData,
                          color: Theme.of(context).colorScheme.primary,
                          size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rec["title"] as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rec["desc"] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      _showFeedback(context, "Recommendation Action: ${rec["action"]}");
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      rec["action"] as String,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmergencyActionsSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.warning_amber_rounded,
                    color: Colors.red, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Emergency Lockdown Controls",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 2),
                    Text(
                        "Execute instant security countermeasures in the event of a compromised account or lost laptop.",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 12,
            children: [
              OutlinedButton.icon(
                onPressed: () => _showEmergencyConfirmDialog(
                  context,
                  title: "Remove All Trusted Devices?",
                  desc: "This will revoke authorization for all workstations. Every device will require full 2FA challenge upon next login.",
                  actionLabel: "Remove All",
                  actionColor: Colors.red,
                  onConfirm: () {
                    provider.removeAllTrustedDevices();
                    _showFeedback(context, "All trusted devices removed!");
                  },
                ),
                icon: const Icon(Icons.devices_other_rounded,
                    size: 18, color: Colors.red),
                label: const Text("Remove All Trusted Devices",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red, width: 1.5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _showEmergencyConfirmDialog(
                  context,
                  title: "Disable All Biometrics?",
                  desc: "This will disable Fingerprint, Touch ID, and Face Unlock across all devices. Passcode / password fallback will be enforced.",
                  actionLabel: "Disable Biometrics",
                  actionColor: Colors.orange,
                  onConfirm: () {
                    provider.disableAllBiometrics();
                    _showFeedback(context, "All biometric methods disabled!");
                  },
                ),
                icon: const Icon(Icons.fingerprint_rounded,
                    size: 18, color: Colors.orange),
                label: const Text("Disable Biometrics",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.orange, width: 1.5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
              ),
              FilledButton.icon(
                onPressed: () => _showEmergencyConfirmDialog(
                  context,
                  title: "Log Out Everywhere?",
                  desc: "This will immediately terminate all active sessions across desktop web, iOS, and Android applications. You will need to log back in.",
                  actionLabel: "Log Out All Sessions",
                  actionColor: Colors.red.shade700,
                  onConfirm: () {
                    _showFeedback(
                        context, "All sessions terminated across all devices!");
                  },
                ),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: const Text("Log Out Everywhere",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      secondary: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 22),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subtitle,
          style:
              TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSelectorTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String> onSelect,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 22),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
            fontSize: 13,
          ),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (ctx) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (ctx, i) {
                      final opt = options[i];
                      final isSel = opt == value;
                      return ListTile(
                        title: Text(opt,
                            style: TextStyle(
                                fontWeight:
                                    isSel ? FontWeight.bold : FontWeight.normal)),
                        trailing: isSel
                            ? Icon(Icons.check_circle_rounded,
                                color: theme.colorScheme.primary)
                            : null,
                        onTap: () {
                          Navigator.pop(ctx);
                          onSelect(opt);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRenameDeviceDialog(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Rename Workstation"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter a friendly name to easily identify this device:"),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g., Office MacBook Pro",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showFeedback(context,
                  "Device renamed to '${controller.text.trim()}' (Dummy action)");
            },
            child: const Text("Save Name"),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmDialog(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 10),
            Expanded(child: Text("Restore Default Settings?")),
          ],
        ),
        content: const Text(
          "Are you sure you want to reset all biometric enrollment toggles, app lock timeouts, sensitive action protections, and trusted device lists back to default enterprise values?",
          style: TextStyle(height: 1.5, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              provider.resetDeviceSecurityToDefaults();
              _showFeedback(context, "All device security defaults restored!");
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text("Restore Defaults"),
            style: FilledButton.styleFrom(backgroundColor: Colors.orange),
          ),
        ],
      ),
    );
  }

  void _showEmergencyConfirmDialog(
    BuildContext context, {
    required String title,
    required String desc,
    required String actionLabel,
    required Color actionColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.gpp_maybe_rounded, color: actionColor),
            const SizedBox(width: 10),
            Expanded(child: Text(title)),
          ],
        ),
        content: Text(
          desc,
          style: const TextStyle(height: 1.5, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            style: FilledButton.styleFrom(backgroundColor: actionColor),
            child: Text(actionLabel,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message (Dummy action)"),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
