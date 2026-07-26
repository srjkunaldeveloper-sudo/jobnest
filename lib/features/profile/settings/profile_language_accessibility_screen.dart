import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';

class ProfileLanguageAccessibilityScreen extends StatelessWidget {
  const ProfileLanguageAccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Fetch localization preferences.

    // TODO:
    // Save accessibility settings.

    // TODO:
    // Dynamic localization.

    // TODO:
    // RTL language support.

    // TODO:
    // Accessibility preference sync.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Language & Accessibility"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => _showResetConfirmDialog(context, provider),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: "Restore Default Accessibility Settings",
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
                // Section 1: LIVE PREVIEW SECTION
                _buildSectionHeader(
                  theme,
                  "Live Accessibility Preview",
                  "Real-time preview demonstrating text size, contrast, button style, and card layout.",
                  Icons.preview_rounded,
                ),
                const SizedBox(height: 14),
                _buildLivePreviewCard(context, provider),
                const SizedBox(height: 32),

                // Section 2: LANGUAGE SETTINGS
                _buildSectionHeader(
                  theme,
                  "Language & Localization",
                  "Select your preferred interface language. Prepared for enterprise multi-lingual localization.",
                  Icons.translate_rounded,
                ),
                const SizedBox(height: 14),
                _buildLanguageSection(context, provider),
                const SizedBox(height: 32),

                // Section 3: REGIONAL SETTINGS
                _buildSectionHeader(
                  theme,
                  "Regional Formatting Standards",
                  "Configure country conventions, date formatting, time notation, and number decimals.",
                  Icons.public_rounded,
                ),
                const SizedBox(height: 14),
                _buildRegionalSection(context, provider),
                const SizedBox(height: 32),

                // Section 4: TIMEZONE
                _buildSectionHeader(
                  theme,
                  "Workspace Timezone",
                  "Set the active time zone for scheduling candidate interviews and automated alerts.",
                  Icons.schedule_rounded,
                ),
                const SizedBox(height: 14),
                _buildTimezoneSection(context, provider),
                const SizedBox(height: 32),

                // Section 5: TEXT SIZE & SCALING
                _buildSectionHeader(
                  theme,
                  "Text Size & Font Scaling",
                  "Adjust interface typography scaling from compact 0.85x to extra large 1.30x.",
                  Icons.format_size_rounded,
                ),
                const SizedBox(height: 14),
                _buildTextSizeSection(context, provider),
                const SizedBox(height: 32),

                // Section 6: DISPLAY OPTIONS
                _buildSectionHeader(
                  theme,
                  "Workspace Display Options",
                  "Fine-tune layout density, high contrast modes, button sizing, and interface tooltips.",
                  Icons.desktop_windows_outlined,
                ),
                const SizedBox(height: 14),
                _buildDisplayOptionsSection(context, provider),
                const SizedBox(height: 32),

                // Section 7: ACCESSIBILITY FEATURES
                _buildSectionHeader(
                  theme,
                  "Assistive & Accessibility Features",
                  "Configure screen reader compatibility, keyboard navigation, and focus highlights.",
                  Icons.accessibility_new_rounded,
                ),
                const SizedBox(height: 14),
                _buildAccessibilityFeaturesSection(context, provider),
                const SizedBox(height: 32),

                // Section 8: COLOR ACCESSIBILITY
                _buildSectionHeader(
                  theme,
                  "Color Accessibility & Palettes",
                  "Select specialized color modes tailored for color vision deficiencies and high contrast.",
                  Icons.color_lens_outlined,
                ),
                const SizedBox(height: 14),
                _buildColorAccessibilitySection(context, provider),
                const SizedBox(height: 32),

                // Section 9: ANIMATION SETTINGS
                _buildSectionHeader(
                  theme,
                  "Motion & Animation Settings",
                  "Control UI transition speeds or reduce motion for vestibular comfort.",
                  Icons.animation_rounded,
                ),
                const SizedBox(height: 14),
                _buildAnimationSettingsSection(context, provider),
                const SizedBox(height: 32),

