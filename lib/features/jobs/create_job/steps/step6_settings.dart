import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/core/theme/app_input_decoration.dart';
import 'package:jobnest/core/constants/app_radius.dart';

class Step6Settings extends StatefulWidget {
  const Step6Settings({super.key});

  @override
  State<Step6Settings> createState() => _Step6SettingsState();
}

class _Step6SettingsState extends State<Step6Settings> {
  final TextEditingController _questionInputController = TextEditingController();

  @override
  void dispose() {
    _questionInputController.dispose();
    super.dispose();
  }

  Future<void> _selectStartTime(BuildContext context, CreateJobProvider provider) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: provider.startTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      provider.setStartTime(picked);
    }
  }

  Future<void> _selectEndTime(BuildContext context, CreateJobProvider provider) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: provider.endTime ?? const TimeOfDay(hour: 17, minute: 0),
    );
    if (picked != null) {
      provider.setEndTime(picked);
    }
  }

  void _handleAddQuestion(CreateJobProvider provider) {
    final text = _questionInputController.text.trim();
    if (text.isNotEmpty) {
      provider.addQuestion(text);
      _questionInputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CreateJobProvider>();
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: AppCard(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Additional Settings",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  "Configure hiring preferences, recruiter ownership and interview settings.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 1: Hiring Preferences
                Text(
                  "Hiring Preferences",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Relocation required switch
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Relocation Required",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Candidates must be willing to relocate to job locations.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: provider.relocationRequired,
                      onChanged: (val) {
                        provider.setRelocationRequired(val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Travel requirement dropdown
                _buildDropdown(
                  context,
                  label: "Travel Requirement",
                  value: provider.travelRequirement,
                  items: ["None", "Occasional", "Frequent"],
                  onChanged: (val) {
                    if (val != null) provider.setTravelRequirement(val);
                  },
                ),
                const SizedBox(height: 24),

                // SECTION 2: Hiring Timeline
                Text(
                  "Hiring Timeline & Priority",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Timeline dropdown
                _buildDropdown(
                  context,
                  label: "Hiring Timeline",
                  value: provider.hiringTimeline,
                  items: [
                    "Immediately",
                    "Within 15 Days",
                    "Within 30 Days",
                    "Within 60 Days",
                    "Flexible"
                  ],
                  onChanged: (val) {
                    if (val != null) provider.setHiringTimeline(val);
                  },
                ),
                const SizedBox(height: 20),

                // Priority segmented control
                Text(
                  "Job Priority",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment<String>(value: "Low", label: Text("Low")),
                      ButtonSegment<String>(value: "Medium", label: Text("Medium")),
                      ButtonSegment<String>(value: "High", label: Text("High")),
                      ButtonSegment<String>(value: "Urgent", label: Text("Urgent")),
                    ],
                    selected: {provider.priority},
                    onSelectionChanged: (Set<String> newSelection) {
                      provider.setPriority(newSelection.first);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // SECTION 3: Work Schedule
                Text(
                  "Work Schedule",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Shift Type Dropdown
                _buildDropdown(
                  context,
                  label: "Shift Type",
                  value: provider.shiftType,
                  items: ["Day Shift", "Night Shift", "Rotational", "Flexible"],
                  onChanged: (val) {
                    if (val != null) provider.setShiftType(val);
                  },
                ),
                const SizedBox(height: 16),

                // Start Time & End Time Picker
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildTimeField(
                          context,
                          label: "Start Time",
                          time: provider.startTime,
                          onTap: () => _selectStartTime(context, provider),
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: _buildTimeField(
                          context,
                          label: "End Time",
                          time: provider.endTime,
                          onTap: () => _selectEndTime(context, provider),
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTimeField(
                    context,
                    label: "Start Time",
                    time: provider.startTime,
                    onTap: () => _selectStartTime(context, provider),
                  ),
                  const SizedBox(height: 16),
                  _buildTimeField(
                    context,
                    label: "End Time",
                    time: provider.endTime,
                    onTap: () => _selectEndTime(context, provider),
                  ),
                ],
                const SizedBox(height: 24),

                // SECTION 4: Recruiter Information
                Text(
                  "Recruiter Contact Information",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                _buildTextField(
                  context,
                  label: "Recruiter Name",
                  controller: provider.recruiterNameController,
                  hintText: "e.g. John Doe",
                  errorText: provider.errors['recruiterName'],
                ),
                const SizedBox(height: 16),

                // Email & Phone
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Recruiter Email",
                          controller: provider.recruiterEmailController,
                          hintText: "e.g. recruiter@company.com",
                          keyboardType: TextInputType.emailAddress,
                          errorText: provider.errors['recruiterEmail'],
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Recruiter Phone",
                          controller: provider.recruiterPhoneController,
                          hintText: "e.g. +91 98765 43210",
                          keyboardType: TextInputType.phone,
                          errorText: provider.errors['recruiterPhone'],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTextField(
                    context,
                    label: "Recruiter Email",
                    controller: provider.recruiterEmailController,
                    hintText: "e.g. recruiter@company.com",
                    keyboardType: TextInputType.emailAddress,
                    errorText: provider.errors['recruiterEmail'],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    label: "Recruiter Phone",
                    controller: provider.recruiterPhoneController,
                    hintText: "e.g. +91 98765 43210",
                    keyboardType: TextInputType.phone,
                    errorText: provider.errors['recruiterPhone'],
                  ),
                ],
                const SizedBox(height: 24),

                // SECTION 5: Screening Questions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pre-screening Questions (Max 10)",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "${provider.screeningQuestions.length}/10 Questions",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Questions candidates must answer before applying.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),

                // Added Questions list as Cards
                if (provider.screeningQuestions.isNotEmpty) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.screeningQuestions.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final question = provider.screeningQuestions[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.dividerColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                question,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                provider.removeQuestion(question);
                              },
                              icon: const Icon(Icons.delete_outline_rounded),
                              color: theme.colorScheme.error,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // Input Form Field row to add questions
                if (provider.screeningQuestions.length < 10)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _questionInputController,
                          style: theme.textTheme.bodyMedium,
                          decoration: AppInputDecoration.style(
                            context,
                            hintText: "Enter a pre-screening question...",
                          ).copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          onFieldSubmitted: (_) => _handleAddQuestion(provider),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        onPressed: () => _handleAddQuestion(provider),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.button,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("Add"),
                      ),
                    ],
                  )
                else ...[
                  Text(
                    "Maximum 10 questions limit reached.",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // SECTION 6: Info Row
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Additional settings help recruiters standardize hiring workflows and improve candidate quality.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeField(
    BuildContext context, {
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: AppRadius.card,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: AppRadius.card,
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  time != null ? time.format(context) : "Not set",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: theme.textTheme.bodyMedium,
          decoration: AppInputDecoration.style(
            context,
            hintText: hintText,
            errorText: errorText,
          ).copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    final activeValue = items.contains(value) ? value : items.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: activeValue,
          style: theme.textTheme.bodyMedium,
          decoration: AppInputDecoration.style(
            context,
          ).copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
