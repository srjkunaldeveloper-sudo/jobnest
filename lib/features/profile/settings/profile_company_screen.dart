import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/profile/providers/profile_data_provider.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';

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
  late TextEditingController _yearCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _cityCtrl;
  late TextEditingController _stateCtrl;
  late TextEditingController _countryCtrl;
  late TextEditingController _panCtrl;
  late TextEditingController _tanCtrl;

  // Company Branding Controllers
  late TextEditingController _overviewCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _missionCtrl;
  late TextEditingController _visionCtrl;
  late TextEditingController _cultureCtrl;
  late TextEditingController _valuesCtrl;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    _nameCtrl = TextEditingController(text: provider.companyName);
    _industryCtrl = TextEditingController(text: provider.industry);
    _sizeCtrl = TextEditingController(text: provider.companySize);
    _websiteCtrl = TextEditingController(text: provider.website);
    _hqCtrl = TextEditingController(text: provider.headquarters);
    _yearCtrl = TextEditingController(text: provider.foundedYear);
    _phoneCtrl = TextEditingController(text: provider.officialPhone);
    _addressCtrl = TextEditingController(text: provider.officeAddress);
    _cityCtrl = TextEditingController(text: provider.city);
    _stateCtrl = TextEditingController(text: provider.state);
    _countryCtrl = TextEditingController(text: provider.country);
    _panCtrl = TextEditingController(text: provider.companyPan);
    _tanCtrl = TextEditingController(text: provider.companyTan);

    _overviewCtrl = TextEditingController(text: provider.companyOverview);
    _descriptionCtrl = TextEditingController(text: provider.companyDescription);
    _missionCtrl = TextEditingController(text: provider.missionStatement);
    _visionCtrl = TextEditingController(text: provider.visionStatement);
    _cultureCtrl = TextEditingController(text: provider.workCulture);
    _valuesCtrl = TextEditingController(text: provider.companyValues);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _industryCtrl.dispose();
    _sizeCtrl.dispose();
    _websiteCtrl.dispose();
    _hqCtrl.dispose();
    _yearCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _countryCtrl.dispose();
    _panCtrl.dispose();
    _tanCtrl.dispose();

    _overviewCtrl.dispose();
    _descriptionCtrl.dispose();
    _missionCtrl.dispose();
    _visionCtrl.dispose();
    _cultureCtrl.dispose();
    _valuesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ProfileDataProvider>();

    // ===== BACKEND TODO =====
    // TODO:
    // Fetch company profile.

    // TODO:
    // Update company profile.

    // TODO:
    // Company verification.

    // TODO:
    // Upload company images.

    // TODO:
    // Upload company logo.

    // TODO:
    // Upload office gallery.

    // TODO:
    // Company branding API.

    // TODO:
    // Company media storage integration.
    return AppPageScaffold(
      title: "Company & Organization Profile",
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: AppSpacing.edgeInsetsAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                // CARD 1: ORGANIZATION DETAILS
              AppCard(
                padding: AppSpacing.edgeInsetsAll24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Organization Details",
                      style: AppText.h3,
                    ),
                    AppSpacing.h8,
                    Text(
                      "Manage your enterprise branding and corporate headquarters information.",
                      style: AppText.bodyMedium,
                    ),
                      AppSpacing.h24,
                      _buildSectionTitle(context, "Basic Information", AppIcons.business_outlined),
                      _buildTextField(context, "Company Name", _nameCtrl, "e.g., TechNova Solutions"),
                      AppSpacing.h16,
                      _buildTextField(context, "Industry Domain", _industryCtrl, "e.g., Software & Technology"),
                      AppSpacing.h16,
                      _buildTextField(context, "Company Size", _sizeCtrl, "e.g., 500 - 1000 Employees"),
                      AppSpacing.h16,
                      _buildTextField(context, "Founded Year", _yearCtrl, "e.g., 2015", keyboardType: TextInputType.number),
                      AppSpacing.h16,
                      _buildTextField(context, "Company Website", _websiteCtrl, "e.g., https://technova.dev", keyboardType: TextInputType.url),
                      AppSpacing.h16,
                      _buildTextField(context, "Official Phone Number", _phoneCtrl, "e.g., +91 80 4123 4567", keyboardType: TextInputType.phone),
                      AppSpacing.h24,
                      const Divider(),
                      AppSpacing.h16,
                      _buildSectionTitle(context, "Location Details", AppIcons.location_on_outlined),
                      _buildTextField(context, "Headquarters Location", _hqCtrl, "e.g., Koramangala, Bangalore"),
                      AppSpacing.h16,
                      _buildTextField(context, "Office Address", _addressCtrl, "e.g., Plot 42, Cyber Park, Electronic City Phase 1"),
                      AppSpacing.h16,
                      _buildTextField(context, "City", _cityCtrl, "e.g., Bangalore"),
                      AppSpacing.h16,
                      _buildTextField(context, "State", _stateCtrl, "e.g., Karnataka"),
                      AppSpacing.h16,
                      _buildTextField(context, "Country", _countryCtrl, "e.g., India"),
                      AppSpacing.h24,
                      const Divider(),
                      AppSpacing.h16,
                      _buildSectionTitle(context, "Optional Identifiers", AppIcons.badge_outlined),
                      _buildTextField(context, "Company PAN (Optional)", _panCtrl, "e.g., AAACT1234K", textCapitalization: TextCapitalization.characters),
                      AppSpacing.h16,
                      _buildTextField(context, "Company TAN (Optional)", _tanCtrl, "e.g., BLRT12345F", textCapitalization: TextCapitalization.characters),
                    ],
                  ),
                ),

                AppSpacing.h24,

                // CARD 2: COMPANY BRANDING & STORY
                AppCard(
                  padding: AppSpacing.edgeInsetsAll24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Company Branding & Story",
                        style: AppText.h3,
                      ),
                      AppSpacing.h8,
                      Text(
                        "Present your company overview, mission, vision, and work culture professionally to candidates.",
                        style: AppText.bodyMedium,
                      ),
                      AppSpacing.h24,
                      _buildSectionTitle(context, "About Company", AppIcons.info_outline),
                      _buildTextField(context, "Company Overview", _overviewCtrl, "e.g., Global leader in HR technology..."),
                      AppSpacing.h16,
                      _buildTextField(context, "Company Description", _descriptionCtrl, "e.g., Founded in 2015, we empower Fortune 500 companies...", maxLines: 3),
                      AppSpacing.h24,
                      const Divider(),
                      AppSpacing.h16,
                      _buildSectionTitle(context, "Mission & Vision", AppIcons.track_changes_outlined),
                      _buildTextField(context, "Mission Statement", _missionCtrl, "e.g., To revolutionize global recruitment...", maxLines: 2),
                      AppSpacing.h16,
                      _buildTextField(context, "Vision Statement", _visionCtrl, "e.g., To become the world's most trusted recruitment operating system...", maxLines: 2),
                      AppSpacing.h24,
                      const Divider(),
                      AppSpacing.h16,
                      _buildSectionTitle(context, "Work Culture & Values", AppIcons.groups_outlined),
                      _buildTextField(context, "Work Culture Description", _cultureCtrl, "e.g., We thrive in a collaborative, remote-first environment...", maxLines: 3),
                      AppSpacing.h16,
                      _buildTextField(context, "Company Values", _valuesCtrl, "e.g., 1. Customer Obsession\n2. Radical Transparency...", maxLines: 4),
                    ],
                  ),
                ),

                AppSpacing.h24,

                // CARD 3: COMPANY MEDIA GALLERY
                AppCard(
                  padding: AppSpacing.edgeInsetsAll24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company Media Gallery",
                                  style: AppText.h3,
                                ),
                                AppSpacing.h4,
                                Text(
                                  "Showcase office tours, logos, and recruitment banners.",
                                  style: AppText.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          AppSpacing.w12,
                          Wrap(
                            spacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.toggleCompanyMediaEmpty();
                                },
                                icon: Icon(
                                  provider.isCompanyMediaEmpty ? AppIcons.visibility_off_outlined : AppIcons.visibility_outlined,
                                  color: theme.colorScheme.primary,
                                ),
                                tooltip: "Toggle Empty State Simulation",
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Add Media action triggered! (Dummy frontend action)"),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: const Icon(AppIcons.add_photo_alternate_outlined, size: 18),
                                label: const Text("Add Media", style: TextStyle(fontWeight: FontWeight.bold)),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppSpacing.h20,
                      if (provider.isCompanyMediaEmpty || provider.isEmpty)
                        _buildMediaEmptyState(context)
                      else
                        Column(
                          children: [
                            _buildMediaCard(context, "Company Logo", "High-Res Vector Brand Asset", AppIcons.business_rounded, "Primary Logo"),
                            const SizedBox(height: 12),
                            _buildMediaCard(context, "Recruitment Banner", "Cover Image for Candidate Portal", AppIcons.image_outlined, "Cover Image"),
                            const SizedBox(height: 12),
                            _buildMediaCard(context, "Office Images", "Bangalore HQ & Collaborative Spaces", AppIcons.photo_library_outlined, "12 Photos"),
                            const SizedBox(height: 12),
                            _buildMediaCard(context, "Office Tour", "Inside TechNova Work Culture Video", AppIcons.videocam_outlined, "Video Tour"),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: () {
                      if (_yearCtrl.text.trim().isNotEmpty) {
                        final yearVal = int.tryParse(_yearCtrl.text.trim());
                        if (yearVal == null || yearVal < 1800 || yearVal > DateTime.now().year + 5) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Please enter a valid Founded Year (e.g., 2015)."),
                              backgroundColor: theme.colorScheme.error,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                      }
                      if (_phoneCtrl.text.trim().isNotEmpty) {
                        final phoneStr = _phoneCtrl.text.trim();
                        if (phoneStr.length < 7 || !RegExp(r'[0-9]').hasMatch(phoneStr)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Please enter a valid Official Phone Number."),
                              backgroundColor: theme.colorScheme.error,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                      }
                      if (_websiteCtrl.text.trim().isNotEmpty) {
                        final webStr = _websiteCtrl.text.trim();
                        if (!webStr.contains('.')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Please enter a valid Company Website URL (e.g., https://technova.dev)."),
                              backgroundColor: theme.colorScheme.error,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                      }

                      provider.updateCompanyInfo(
                        name: _nameCtrl.text.trim(),
                        newIndustry: _industryCtrl.text.trim(),
                        size: _sizeCtrl.text.trim(),
                        web: _websiteCtrl.text.trim(),
                        hq: _hqCtrl.text.trim(),
                        year: _yearCtrl.text.trim(),
                        phone: _phoneCtrl.text.trim(),
                        address: _addressCtrl.text.trim(),
                        cityVal: _cityCtrl.text.trim(),
                        stateVal: _stateCtrl.text.trim(),
                        countryVal: _countryCtrl.text.trim(),
                        pan: _panCtrl.text.trim(),
                        tan: _tanCtrl.text.trim(),
                      );
                      provider.updateCompanyBranding(
                        overview: _overviewCtrl.text.trim(),
                        description: _descriptionCtrl.text.trim(),
                        mission: _missionCtrl.text.trim(),
                        vision: _visionCtrl.text.trim(),
                        culture: _cultureCtrl.text.trim(),
                        values: _valuesCtrl.text.trim(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Company profile & branding updated successfully! (Local State)"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(AppIcons.check_circle_outline_rounded),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    label: const Text("Save All Company & Branding Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                AppSpacing.h32,
              ],
            ),
          ),
    );
  }

  Widget _buildMediaCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    String badge,
  ) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 26),
          ),
          AppSpacing.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      title,
                      style: AppText.h3.copyWith(fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge,
                        style: AppText.labelSmall.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.h4,
                Text(
                  subtitle,
                  style: AppText.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          AppSpacing.w8,
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Edit placeholder asset for $title (Dummy action)"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(AppIcons.edit_outlined, size: 20),
            tooltip: "Edit Asset",
          ),
        ],
      ),
    );
  }

  Widget _buildMediaEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(AppIcons.photo_library_outlined, size: 52, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(
            "No company media available.",
            style: AppText.h3.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          AppSpacing.h8,
          Text(
            "Upload your company logo, recruitment banners, office photos, and video tours to showcase your work culture.",
            textAlign: TextAlign.center,
            style: AppText.bodyMedium,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Add Media action triggered! (Dummy frontend action)"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(AppIcons.add_photo_alternate_rounded),
            label: const Text("Add Media", style: TextStyle(fontWeight: FontWeight.bold)),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Text(
            title,
            style: AppText.h3.copyWith(fontSize: 16, color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int maxLines = 1,
  }) {
    return AppTextField(
      label: label,
      controller: controller,
      hint: hint,
      keyboardType: keyboardType ?? TextInputType.text,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
    );
  }
}