                // Section 10: READABILITY
                _buildSectionHeader(
                  theme,
                  "Readability & Typography Tuning",
                  "Customize line spacing, font weight, card spacing density, and icon dimensions.",
                  Icons.subject_rounded,
                ),
                const SizedBox(height: 14),
                _buildReadabilitySection(context, provider),
                const SizedBox(height: 40),

                // Section 11: RESET BUTTON
                _buildResetButtonSection(context, provider),
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

  Widget _buildLivePreviewCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    // Apply live scale & contrast rules
    final scale = provider.textSizeScale;
    final isHighContrast = provider.displayHighContrast ||
        provider.colorAccessibilityMode == "High Contrast";
    final isLargeButtons = provider.displayLargeButtons;
    final isCompact = provider.displayCompactLayout ||
        provider.readabilityCardDensity == "Compact" ||
        provider.readabilityCardDensity == "Ultra-Compact";

    double lineHeight = 1.4;
    if (provider.readabilityLineSpacing == "1.2x Compact") lineHeight = 1.2;
    if (provider.readabilityLineSpacing == "1.8x Relaxed") lineHeight = 1.8;
    if (provider.readabilityLineSpacing == "2.0x Double") lineHeight = 2.0;

    FontWeight fontWeight = FontWeight.normal;
    if (provider.readabilityFontWeight == "Medium (500)") {
      fontWeight = FontWeight.w500;
    }
    if (provider.readabilityFontWeight == "Semi-Bold (600)") {
      fontWeight = FontWeight.w600;
    }
    if (provider.readabilityFontWeight == "Bold (700)") {
      fontWeight = FontWeight.w700;
    }

    double iconSize = 22 * scale;
    if (provider.readabilityIconSize == "Small (18px)") iconSize = 18 * scale;
    if (provider.readabilityIconSize == "Large (32px)") iconSize = 32 * scale;

    Color cardBg = theme.colorScheme.surfaceContainerLow;
    Color borderColor = theme.colorScheme.outline.withValues(alpha: 0.15);
    Color primaryAccent = theme.colorScheme.primary;

