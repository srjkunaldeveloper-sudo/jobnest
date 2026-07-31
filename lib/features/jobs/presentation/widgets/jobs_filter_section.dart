import 'package:flutter/material.dart';
import '../../domain/repositories/jobs_repository.dart';

/// A reusable widget for filtering jobs by various criteria.
class JobsFilterSection extends StatelessWidget {
  final JobFilter filter;
  final ValueChanged<String?>? onDepartmentChanged;
  final ValueChanged<String?>? onStatusChanged;
  final ValueChanged<String?>? onEmploymentChanged;
  final ValueChanged<bool>? onRemoteChanged;
  final VoidCallback? onClear;

  const JobsFilterSection({
    super.key,
    required this.filter,
    this.onDepartmentChanged,
    this.onStatusChanged,
    this.onEmploymentChanged,
    this.onRemoteChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Common styling for dropdowns
    final inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
      ),
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Filters',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (onClear != null)
              TextButton(
                onPressed: onClear,
                child: const Text('Clear All'),
              ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            // Responsive layout: Column for narrow screens, Wrap/Row for wide screens
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: _calculateFieldWidth(constraints.maxWidth),
                  child: DropdownButtonFormField<String>(
                    decoration: inputDecoration.copyWith(labelText: 'Department'),
                    value: filter.department,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(value: 'Engineering', child: Text('Engineering')),
                      DropdownMenuItem(value: 'Product', child: Text('Product')),
                      DropdownMenuItem(value: 'Design', child: Text('Design')),
                      DropdownMenuItem(value: 'Sales', child: Text('Sales')),
                      DropdownMenuItem(value: 'Marketing', child: Text('Marketing')),
                    ],
                    onChanged: onDepartmentChanged,
                  ),
                ),
                SizedBox(
                  width: _calculateFieldWidth(constraints.maxWidth),
                  child: DropdownButtonFormField<String>(
                    decoration: inputDecoration.copyWith(labelText: 'Status'),
                    value: filter.status,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(value: 'Active', child: Text('Active')),
                      DropdownMenuItem(value: 'Draft', child: Text('Draft')),
                      DropdownMenuItem(value: 'Closed', child: Text('Closed')),
                      DropdownMenuItem(value: 'On Hold', child: Text('On Hold')),
                    ],
                    onChanged: onStatusChanged,
                  ),
                ),
                SizedBox(
                  width: _calculateFieldWidth(constraints.maxWidth),
                  child: DropdownButtonFormField<String>(
                    decoration: inputDecoration.copyWith(labelText: 'Employment Type'),
                    value: filter.employmentType,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(value: 'Full-time', child: Text('Full-time')),
                      DropdownMenuItem(value: 'Part-time', child: Text('Part-time')),
                      DropdownMenuItem(value: 'Contract', child: Text('Contract')),
                      DropdownMenuItem(value: 'Internship', child: Text('Internship')),
                    ],
                    onChanged: onEmploymentChanged,
                  ),
                ),
                SizedBox(
                  width: _calculateFieldWidth(constraints.maxWidth),
                  child: Container(
                    height: 56, // Matches standard DropdownButtonFormField height roughly
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outlineVariant),
                      borderRadius: BorderRadius.circular(12),
                      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Remote Only',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Switch(
                          value: filter.isRemote ?? false,
                          onChanged: onRemoteChanged,
                          activeColor: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  double _calculateFieldWidth(double maxWidth) {
    if (maxWidth > 600) {
      // 2 columns for wider screens
      return (maxWidth - 16) / 2;
    }
    // 1 column for narrow screens
    return maxWidth;
  }
}
