import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/core/theme/app_input_decoration.dart';

class Step1Basics extends StatelessWidget {
  const Step1Basics({super.key});

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
                  "Job Basics",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  "Enter the basic information required to create a new requisition.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 1: Posting Type
                Text(
                  "Posting Type",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                if (isDesktop)
                  Container(
                    height: 56,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          alignment: provider.postingType == "Internal"
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF4F6DFF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _SegmentOption(
                                label: "Internal Requisition",
                                icon: Icons.business_center_outlined,
                                isSelected: provider.postingType == "Internal",
                                onTap: () => provider.setPostingType("Internal"),
                              ),
                            ),
                            Expanded(
                              child: _SegmentOption(
                                label: "External Requisition",
                                icon: Icons.public_outlined,
                                isSelected: provider.postingType == "External",
                                onTap: () => provider.setPostingType("External"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                else ...[
                  _buildMobileCard(
                    context,
                    title: "Internal Requisition",
                    description: "For internal hiring only",
                    isSelected: provider.postingType == "Internal",
                    onTap: () => provider.setPostingType("Internal"),
                  ),
                  const SizedBox(height: 12),
                  _buildMobileCard(
                    context,
                    title: "External Requisition",
                    description: "Publish to JobNest users",
                    isSelected: provider.postingType == "External",
                    onTap: () => provider.setPostingType("External"),
                  ),
                ],
                const SizedBox(height: 24),

                // SECTION 2: Fields
                Text(
                  "Job Details",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Job Title & Company
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Job Title",
                          isRequired: true,
                          controller: provider.jobTitleController,
                          hintText: "e.g. Senior Product Designer",
                          errorText: provider.errors['jobTitle'],
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Company Name",
                          isRequired: true,
                          controller: provider.companyController,
                          hintText: "e.g. Acme Corp",
                          errorText: provider.errors['company'],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTextField(
                    context,
                    label: "Job Title",
                    isRequired: true,
                    controller: provider.jobTitleController,
                    hintText: "e.g. Senior Product Designer",
                    errorText: provider.errors['jobTitle'],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    label: "Company Name",
                    isRequired: true,
                    controller: provider.companyController,
                    hintText: "e.g. Acme Corp",
                    errorText: provider.errors['company'],
                  ),
                ],
                const SizedBox(height: 16),

                // Department & Employment Type
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Department",
                          isRequired: true,
                          controller: provider.departmentController,
                          hintText: "e.g. Engineering",
                          errorText: provider.errors['department'],
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: _buildDropdown(
                          context,
                          label: "Employment Type",
                          isRequired: true,
                          value: provider.employmentType,
                          items: ["Full Time", "Part Time", "Contract", "Internship"],
                          onChanged: (val) {
                            if (val != null) provider.setEmploymentType(val);
                          },
                          errorText: provider.errors['employmentType'],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTextField(
                    context,
                    label: "Department",
                    isRequired: true,
                    controller: provider.departmentController,
                    hintText: "e.g. Engineering",
                    errorText: provider.errors['department'],
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    context,
                    label: "Employment Type",
                    isRequired: true,
                    value: provider.employmentType,
                    items: ["Full Time", "Part Time", "Contract", "Internship"],
                    onChanged: (val) {
                      if (val != null) provider.setEmploymentType(val);
                    },
                    errorText: provider.errors['employmentType'],
                  ),
                ],
                const SizedBox(height: 16),

                // Seniority Level & Experience Level
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Seniority Level",
                          controller: provider.seniorityController,
                          hintText: "e.g. Mid-Level",
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: _buildDropdown(
                          context,
                          label: "Experience Level",
                          isRequired: true,
                          value: provider.experience,
                          items: ["Entry Level", "1-3 Years", "3-5 Years", "5+ Years"],
                          onChanged: (val) {
                            if (val != null) provider.setExperience(val);
                          },
                          errorText: provider.errors['experience'],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTextField(
                    context,
                    label: "Seniority Level",
                    controller: provider.seniorityController,
                    hintText: "e.g. Mid-Level",
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    context,
                    label: "Experience Level",
                    isRequired: true,
                    value: provider.experience,
                    items: ["Entry Level", "1-3 Years", "3-5 Years", "5+ Years"],
                    onChanged: (val) {
                      if (val != null) provider.setExperience(val);
                    },
                    errorText: provider.errors['experience'],
                  ),
                ],
                const SizedBox(height: 16),

                // Number of Positions
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Number of Positions",
                          isRequired: true,
                          controller: provider.positionsController,
                          hintText: "e.g. 1",
                          keyboardType: TextInputType.number,
                          errorText: provider.errors['positions'],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  )
                else
                  _buildTextField(
                    context,
                    label: "Number of Positions",
                    isRequired: true,
                    controller: provider.positionsController,
                    hintText: "e.g. 1",
                    keyboardType: TextInputType.number,
                    errorText: provider.errors['positions'],
                  ),
              ],
            ),
          ),
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

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    bool isRequired = false,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? errorText,
  }) {
    final theme = Theme.of(context);
    final activeValue = items.contains(value) ? value : items.first;

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
        DropdownButtonFormField<String>(
          initialValue: activeValue,
          style: theme.textTheme.bodyMedium,
          decoration: AppInputDecoration.style(
            context,
            errorText: errorText,
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

  Widget _buildMobileCard(
    BuildContext context, {
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(minHeight: 68),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4F6DFF).withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFF4F6DFF) : const Color(0xFFE2E8F0),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF4F6DFF) : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: isSelected
                          ? const Color(0xFF4F6DFF).withValues(alpha: 0.7)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
              color: isSelected ? const Color(0xFF4F6DFF) : const Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: TweenAnimationBuilder<Color?>(
          duration: const Duration(milliseconds: 200),
          tween: ColorTween(
            begin: isSelected ? const Color(0xFF475569) : Colors.white,
            end: isSelected ? Colors.white : const Color(0xFF475569),
          ),
          builder: (context, color, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
