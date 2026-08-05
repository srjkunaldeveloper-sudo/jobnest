import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/core/theme/app_input_decoration.dart';
import 'package:jobnest/core/constants/app_radius.dart';

class Step3Details extends StatefulWidget {
  const Step3Details({super.key});

  @override
  State<Step3Details> createState() => _Step3DetailsState();
}

class _Step3DetailsState extends State<Step3Details> {
  int _descCharCount = 0;
  int _respCharCount = 0;
  int _reqCharCount = 0;
  final TextEditingController _skillInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<CreateJobProvider>();
    _descCharCount = provider.descriptionController.text.length;
    _respCharCount = provider.responsibilitiesController.text.length;
    _reqCharCount = provider.requirementsController.text.length;

    provider.descriptionController.addListener(_updateDescCharCount);
    provider.responsibilitiesController.addListener(_updateRespCharCount);
    provider.requirementsController.addListener(_updateReqCharCount);
  }

  @override
  void dispose() {
    final provider = context.read<CreateJobProvider>();
    provider.descriptionController.removeListener(_updateDescCharCount);
    provider.responsibilitiesController.removeListener(_updateRespCharCount);
    provider.requirementsController.removeListener(_updateReqCharCount);
    _skillInputController.dispose();
    super.dispose();
  }

  void _updateDescCharCount() {
    if (mounted) {
      setState(() {
        _descCharCount = context.read<CreateJobProvider>().descriptionController.text.length;
      });
    }
  }

  void _updateRespCharCount() {
    if (mounted) {
      setState(() {
        _respCharCount = context.read<CreateJobProvider>().responsibilitiesController.text.length;
      });
    }
  }

  void _updateReqCharCount() {
    if (mounted) {
      setState(() {
        _reqCharCount = context.read<CreateJobProvider>().requirementsController.text.length;
      });
    }
  }

  void _handleAddSkill(CreateJobProvider provider) {
    final text = _skillInputController.text.trim();
    if (text.isNotEmpty) {
      provider.addSkill(text);
      _skillInputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CreateJobProvider>();

    final List<String> respSuggestions = [
      "Team Management",
      "Client Communication",
      "Code Reviews",
      "Product Planning",
      "Documentation",
      "Mentoring",
    ];

    final List<String> reqSuggestions = [
      "Bachelor's Degree",
      "2+ Years Experience",
      "Communication Skills",
      "Leadership",
      "Problem Solving",
      "Team Player",
    ];

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
                  "Job Details",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  "Describe the role and help candidates understand the opportunity.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // JOB DESCRIPTION SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Job Description",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    // Toolbar: Generate with AI (UI-Only Button)
                    TextButton.icon(
                      onPressed: () {
                        // UI-Only Callback
                      },
                      icon: const Icon(
                        Icons.auto_awesome_rounded,
                        size: 16,
                        color: Colors.deepPurpleAccent,
                      ),
                      label: const Text(
                        "Generate with AI",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 220),
                  child: TextFormField(
                    controller: provider.descriptionController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: theme.textTheme.bodyMedium,
                    decoration: AppInputDecoration.style(
                      context,
                      hintText: "Describe the role, daily responsibilities and expectations.",
                      errorText: provider.errors['description'],
                    ).copyWith(
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$_descCharCount / 5000",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _descCharCount > 5000 
                            ? theme.colorScheme.error 
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // RESPONSIBILITIES SECTION
                Text(
                  "Responsibilities",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Define the key duties and day-to-day expectations for this role.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 180),
                  child: TextFormField(
                    controller: provider.responsibilitiesController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: theme.textTheme.bodyMedium,
                    decoration: AppInputDecoration.style(
                      context,
                      hintText: "Describe the day-to-day responsibilities of this role.",
                    ).copyWith(
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$_respCharCount / 3000",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _respCharCount > 3000 
                            ? theme.colorScheme.error 
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Quick Suggestions",
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: respSuggestions.map((suggestion) {
                    return ActionChip(
                      avatar: const Icon(Icons.add, size: 14),
                      label: Text(suggestion),
                      onPressed: () {
                        provider.appendResponsibilitySuggestion(suggestion);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // REQUIREMENTS SECTION
                Text(
                  "Requirements",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Specify the qualifications and expectations required for this role.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 180),
                  child: TextFormField(
                    controller: provider.requirementsController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: theme.textTheme.bodyMedium,
                    decoration: AppInputDecoration.style(
                      context,
                      hintText: "Example:\nBachelor's degree in Computer Science\nMinimum 3 years experience\nStrong communication skills",
                      errorText: provider.errors['requirements'],
                    ).copyWith(
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$_reqCharCount / 3000",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _reqCharCount > 3000 
                            ? theme.colorScheme.error 
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Quick Requirement Suggestions",
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: reqSuggestions.map((suggestion) {
                    return ActionChip(
                      avatar: const Icon(Icons.add, size: 14),
                      label: Text(suggestion),
                      onPressed: () {
                        provider.appendRequirementSuggestion(suggestion);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // KEY SKILLS SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Key Skills",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "${provider.skills.length}/8 Skills",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Add the primary technical or functional skills required.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                if (provider.errors['skills'] != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      provider.errors['skills']!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                if (provider.skills.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: provider.skills.map((skill) {
                      return Chip(
                        label: Text(skill),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () {
                          provider.removeSkill(skill);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                if (provider.skills.length < 8)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _skillInputController,
                          style: theme.textTheme.bodyMedium,
                          decoration: AppInputDecoration.style(
                            context,
                            hintText: "Enter a skill name (e.g. Flutter)",
                          ).copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          onFieldSubmitted: (_) => _handleAddSkill(provider),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        onPressed: () => _handleAddSkill(provider),
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
                    "Maximum 8 skills allowed.",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // INFO ROW
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Candidates with matching skills are more likely to discover this job.",
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
}
