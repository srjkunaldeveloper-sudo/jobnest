import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/core/theme/app_input_decoration.dart';
import 'package:jobnest/core/constants/app_radius.dart';

class Step5Application extends StatelessWidget {
  const Step5Application({super.key});

  Future<void> _selectDeadlineDate(BuildContext context, CreateJobProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.applicationDeadline ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      provider.setApplicationDeadline(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CreateJobProvider>();

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
                  "Application Settings",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  "Choose how candidates can apply for this position.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 1: Application Method
                Text(
                  "Application Method",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Card 1: Apply on JobNest
                _buildMethodCard(
                  context,
                  title: "Apply on JobNest",
                  description: "Candidates apply directly inside the application.",
                  icon: Icons.app_registration_rounded,
                  isSelected: provider.applicationMethod == "Apply on JobNest",
                  onTap: () {
                    provider.setApplicationMethod("Apply on JobNest");
                  },
                ),
                const SizedBox(height: 12),

                // Card 2: External Website
                _buildMethodCard(
                  context,
                  title: "External Website",
                  description: "Redirect applicants to an external careers page.",
                  icon: Icons.language_rounded,
                  isSelected: provider.applicationMethod == "External Website",
                  onTap: () {
                    provider.setApplicationMethod("External Website");
                  },
                ),
                const SizedBox(height: 12),

                // Card 3: Email Application
                _buildMethodCard(
                  context,
                  title: "Email Application",
                  description: "Candidates send applications directly via email.",
                  icon: Icons.email_rounded,
                  isSelected: provider.applicationMethod == "Email Application",
                  onTap: () {
                    provider.setApplicationMethod("Email Application");
                  },
                ),

                // Conditional Fields
                if (provider.applicationMethod == "External Website") ...[
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    label: "External URL",
                    isRequired: true,
                    controller: provider.externalUrlController,
                    hintText: "https://company.com/careers",
                    keyboardType: TextInputType.url,
                    errorText: provider.errors['externalUrl'],
                  ),
                ] else if (provider.applicationMethod == "Email Application") ...[
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    label: "Recruitment Email",
                    isRequired: true,
                    controller: provider.applicationEmailController,
                    hintText: "jobs@company.com",
                    keyboardType: TextInputType.emailAddress,
                    errorText: provider.errors['applicationEmail'],
                  ),
                ],
                const SizedBox(height: 24),

                // SECTION 2: Application Deadline
                Text(
                  "Application Deadline",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDeadlineDate(context, provider),
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
                                Icons.calendar_today_rounded,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                provider.applicationDeadline != null
                                    ? "${provider.applicationDeadline!.day}/${provider.applicationDeadline!.month}/${provider.applicationDeadline!.year}"
                                    : "No deadline set",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: provider.applicationDeadline != null
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (provider.applicationDeadline != null) ...[
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () {
                          provider.clearApplicationDeadline();
                        },
                        icon: const Icon(Icons.clear_rounded),
                        tooltip: "Clear Deadline",
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),

                // SECTION 3: Info Row
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
                        "Choose the application method that best matches your recruitment workflow.",
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

  Widget _buildMethodCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.card,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.colorScheme.primary.withValues(alpha: 0.08) 
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
          borderRadius: AppRadius.card,
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary 
                : theme.dividerColor.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    bool isRequired = false,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (isRequired)
              Text(
                " *",
                style: TextStyle(color: theme.colorScheme.error),
              ),
          ],
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
}
