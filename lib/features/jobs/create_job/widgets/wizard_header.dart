import 'package:flutter/material.dart';

class WizardHeader extends StatelessWidget {
  final int currentStep;

  const WizardHeader({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, String>> stepsInfo = [
      {
        "title": "Job Basics",
        "subtitle": "Provide the basic information for this requisition."
      },
      {
        "title": "Location Details",
        "subtitle": "Select location preferences and office address details."
      },
      {
        "title": "Job Specifications",
        "subtitle": "Set description, daily responsibilities, and qualifications."
      },
      {
        "title": "Compensation & Benefits",
        "subtitle": "Define salary range, visibility, and employee benefits."
      },
      {
        "title": "Application Method",
        "subtitle": "Specify how candidates should apply and the deadline."
      },
      {
        "title": "Additional Requisition Settings",
        "subtitle": "Manage hiring rules, interviewer settings, and questions."
      },
      {
        "title": "Requisition Review",
        "subtitle": "Review all requisition sections before publishing."
      },
    ];

    final info = stepsInfo[currentStep];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info["title"]!,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            info["subtitle"]!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