    if (isHighContrast) {
      cardBg = theme.colorScheme.surfaceContainerHighest;
      borderColor = theme.colorScheme.primary;
      primaryAccent = Colors.blueAccent.shade700;
    } else if (provider.colorAccessibilityMode == "Color Blind Friendly") {
      primaryAccent = Colors.teal.shade700;
    } else if (provider.colorAccessibilityMode == "Dark Optimized") {
      cardBg = const Color(0xFF1E2229);
      borderColor = const Color(0xFF3B4252);
      primaryAccent = const Color(0xFF88C0D0);
    }

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: isHighContrast ? 2.5 : 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isCompact ? 14 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryAccent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.preview_rounded,
                        color: primaryAccent, size: iconSize),
                  ),
                  Text(
                    "LIVE PREVIEW",
                    style: TextStyle(
                      fontSize: 11 * scale,
                      fontWeight: FontWeight.bold,
                      color: primaryAccent,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: isHighContrast
                      ? Border.all(color: Colors.green, width: 1.5)
                      : null,
                ),
                child: Text(
                  "Match: 94%",
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 12 * scale,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isCompact ? 10 : 16),
          Text(
            "Senior AI Recruiting Specialist",
            style: TextStyle(
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
              color: isHighContrast ? Colors.white : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Requisition #8921 • Engineering Department • Full-Time Remote",
            style: TextStyle(
              fontSize: 13 * scale,
              fontWeight: fontWeight,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: isCompact ? 10 : 14),
          Text(
            "Candidate resume evaluation in progress. AI neural screening matched 5/5 mandatory skills: Deep Learning, Python, Flutter, Enterprise ATS Architecture, and Candidate Pipeline Management.",
            style: TextStyle(
              fontSize: 14 * scale,
              height: lineHeight,
              fontWeight: fontWeight,
            ),
          ),
          SizedBox(height: isCompact ? 14 : 20),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              FilledButton.icon(
                onPressed: () {
                  _showFeedback(context, "Live Preview CTA: Scorecard Reviewed!");
                },
                icon: Icon(Icons.assessment_rounded,
                    size: isLargeButtons ? 22 : 18),
                label: Text(
                  "Review Scorecard",
                  style: TextStyle(
                      fontSize: (isLargeButtons ? 15 : 13) * scale,
                      fontWeight: FontWeight.bold),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: primaryAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeButtons ? 24 : 16,
                    vertical: isLargeButtons ? 16 : 12,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _showFeedback(context, "Live Preview CTA: Interview Scheduled!");
                },
                icon: Icon(Icons.calendar_today_rounded,
                    size: isLargeButtons ? 22 : 18),
                label: Text(
                  "Schedule Interview",
                  style: TextStyle(
                      fontSize: (isLargeButtons ? 15 : 13) * scale,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  side: isHighContrast
                      ? BorderSide(color: primaryAccent, width: 2)
                      : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeButtons ? 24 : 16,
                    vertical: isLargeButtons ? 16 : 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final languages = [
      {"name": "English (US)", "native": "English (United States)"},
      {"name": "English (UK)", "native": "English (United Kingdom)"},
      {"name": "Hindi (India)", "native": "हिन्दी (India)"},
      {"name": "Spanish (Spain)", "native": "Español (España)"},
      {"name": "French (France)", "native": "Français (France)"},
      {"name": "German (Germany)", "native": "Deutsch (Deutschland)"},
      {"name": "Arabic (MENA)", "native": "العربية (RTL Ready)"},
    ];

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.language_rounded, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Current Interface Language: ${provider.currentLanguage}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Select a language below. Note: This updates frontend placeholder preferences and prepares the module for future translation APIs.",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: languages.map((lang) {
              final isSel = provider.currentLanguage == lang["name"]!;
              return ChoiceChip(
                avatar: isSel
                    ? const Icon(Icons.check_circle_rounded, size: 18)
                    : const Icon(Icons.translate_rounded, size: 16),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang["name"]!,
                          style: TextStyle(
                              fontWeight: isSel ? FontWeight.bold : FontWeight.w600,
                              fontSize: 13)),
                      Text(lang["native"]!,
                          style: TextStyle(
                              fontSize: 11,
                              color: isSel
                                  ? Theme.of(context).colorScheme.onPrimaryContainer
                                  : Theme.of(context).colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                selected: isSel,
                onSelected: (sel) {
                  if (sel) {
                    provider.updateLanguageAccessibility(language: lang["name"]);
                    _showFeedback(context,
                        "Language set to ${lang["name"]} (Frontend placeholder)");
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalSection(
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
            icon: Icons.flag_rounded,
            title: "Country / Regional Standard",
            value: provider.regionalCountry,
            options: [
              "India",
              "United States",
              "United Kingdom",
              "Germany",
              "United Arab Emirates",
              "Canada",
              "Australia",
              "Singapore",
            ],
            onSelect: (val) {
              provider.updateLanguageAccessibility(country: val);
              _showFeedback(context, "Country standard set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.calendar_month_rounded,
            title: "Date Format Notation",
            value: provider.regionalDateFormat,
            options: [
              "DD/MM/YYYY (26/07/2026)",
              "MM/DD/YYYY (07/26/2026)",
              "YYYY-MM-DD (2026-07-26)",
              "DD MMM YYYY (26 Jul 2026)",
            ],
            onSelect: (val) {
              provider.updateLanguageAccessibility(dateFormat: val);
              _showFeedback(context, "Date format set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.access_time_rounded,
            title: "Time Notation Format",
            value: provider.regionalTimeFormat,
            options: [
              "24-Hour (14:30 IST)",
              "12-Hour (02:30 PM IST)",
              "UTC Standard (09:00 UTC)",
            ],
            onSelect: (val) {
              provider.updateLanguageAccessibility(timeFormat: val);
              _showFeedback(context, "Time format set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.numbers_rounded,
            title: "Number & Decimal Notation",
            value: provider.regionalNumberFormat,
            options: [
              "12,34,567.89 (Indian Lakhs/Crores)",
              "1,234,567.89 (Standard / US)",
              "1.234.567,89 (European / ISO)",
              "1 234 567.89 (SI Space)",
            ],
            onSelect: (val) {
              provider.updateLanguageAccessibility(numberFormat: val);
              _showFeedback(context, "Number format set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.date_range_rounded,
            title: "First Day of Week",
            value: provider.regionalFirstDayOfWeek,
            options: ["Monday", "Sunday", "Saturday"],
            onSelect: (val) {
              provider.updateLanguageAccessibility(firstDayOfWeek: val);
              _showFeedback(context, "First day of week set to $val");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimezoneSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: _buildSelectorTile(
        context,
        icon: Icons.public_rounded,
        title: "Active Timezone",
        value: provider.regionalTimezone,
        options: [
          "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi",
          "(UTC+00:00) London, Dublin, Lisbon, UTC Standard",
          "(UTC-05:00) Eastern Time (US & Canada), New York",
          "(UTC-08:00) Pacific Time (US & Canada), San Francisco",
          "(UTC+01:00) Central European Time, Frankfurt, Paris",
          "(UTC+04:00) Gulf Standard Time, Dubai, Abu Dhabi",
          "(UTC+08:00) Singapore, Beijing, Hong Kong, Perth",
        ],
        onSelect: (val) {
          provider.updateLanguageAccessibility(timezone: val);
          _showFeedback(context, "Workspace timezone updated!");
        },
      ),
    );
  }

  Widget _buildTextSizeSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Interface Text Scaling:",
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  provider.textSizeLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text("A", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Expanded(
                child: Slider(
                  value: provider.textSizeScale,
                  min: 0.85,
                  max: 1.30,
                  divisions: 3,
                  label: provider.textSizeLabel,
                  onChanged: (val) {
                    String lbl = "Medium (Standard)";
                    if (val <= 0.86) {
                      lbl = "Small (0.85x)";
                    } else if (val >= 1.29) {
                      lbl = "Extra Large (1.30x)";
                    } else if (val >= 1.14) {
                      lbl = "Large (1.15x)";
                    }
                    provider.updateLanguageAccessibility(
                        textSize: val, textSizeLbl: lbl);
                  },
                ),
              ),
              const Text("A", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SAMPLE TEXT PREVIEW:",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Candidate resume evaluation in progress. AI neural matching score: 94%. Required skills: Deep Learning, Python, Flutter, and Enterprise ATS Architecture.",
                  style: TextStyle(
                    fontSize: 14 * provider.textSizeScale,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayOptionsSection(
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
            icon: Icons.contrast_rounded,
            title: "High Contrast Mode",
            subtitle: "Increase visual border separation and color contrast",
            value: provider.displayHighContrast,
            onChanged: (val) {
              provider.toggleDisplayOption('contrast', val);
              _showFeedback(context,
                  val ? "High contrast mode enabled" : "High contrast disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.speed_rounded,
            title: "Reduce Motion",
            subtitle: "Minimize screen transitions and parallax animations",
            value: provider.displayReduceMotion,
            onChanged: (val) {
              provider.toggleDisplayOption('motion', val);
              _showFeedback(context,
                  val ? "Reduce motion enabled" : "Standard motion restored");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.touch_app_rounded,
            title: "Large Buttons & Targets",
            subtitle: "Increase clickable touch area and button height for ease of use",
            value: provider.displayLargeButtons,
            onChanged: (val) {
              provider.toggleDisplayOption('buttons', val);
              _showFeedback(context,
                  val ? "Large button targets enabled" : "Standard button targets restored");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.view_compact_rounded,
            title: "Compact Layout Density",
            subtitle: "Condense card padding to fit more candidates and jobs on screen",
            value: provider.displayCompactLayout,
            onChanged: (val) {
              provider.toggleDisplayOption('compact', val);
              _showFeedback(context,
                  val ? "Compact layout density enabled" : "Standard layout restored");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.info_outline_rounded,
            title: "Show Helpful Tooltips",
            subtitle: "Display hover descriptions and onboarding explanations on icons",
            value: provider.displayShowTooltips,
            onChanged: (val) {
              provider.toggleDisplayOption('tooltips', val);
              _showFeedback(context,
                  val ? "Tooltips enabled" : "Tooltips hidden");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccessibilityFeaturesSection(
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
            icon: Icons.record_voice_over_rounded,
            title: "Screen Reader Support (TalkBack / VoiceOver)",
            subtitle: "Optimize semantic tree annotations for visually impaired recruiters",
            value: provider.accessScreenReader,
            onChanged: (val) {
              provider.toggleAccessibilityFeature('reader', val);
              _showFeedback(context,
                  val ? "Screen reader compatibility active" : "Screen reader support disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.label_important_outline_rounded,
            title: "Accessible Semantic Labels",
            subtitle: "Attach descriptive text labels to all interactive icons and status badges",
            value: provider.accessAccessibleLabels,
            onChanged: (val) {
              provider.toggleAccessibilityFeature('labels', val);
              _showFeedback(context,
                  val ? "Accessible labels enabled" : "Accessible labels disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.keyboard_alt_outlined,
            title: "Keyboard Navigation Ready",
            subtitle: "Enable shortcut keys (Tab, Enter, Arrows) for fast desktop pipeline review",
            value: provider.accessKeyboardNav,
            onChanged: (val) {
              provider.toggleAccessibilityFeature('keyboard', val);
              _showFeedback(context,
                  val ? "Keyboard navigation active" : "Keyboard navigation disabled");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.center_focus_strong_rounded,
            title: "Enhanced Focus Indicators",
            subtitle: "Highlight active input fields and buttons with vivid outline borders",
            value: provider.accessFocusIndicators,
            onChanged: (val) {
              provider.toggleAccessibilityFeature('focus', val);
              _showFeedback(context,
                  val ? "Focus indicators highlighted" : "Standard focus borders restored");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildToggleTile(
            context,
            icon: Icons.mic_external_on_rounded,
            title: "Voice Assistance Ready",
            subtitle: "Prepare workspace commands for voice recognition dictation tools",
            value: provider.accessVoiceAssistance,
            onChanged: (val) {
              provider.toggleAccessibilityFeature('voice', val);
              _showFeedback(context,
                  val ? "Voice assistance readiness enabled" : "Voice assistance disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorAccessibilitySection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final modes = [
      {
        "name": "Default Colors",
        "desc": "Standard JobNest enterprise palette with balanced saturation",
        "color": Colors.blue,
      },
      {
        "name": "High Contrast",
        "desc": "Reinforced outlines and maximum text-to-background contrast ratio",
        "color": Colors.deepPurple,
      },
      {
        "name": "Color Blind Friendly",
        "desc": "Protanopia & Deuteranopia optimized cyan/amber status palette",
        "color": Colors.teal,
      },
      {
        "name": "Dark Optimized",
        "desc": "Deep slate tones engineered to reduce digital eye fatigue",
        "color": Colors.indigo,
      },
    ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select an accessible color profile (Preview only):",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: modes.map((mode) {
              final isSel = provider.colorAccessibilityMode == mode["name"]!;
              final color = mode["color"] as Color;
              return ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 430),
                child: InkWell(
                  onTap: () {
                    provider.updateLanguageAccessibility(colorMode: mode["name"] as String);
                    _showFeedback(context, "Color accessibility set to ${mode["name"]}");
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSel
                          ? color.withValues(alpha: 0.15)
                          : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSel ? color : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                        width: isSel ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                          child: isSel
                              ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                              : null,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mode["name"] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isSel ? color : null,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                mode["desc"] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationSettingsSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final speeds = ["0.5x Slow", "1.0x Standard", "1.5x Fast", "2.0x Instant"];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Enable UI Animations",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            subtitle: const Text("Smooth transitions when navigating menus and opening modals"),
            value: provider.animEnabled,
            onChanged: (val) {
              provider.toggleAnimationSetting('enabled', val);
              _showFeedback(context, val ? "Animations enabled" : "Animations disabled");
            },
          ),
          const Divider(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Reduce Motion & Parallax",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            subtitle: const Text("Replace sliding animations with simple fade effects for comfort"),
            value: provider.animReduceMotion,
            onChanged: (val) {
              provider.toggleAnimationSetting('motion', val);
              _showFeedback(context, val ? "Reduce motion enabled" : "Standard motion restored");
            },
          ),
          const SizedBox(height: 12),
          Text(
            "Animation Transition Speed:",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: speeds.map((speed) {
              final isSel = provider.animSpeed == speed;
              return ChoiceChip(
                label: Text(speed,
                    style: TextStyle(
                        fontWeight: isSel ? FontWeight.bold : FontWeight.w600,
                        fontSize: 13)),
                selected: isSel,
                onSelected: (sel) {
                  if (sel) {
                    provider.updateLanguageAccessibility(animationSpeed: speed);
                    _showFeedback(context, "Animation speed set to $speed");
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReadabilitySection(
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
            icon: Icons.format_line_spacing_rounded,
            title: "Line Spacing Density",
            value: provider.readabilityLineSpacing,
            options: [
              "1.2x Compact",
              "1.5x Standard",
              "1.8x Relaxed",
              "2.0x Double"
            ],
            onSelect: (val) {
              provider.updateLanguageAccessibility(lineSpacing: val);
              _showFeedback(context, "Line spacing set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.format_bold_rounded,
            title: "Typography Font Weight",
            value: provider.readabilityFontWeight,
            options: [
              "Regular (400)",
              "Medium (500)",
              "Semi-Bold (600)",
              "Bold (700)"
            ],
            onSelect: (val) {
              provider.updateLanguageAccessibility(fontWeight: val);
              _showFeedback(context, "Font weight set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.view_agenda_outlined,
            title: "Card Spacing Density",
            value: provider.readabilityCardDensity,
            options: [
              "Comfortable",
              "Standard",
              "Compact",
              "Ultra-Compact"
            ],
            onSelect: (val) {
              provider.updateLanguageAccessibility(cardDensity: val);
              _showFeedback(context, "Card density set to $val");
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildSelectorTile(
            context,
            icon: Icons.photo_size_select_small_rounded,
            title: "Interface Icon Dimensions",
            value: provider.readabilityIconSize,
            options: ["Small (18px)", "Medium (24px)", "Large (32px)"],
            onSelect: (val) {
              provider.updateLanguageAccessibility(iconSize: val);
              _showFeedback(context, "Icon size set to $val");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResetButtonSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.settings_backup_restore_rounded, size: 36, color: Colors.orange),
          const SizedBox(height: 12),
          Text(
            "Restore Accessibility Defaults",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "Reset all language selections, regional date formats, text scaling, contrast toggles, and readability tuning back to standard JobNest enterprise defaults.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _showResetConfirmDialog(context, provider),
              icon: const Icon(Icons.refresh_rounded, color: Colors.orange),
              label: const Text(
                "Restore Default Accessibility Settings",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.orange, width: 1.5),
              ),
            ),
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
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
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
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                fontWeight: isSel ? FontWeight.bold : FontWeight.normal)),
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
          "Are you sure you want to reset all language selections, regional formatting standards, text scaling sliders, and accessibility switches back to their default values?\n\nThis action will immediately update the live preview.",
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
              provider.resetLanguageAccessibilityToDefaults();
              _showFeedback(context, "All language & accessibility defaults restored!");
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text("Restore Defaults"),
            style: FilledButton.styleFrom(backgroundColor: Colors.orange),
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
