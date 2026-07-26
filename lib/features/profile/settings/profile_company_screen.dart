import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/profile/providers/profile_data_provider.dart';

class ProfileCompanyScreen extends StatefulWidget {
  const ProfileCompanyScreen({super.key});

  @override
  State<ProfileCompanyScreen> createState() => _ProfileCompanyScreenState();
}

class _ProfileCompanyScreenState extends State<ProfileCompanyScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _industryCtrl;
  late TextEditingController _sizeCtrl;
  late TextEditingController _websiteCtrl;
  late TextEditingController _hqCtrl;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    _nameCtrl = TextEditingController(text: provider.companyName);
    _industryCtrl = TextEditingController(text: provider.industry);
    _sizeCtrl = TextEditingController(text: provider.companySize);
    _websiteCtrl = TextEditingController(text: provider.website);
    _hqCtrl = TextEditingController(text: provider.headquarters);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _industryCtrl.dispose();
    _sizeCtrl.dispose();
    _websiteCtrl.dispose();
    _hqCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ProfileDataProvider>();

    // ===== BACKEND TODO =====
    // TODO: Company profile sync.
    // TODO: Fetch recruiter profile.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Company & Organization Profile"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: AppCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Organization Details",
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Manage your enterprise branding and corporate headquarters information.",
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(context, "Company Name", _nameCtrl, "e.g., TechNova Solutions"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Industry Domain", _industryCtrl, "e.g., Software & Technology"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Company Size (Employees)", _sizeCtrl, "e.g., 500 - 1000 Employees"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Corporate Website", _websiteCtrl, "e.g., https://technova.dev"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Headquarters Location", _hqCtrl, "e.g., Koramangala, Bangalore"),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: () {
                        provider.updateCompanyInfo(
                          name: _nameCtrl.text.trim(),
                          newIndustry: _industryCtrl.text.trim(),
                          size: _sizeCtrl.text.trim(),
                          web: _websiteCtrl.text.trim(),
                          hq: _hqCtrl.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Company profile updated successfully! (Local State)"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.business_rounded),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      label: const Text("Save Organization Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
