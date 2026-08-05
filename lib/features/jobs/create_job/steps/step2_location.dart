import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';

import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/core/theme/app_input_decoration.dart';
import 'package:jobnest/core/constants/app_radius.dart';

class Step2Location extends StatefulWidget {
  const Step2Location({super.key});

  @override
  State<Step2Location> createState() => _Step2LocationState();
}

class _Step2LocationState extends State<Step2Location> {
  final TextEditingController _locationInputController = TextEditingController();

  @override
  void dispose() {
    _locationInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CreateJobProvider>();


    final showOfficeAddress = provider.workMode == "In Office" || provider.workMode == "Hybrid";

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
                  "Location Settings",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  "Choose where candidates will work and where this position is available.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 1: Work Mode
                Text(
                  "Work Mode",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment<String>(
                        value: "In Office",
                        label: Text("In Office"),
                      ),
                      ButtonSegment<String>(
                        value: "Hybrid",
                        label: Text("Hybrid"),
                      ),
                      ButtonSegment<String>(
                        value: "Remote",
                        label: Text("Remote"),
                      ),
                    ],
                    selected: {provider.workMode},
                    onSelectionChanged: (Set<String> newSelection) {
                      provider.setWorkMode(newSelection.first);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // SECTION 2: Job Locations
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Job Locations (Max 3)",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "${provider.locations.length}/3 Locations",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (provider.errors['locations'] != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      provider.errors['locations']!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ] else ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: provider.locations.map((loc) {
                      return Chip(
                        avatar: const Icon(Icons.location_on_rounded, size: 16),
                        label: Text(loc),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () {
                          provider.removeLocation(loc);
                        },
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 16),

                // Add Location Input Row
                if (provider.locations.length < 3)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _locationInputController,
                          style: theme.textTheme.bodyMedium,
                          decoration: AppInputDecoration.style(
                            context,
                            hintText: "Enter a job city (e.g. Bangalore)",
                          ).copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        onPressed: () {
                          final text = _locationInputController.text.trim();
                          if (text.isNotEmpty) {
                            provider.addLocation(text);
                            _locationInputController.clear();
                          }
                        },
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
                else
                  Text(
                    "Maximum limit of 3 locations reached.",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                const SizedBox(height: 24),

                // SECTION 3: Office Address
                if (showOfficeAddress) ...[
                  Row(
                    children: [
                      Text(
                        "Office Address",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: provider.officeAddressController,
                    maxLines: 3,
                    style: theme.textTheme.bodyMedium,
                    decoration: AppInputDecoration.style(
                      context,
                      hintText: "Enter the complete physical office address details...",
                      errorText: provider.errors['officeAddress'],
                    ).copyWith(
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // SECTION 4: Info Row
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
                        "Candidates will see these locations on the job listing.",
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
