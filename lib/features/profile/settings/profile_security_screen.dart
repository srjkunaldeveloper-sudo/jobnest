import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/session_manager.dart';
import '../../../core/widgets/app_card.dart';
import '../../auth/auth_flow_screen.dart';
import '../providers/profile_data_provider.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final TextEditingController _currentPassCtrl = TextEditingController();
  final TextEditingController _newPassCtrl = TextEditingController();
  final TextEditingController _confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    _currentPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Fetch security settings.

    // TODO:
    // Update password.

    // TODO:
    // Enable 2FA.

    // TODO:
    // Session management.

    // TODO:
    // Login history API.

    // TODO:
    // Device management.

    // TODO:
    // Account recovery API.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enterprise Security Center"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Security Score Card & Overview
                _buildSecurityScoreCard(context, provider),
                const SizedBox(height: 28),

                // Section 2: Security Checkup
                _buildSectionHeader(
                  theme,
                  "Security Checkup",
                  "Review recommended account protection safeguards and completion status.",
                  AppIcons.verified_user_outlined,
                ),
                const SizedBox(height: 14),
                _buildSecurityCheckupCard(context, provider),
                const SizedBox(height: 32),

                // Section 3: Password Management
                _buildSectionHeader(
                  theme,
                  "Password Management",
                  "Update your account password and review enterprise cryptographic strength rules.",
                  AppIcons.key_outlined,
                ),
                const SizedBox(height: 14),
                _buildPasswordManagementCard(context, provider),
                const SizedBox(height: 32),

                // Section 4: Multi-Factor Authentication (2FA)
                _buildSectionHeader(
                  theme,
                  "Two-Factor Authentication (2FA)",
                  "Require an additional verification code when signing in from unrecognized devices.",
                  AppIcons.shield_outlined,
                ),
                const SizedBox(height: 14),
                _build2FACard(context, provider),
                const SizedBox(height: 32),

                // Section 5: Account Recovery
                _buildSectionHeader(
                  theme,
                  "Account Recovery Options",
                  "Configure fallback communication channels to regain access if locked out.",
                  AppIcons.restore_page_outlined,
                ),
                const SizedBox(height: 14),
                _buildAccountRecoveryCard(context, provider),
                const SizedBox(height: 32),

                // Section 6: Active Sessions (Device Management)
                _buildSectionHeader(
                  theme,
                  "Active Sessions & Devices",
                  "Manage signed-in browsers and workstations across your enterprise network.",
                  AppIcons.devices_rounded,
                ),
                const SizedBox(height: 14),
                _buildActiveSessionsCard(context, provider),
                const SizedBox(height: 32),

                // Section 7: Recent Login Activity
                _buildSectionHeader(
                  theme,
                  "Recent Login Activity",
                  "Audit recent access attempts, geolocation diagnostics, and session results.",
                  AppIcons.history_rounded,
                ),
                const SizedBox(height: 14),
                _buildLoginActivityCard(context, provider),
                const SizedBox(height: 32),

                // Section 8: Privacy Controls
                _buildSectionHeader(
                  theme,
                  "Enterprise Privacy Controls",
                  "Control visibility of your recruiter profile and activity diagnostics across JobNest.",
                  AppIcons.privacy_tip_outlined,
                ),
                const SizedBox(height: 14),
                _buildPrivacyControlsCard(context, provider),
                const SizedBox(height: 32),

                // Section 9: Login Alerts & Monitoring
                _buildSectionHeader(
                  theme,
                  "Login Alerts & Threat Monitoring",
                  "Receive instant notifications for suspicious sign-ins or credential modifications.",
                  AppIcons.notifications_active_outlined,
                ),
                const SizedBox(height: 14),
                _buildLoginAlertsCard(context, provider),
                const SizedBox(height: 36),

                // Section 10: Danger Zone
                _buildSectionHeader(
                  theme,
                  "Danger Zone",
                  "High-risk destructive actions that permanently impact account access and data.",
                  AppIcons.warning_amber_rounded,
                  isDanger: true,
                ),
                const SizedBox(height: 14),
                _buildDangerZoneCard(context),
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
    IconData icon, {
    bool isDanger = false,
  }) {
    final color = isDanger ? theme.colorScheme.error : theme.colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDanger ? color : null,
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

  Widget _buildSecurityScoreCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final score = provider.securityScore;
    final status = provider.securityStatusLabel;

    Color statusColor;
    IconData statusIcon;
    if (score >= 90) {
      statusColor = Colors.green;
      statusIcon = AppIcons.verified_rounded;
    } else if (score >= 75) {
      statusColor = Colors.amber.shade700;
      statusIcon = AppIcons.admin_panel_settings_rounded;
    } else {
      statusColor = theme.colorScheme.error;
      statusIcon = AppIcons.gpp_bad_rounded;
    }

    return AppCard(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 24,
          runSpacing: 20,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: score / 100.0,
                        strokeWidth: 8,
                        backgroundColor: theme.colorScheme.outlineVariant
                            .withValues(alpha: 0.3),
                        color: statusColor,
                      ),
                      Text(
                        "$score%",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(statusIcon, size: 20, color: statusColor),
                          const SizedBox(width: 8),
                          Text(
                            "Security Score: $status",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Your enterprise account is currently protected by multi-factor authentication, verified recovery channels, and continuous threat diagnostics.",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                _showFeedback(context, "Running security diagnostic check");
              },
              icon: const Icon(AppIcons.shield_outlined, size: 18),
              label: const Text("Run Diagnostics"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityCheckupCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final items = [
      _CheckupItem(
        title: "Strong Password Configured",
        subtitle: "Password updated within recommended 90-day window.",
        isCompleted: true,
      ),
      _CheckupItem(
        title: "Recovery Email Verified",
        subtitle: provider.recoveryEmail.isNotEmpty
            ? "Verified (${provider.recoveryEmail})"
            : "No recovery email linked.",
        isCompleted: provider.recoveryEmail.isNotEmpty,
      ),
      _CheckupItem(
        title: "Recovery Phone Verified",
        subtitle: provider.recoveryPhone.isNotEmpty
            ? "Verified (${provider.recoveryPhone})"
            : "No recovery phone linked.",
        isCompleted: provider.recoveryPhone.isNotEmpty,
      ),
      _CheckupItem(
        title: "Two-Factor Authentication (2FA)",
        subtitle: provider.twoFactorAuthEnabled
            ? "Active via Authenticator App & SMS OTP."
            : "Disabled. Highly recommended for recruiter accounts.",
        isCompleted: provider.twoFactorAuthEnabled,
      ),
      _CheckupItem(
        title: "Active Sessions Reviewed",
        subtitle:
            "${provider.activeSessionsList.length} signed-in devices currently active.",
        isCompleted: true,
      ),
    ];

    final completedCount = items.where((i) => i.isCompleted).length;
    final percent = ((completedCount / items.length) * 100).round();

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Checklist Progress: $completedCount of ${items.length} Completed ($percent%)",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  width: 120,
                  height: 8,
                  child: LinearProgressIndicator(
                    value: completedCount / items.length,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    color: percent == 100 ? Colors.green : theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (ctx, i) => Divider(
              height: 24,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: item.isCompleted
                          ? Colors.green.withValues(alpha: 0.15)
                          : theme.colorScheme.error.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.isCompleted
                          ? AppIcons.check_rounded
                          : AppIcons.priority_high_rounded,
                      size: 16,
                      color: item.isCompleted
                          ? Colors.green
                          : theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!item.isCompleted)
                    TextButton(
                      onPressed: () {
                        _showFeedback(context, "Navigating to configure ${item.title}");
                      },
                      child: const Text("Resolve"),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordManagementCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final reqs = [
      "Minimum 8 characters",
      "At least one uppercase letter (A-Z)",
      "At least one lowercase letter (a-z)",
      "At least one numeric digit (0-9)",
      "At least one special symbol (!@#\$%^&*)",
    ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(AppIcons.access_time_rounded,
                      size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    "Last Password Change: ${provider.lastPasswordChangeDate}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(AppIcons.check_circle, size: 14, color: Colors.green),
                    SizedBox(width: 6),
                    Text(
                      "Password Strength: Strong",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 20),

          // Fields
          _buildPassField(
            context,
            "Current Password",
            _currentPassCtrl,
            _obscureCurrent,
            () => setState(() => _obscureCurrent = !_obscureCurrent),
          ),
          const SizedBox(height: 16),
          _buildPassField(
            context,
            "New Password",
            _newPassCtrl,
            _obscureNew,
            () => setState(() => _obscureNew = !_obscureNew),
          ),
          const SizedBox(height: 16),
          _buildPassField(
            context,
            "Confirm New Password",
            _confirmPassCtrl,
            _obscureConfirm,
            () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
          const SizedBox(height: 24),

          Text(
            "Enterprise Password Requirements:",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: reqs.map((r) {
              return ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(AppIcons.check_circle_rounded,
                        size: 15, color: Colors.green),
                    const SizedBox(width: 6),
                    Text(r, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () {
                if (_currentPassCtrl.text.isEmpty ||
                    _newPassCtrl.text.isEmpty ||
                    _confirmPassCtrl.text.isEmpty) {
                  _showFeedback(
                      context, "Please complete all password fields");
                  return;
                }
                if (_newPassCtrl.text != _confirmPassCtrl.text) {
                  _showFeedback(context, "New passwords do not match!");
                  return;
                }
                _currentPassCtrl.clear();
                _newPassCtrl.clear();
                _confirmPassCtrl.clear();
                _showFeedback(
                    context, "Password updated successfully (Dummy action)");
              },
              icon: const Icon(AppIcons.lock_reset_rounded),
              label: const Text(
                "Update Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassField(
    BuildContext context,
    String label,
    TextEditingController controller,
    bool isObscured,
    VoidCallback onToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isObscured,
          decoration: InputDecoration(
            hintText: "••••••••••••",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                isObscured
                    ? AppIcons.visibility_off_rounded
                    : AppIcons.visibility_rounded,
              ),
              tooltip: isObscured ? "Show password" : "Hide password",
            ),
          ),
        ),
      ],
    );
  }

  Widget _build2FACard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 10,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(AppIcons.security_rounded,
                              color: theme.colorScheme.primary, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            "Two-Factor Authentication (2FA)",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Protect your enterprise recruiter account by requiring a verification code in addition to your password.",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: provider.twoFactorAuthEnabled,
                  onChanged: (val) {
                    provider.toggleSecurity2FA('main', val);
                    _showFeedback(
                      context,
                      "Two-Factor Authentication ${val ? 'enabled' : 'disabled'}",
                    );
                  },
                ),
              ],
            ),
          ),
          if (provider.twoFactorAuthEnabled) ...[
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            _build2FAOption(
              context,
              "Authenticator App",
              "Use Google Authenticator, Authy, or Microsoft Authenticator to generate time-based OTP codes.",
              AppIcons.phone_android_rounded,
              provider.authenticatorAppEnabled,
              (val) => provider.toggleSecurity2FA('app', val),
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            _build2FAOption(
              context,
              "SMS Verification OTP",
              "Receive text message verification codes on your verified mobile phone number (${provider.recoveryPhone}).",
              AppIcons.sms_outlined,
              provider.smsOtpEnabled,
              (val) => provider.toggleSecurity2FA('sms', val),
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            _build2FAOption(
              context,
              "Email Verification OTP",
              "Receive one-time passcodes on your enterprise email address (${provider.recoveryEmail}).",
              AppIcons.email_outlined,
              provider.emailOtpEnabled,
              (val) => provider.toggleSecurity2FA('email', val),
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(AppIcons.password_rounded,
                          color: theme.colorScheme.primary, size: 20),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emergency Backup Codes",
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            provider.backupCodesGenerated
                                ? "10 unused backup codes remaining for emergency recovery."
                                : "No backup codes generated.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showBackupCodesDialog(context);
                    },
                    icon: const Icon(AppIcons.qr_code_2_rounded, size: 18),
                    label: const Text("View Backup Codes"),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _build2FAOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool val,
    Function(bool) onChanged,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 8,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 14),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Switch.adaptive(
            value: val,
            onChanged: (newVal) {
              onChanged(newVal);
              _showFeedback(
                context,
                "$title ${newVal ? 'enabled' : 'disabled'}",
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountRecoveryCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildRecoveryItem(
            context,
            "Recovery Email Address",
            provider.recoveryEmail,
            AppIcons.mark_email_read_outlined,
            "Edit Email",
            () => _showEditRecoveryDialog(
              context,
              "Update Recovery Email",
              "Enter new recovery email...",
              provider.recoveryEmail,
              (val) => provider.updateAccountRecovery(email: val),
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 16),
          _buildRecoveryItem(
            context,
            "Recovery Mobile Phone",
            provider.recoveryPhone,
            AppIcons.phone_android_rounded,
            "Edit Phone",
            () => _showEditRecoveryDialog(
              context,
              "Update Recovery Phone",
              "Enter new mobile number with country code...",
              provider.recoveryPhone,
              (val) => provider.updateAccountRecovery(phone: val),
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 16),
          _buildRecoveryItem(
            context,
            "Backup Verification Method",
            provider.backupVerificationMethod,
            AppIcons.security_rounded,
            "Change Method",
            () {
              _showFeedback(context, "Backup verification options opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String btnLabel,
    VoidCallback onEdit,
  ) {
    final theme = Theme.of(context);
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 10,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: theme.colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        OutlinedButton(
          onPressed: onEdit,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minimumSize: const Size(0, 36),
          ),
          child: Text(btnLabel),
        ),
      ],
    );
  }

  Widget _buildActiveSessionsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final sessions = provider.activeSessionsList;

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sessions.length,
            separatorBuilder: (ctx, i) => Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            itemBuilder: (context, index) {
              final s = sessions[index];
              IconData icon = AppIcons.laptop_mac_rounded;
              if (s.deviceName.toLowerCase().contains('iphone') ||
                  s.deviceName.toLowerCase().contains('android') ||
                  s.deviceName.toLowerCase().contains('phone')) {
                icon = AppIcons.phone_iphone_rounded;
              } else if (s.deviceName.toLowerCase().contains('ipad') ||
                  s.deviceName.toLowerCase().contains('tablet')) {
                icon = AppIcons.tablet_mac_rounded;
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: s.isCurrentDevice
                                ? theme.colorScheme.primary
                                    .withValues(alpha: 0.15)
                                : theme.colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            icon,
                            color: s.isCurrentDevice
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${s.deviceName} • ${s.platform}",
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (s.isCurrentDevice) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.green
                                            .withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.green
                                                .withValues(alpha: 0.3)),
                                      ),
                                      child: const Text(
                                        "Current Device",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${s.browser}  •  ${s.loginTime}",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                s.location,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (!s.isCurrentDevice)
                      OutlinedButton(
                        onPressed: () {
                          _showConfirmDialog(
                            context,
                            "Terminate Session",
                            "Are you sure you want to sign out ${s.deviceName}?",
                            "Sign Out Device",
                            () {
                              provider.terminateSession(s.id);
                              _showFeedback(context, "Signed out ${s.deviceName}");
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.error,
                          side: BorderSide(color: theme.colorScheme.error),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          minimumSize: const Size(0, 32),
                        ),
                        child: const Text("Sign Out"),
                      )
                    else
                      Text(
                        "Active Now",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          if (sessions.length > 1) ...[
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonalIcon(
                  onPressed: () {
                    _showConfirmDialog(
                      context,
                      "Sign Out Other Devices",
                      "This will immediately sign out all remote workstations and mobile devices except this current session.",
                      "Sign Out All Others",
                      () {
                        provider.terminateOtherSessions();
                        _showFeedback(context,
                            "Signed out all other devices successfully");
                      },
                    );
                  },
                  icon: const Icon(AppIcons.logout_rounded, size: 18),
                  label: const Text("Sign Out Other Devices"),
                  style: FilledButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoginActivityCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final history = provider.loginHistoryList;

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: history.length,
        separatorBuilder: (ctx, i) => Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
        ),
        itemBuilder: (context, index) {
          final item = history[index];
          final isFailed = item.status == "Failed Login";
          final isCurrent = item.status == "Current Session";

          Color badgeColor = theme.colorScheme.onSurfaceVariant;
          if (isFailed) badgeColor = theme.colorScheme.error;
          if (isCurrent) badgeColor = Colors.green;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 10,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isFailed
                          ? AppIcons.warning_rounded
                          : (isCurrent
                              ? AppIcons.verified_user_rounded
                              : AppIcons.history_rounded),
                      color: badgeColor,
                      size: 22,
                    ),
                    const SizedBox(width: 14),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item.deviceName}  •  ${item.browser}",
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${item.os}  •  ${item.location}  •  ${item.loginTime}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: badgeColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrivacyControlsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final controls = [
      _PrivacyItem(
        key: 'profile',
        title: "Profile Visibility",
        description: "Allow prospective talent and clients to view your professional recruiter profile.",
        val: provider.profileVisibility,
      ),
      _PrivacyItem(
        key: 'online',
        title: "Online Status Display",
        description: "Show a green active dot when you are currently signed in to the JobNest portal.",
        val: provider.onlineStatus,
      ),
      _PrivacyItem(
        key: 'activity',
        title: "Recruitment Activity Status",
        description: "Display your recent hiring responsiveness and average feedback turnaround time.",
        val: provider.activityStatus,
      ),
      _PrivacyItem(
        key: 'search',
        title: "Public Search Engine Visibility",
        description: "Allow external search engines (Google, Bing) to index your recruiter profile.",
        val: provider.searchVisibility,
      ),
      _PrivacyItem(
        key: 'recruiter',
        title: "Recruiter Directory Visibility",
        description: "Include your profile in the verified JobNest Enterprise Recruiter Directory.",
        val: provider.recruiterProfileVisibility,
      ),
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controls.length,
        separatorBuilder: (ctx, i) => Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
        ),
        itemBuilder: (context, index) {
          final item = controls[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: item.val,
                  onChanged: (newVal) {
                    provider.togglePrivacyControl(item.key, newVal);
                    _showFeedback(
                      context,
                      "${item.title} ${newVal ? 'enabled' : 'disabled'}",
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginAlertsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final alerts = [
      _PrivacyItem(
        key: 'email',
        title: "Email Login Alerts",
        description: "Send an instant security notification to your inbox for every successful sign-in.",
        val: provider.emailLoginAlerts,
      ),
      _PrivacyItem(
        key: 'device',
        title: "Unrecognized Device Alerts",
        description: "Trigger high-priority alerts when access occurs from a new browser or IP address.",
        val: provider.newDeviceAlerts,
      ),
      _PrivacyItem(
        key: 'suspicious',
        title: "Suspicious Activity Diagnostics",
        description: "Automatically lock session and notify admin if anomalous login patterns are detected.",
        val: provider.suspiciousActivityAlerts,
      ),
      _PrivacyItem(
        key: 'password',
        title: "Credential Modification Alerts",
        description: "Send immediate verification alerts whenever password or 2FA settings are updated.",
        val: provider.passwordChangeAlerts,
      ),
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: alerts.length,
        separatorBuilder: (ctx, i) => Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
        ),
        itemBuilder: (context, index) {
          final item = alerts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: item.val,
                  onChanged: (newVal) {
                    provider.toggleLoginAlert(item.key, newVal);
                    _showFeedback(
                      context,
                      "${item.title} ${newVal ? 'enabled' : 'disabled'}",
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDangerZoneCard(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: errorColor.withValues(alpha: 0.4), width: 1.5),
          color: errorColor.withValues(alpha: 0.05),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(AppIcons.warning_amber_rounded, color: errorColor, size: 24),
                const SizedBox(width: 10),
                Text(
                  "High-Risk Destructive Operations",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: errorColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "These actions permanently affect your enterprise recruiter access, candidate pipelines, and active sessions across the JobNest platform. Please proceed with caution.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Divider(height: 1, color: errorColor.withValues(alpha: 0.2)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 14,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    _showConfirmDialog(
                      context,
                      "Deactivate Account",
                      "Deactivating your account will temporarily hide your job postings and suspend recruiter access until you sign in again.",
                      "Deactivate Account",
                      () {
                        _showFeedback(context,
                            "Account deactivated successfully (Dummy action)");
                      },
                      isDestructive: true,
                    );
                  },
                  icon: Icon(AppIcons.pause_circle_outline_rounded,
                      color: errorColor, size: 18),
                  label: Text("Deactivate Account",
                      style: TextStyle(color: errorColor)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: errorColor),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    _showConfirmDialog(
                      context,
                      "Sign Out All Devices",
                      "Are you sure you want to terminate all active sessions across all devices immediately? You will be returned to the sign-in screen.",
                      "Sign Out Everywhere",
                      () async {
                        await SessionManager.instance.logout();
                        if (!context.mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const AuthFlowScreen()),
                          (route) => false,
                        );
                      },
                      isDestructive: true,
                    );
                  },
                  icon: Icon(AppIcons.logout_rounded, color: errorColor, size: 18),
                  label: Text("Sign Out All Devices",
                      style: TextStyle(color: errorColor)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: errorColor),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    _showConfirmDialog(
                      context,
                      "Permanent Account Deletion",
                      "WARNING: This action cannot be undone. All active requisitions, candidate pipelines, scorecard histories, and company billing records will be permanently purged.",
                      "Delete Account Permanently",
                      () {
                        _showFeedback(context,
                            "Account deletion scheduled (Dummy action)");
                      },
                      isDestructive: true,
                    );
                  },
                  icon: const Icon(AppIcons.delete_forever_rounded, size: 18),
                  label: const Text(
                    "Delete Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: errorColor,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                ),
              ],
            ),
          ],
        ),
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

  void _showConfirmDialog(
    BuildContext context,
    String title,
    String content,
    String confirmLabel,
    VoidCallback onConfirm, {
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
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
            style: isDestructive
                ? FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }

  void _showEditRecoveryDialog(
    BuildContext context,
    String title,
    String hint,
    String initialVal,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: initialVal);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 400,
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (val) {
              if (val.trim().isNotEmpty) {
                onSave(val.trim());
                Navigator.pop(ctx);
                _showFeedback(context, "Recovery contact updated successfully");
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onSave(controller.text.trim());
                Navigator.pop(ctx);
                _showFeedback(context, "Recovery contact updated successfully");
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void _showBackupCodesDialog(BuildContext context) {
    final codes = [
      "8472-9104",
      "3921-5038",
      "1029-4857",
      "5847-2019",
      "6720-3948",
      "9182-7364",
      "4059-1827",
      "2938-4756",
      "7584-9302",
      "1827-3645",
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Emergency Backup Codes"),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Keep these backup codes in a safe place. Each code can only be used once to sign in if you lose access to your 2FA authenticator.",
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                  ),
                  itemCount: codes.length,
                  itemBuilder: (context, i) => Center(
                    child: Text(
                      codes[i],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _showFeedback(context, "Backup codes downloaded (Dummy action)");
            },
            icon: const Icon(AppIcons.download_rounded, size: 16),
            label: const Text("Download Codes"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}

class _CheckupItem {
  final String title;
  final String subtitle;
  final bool isCompleted;

  _CheckupItem({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });
}

class _PrivacyItem {
  final String key;
  final String title;
  final String description;
  final bool val;

  _PrivacyItem({
    required this.key,
    required this.title,
    required this.description,
    required this.val,
  });
}
