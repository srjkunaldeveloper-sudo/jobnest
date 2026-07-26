import 'package:flutter/material.dart';
import 'package:jobnest/core/services/session_manager.dart';
import 'package:jobnest/main.dart'; // Dashboard par jane ke liye
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class AdvancedSetupScreen extends StatefulWidget {
  const AdvancedSetupScreen({super.key});

  @override
  State<AdvancedSetupScreen> createState() => _AdvancedSetupScreenState();
}

class _AdvancedSetupScreenState extends State<AdvancedSetupScreen> {
  // Dropdown ke liye default role
  String selectedRole = 'Recruiter';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Advanced Setup", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () async {
              // "Skip" dabane par seedha Dashboard
              await SessionManager.instance.setLoginState(true);
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainDashboard()), (route) => false);
            },
            child: Text("Skip", style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. ADD TEAM MEMBERS SECTION ---
              Text("Add Team Members", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Invite recruiters via email and assign roles.", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildTextField("Email address", Icons.email_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: _buildRoleDropdown(theme),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Action to send invite
                  },
                  icon: Icon(Icons.send, size: 18, color: theme.colorScheme.primary),
                  label: Text("Send Invite", style: TextStyle(color: theme.colorScheme.primary)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),

              const SizedBox(height: 40),
              Divider(color: theme.dividerColor),
              const SizedBox(height: 40),

              // --- 2. COMPANY BRANDING SECTION ---
              Text("Upload Company Branding", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Personalize your company profile.", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 24),

              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    border: Border.all(color: theme.dividerColor, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined, color: theme.colorScheme.onSurfaceVariant, size: 32),
                      const SizedBox(height: 8),
                      Text("Upload Logo", style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              TextField(
                maxLines: 4,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: "Company Description",
                  hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --- FINISH BUTTON ---
              AppButton(
                text: "Finish Setup",
                onPressed: () async {
                  // Setup complete, go to Dashboard
                  await SessionManager.instance.setLoginState(true);
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainDashboard()),
                          (route) => false
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField wrapper
  Widget _buildTextField(String hint, IconData icon) {
    return AppTextField(
      hint: hint,
      icon: icon,
    );
  }

  // Reusable Role Dropdown (Admin, Recruiter, Viewer)
  Widget _buildRoleDropdown(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          isExpanded: true,
          dropdownColor: theme.colorScheme.surfaceContainerHighest,
          icon: Icon(Icons.keyboard_arrow_down, color: theme.colorScheme.onSurface),
          items: ['Admin', 'Recruiter', 'Viewer'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface)),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedRole = newValue!;
            });
          },
        ),
      ),
    );
  }
}
