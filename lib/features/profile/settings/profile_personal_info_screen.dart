import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/profile/providers/profile_data_provider.dart';

import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';

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
    return AppPageScaffold(
      title: "Personal Information",
      showBackButton: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AppCard(
          padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Recruiter Profile",
                    style: AppText.h2,
                  ),
                  AppSpacing.h8,
                  Text(
                    "Keep your contact details up to date for candidate correspondence.",
                    style: AppText.bodyMedium,
                  ),
                  AppSpacing.h24,
                  AppTextField(
                    label: "Full Name",
                    hint: "e.g., Sonu Surya",
                    controller: _nameCtrl,
                  ),
                  AppSpacing.h16,
                  AppTextField(
                    label: "Email Address",
                    hint: "e.g., sonusurya@technova.com",
                    controller: _emailCtrl,
                  ),
                  AppSpacing.h16,
                  AppTextField(
                    label: "Phone Number",
                    hint: "e.g., +91 98765 43210",
                    controller: _phoneCtrl,
                  ),
                  AppSpacing.h16,
                  AppTextField(
                    label: "Designation / Role",
                    hint: "e.g., Senior Tech Recruiter",
                    controller: _designationCtrl,
                  ),
                  AppSpacing.h16,
                  AppTextField(
                    label: "Work Location",
                    hint: "e.g., Bangalore, India",
                    controller: _locationCtrl,
                  ),
                  AppSpacing.h32,
                  AppButton(
                    text: "Save Changes",
                    icon: AppIcons.save_rounded,
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
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
