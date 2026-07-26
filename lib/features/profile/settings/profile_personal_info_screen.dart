import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/profile/providers/profile_data_provider.dart';

class ProfilePersonalInfoScreen extends StatefulWidget {
  const ProfilePersonalInfoScreen({super.key});

  @override
  State<ProfilePersonalInfoScreen> createState() => _ProfilePersonalInfoScreenState();
}

class _ProfilePersonalInfoScreenState extends State<ProfilePersonalInfoScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _designationCtrl;
  late TextEditingController _locationCtrl;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    _nameCtrl = TextEditingController(text: provider.fullName);
    _emailCtrl = TextEditingController(text: provider.email);
    _phoneCtrl = TextEditingController(text: provider.phone);
    _designationCtrl = TextEditingController(text: provider.designation);
    _locationCtrl = TextEditingController(text: provider.location);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _designationCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ProfileDataProvider>();

    // ===== BACKEND TODO =====
    // TODO: Fetch recruiter profile.
    // TODO: Update profile API.
    // TODO: Upload profile photo.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Personal Information"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: AppCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Recruiter Profile",
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Keep your contact details up to date for candidate correspondence.",
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(context, "Full Name", _nameCtrl, "e.g., Sonu Surya"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Email Address", _emailCtrl, "e.g., sonusurya@technova.com"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Phone Number", _phoneCtrl, "e.g., +91 98765 43210"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Designation / Role", _designationCtrl, "e.g., Senior Tech Recruiter"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Work Location", _locationCtrl, "e.g., Bangalore, India"),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: () {
                        provider.updatePersonalInfo(
                          name: _nameCtrl.text.trim(),
                          newEmail: _emailCtrl.text.trim(),
                          newPhone: _phoneCtrl.text.trim(),
                          newDesignation: _designationCtrl.text.trim(),
                          newLocation: _locationCtrl.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Personal profile updated successfully! (Local State)"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.save_rounded),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      label: const Text("Save Changes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
