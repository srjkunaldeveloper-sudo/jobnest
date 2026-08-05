import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_colors.dart';

class ProgressStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressStepper({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<String> stepNames = [
      "Basics",
      "Location",
      "Details",
      "Compensation",
      "Application",
      "Settings",
      "Preview"
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;

              Widget stepIcon;

              if (isCompleted) {
                stepIcon = const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 24,
                );
              } else if (isCurrent) {
                stepIcon = Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else {
                stepIcon = Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    border: Border.all(
                      color: AppColors.border,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      stepIcon,
                      const SizedBox(height: 4),
                      Text(
                        stepNames[index],
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isCurrent
                              ? AppColors.primary
                              : isCompleted
                                  ? AppColors.success
                                  : AppColors.textSecondary,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  if (index < totalSteps - 1)
                    Container(
                      width: 40,
                      height: 2,
                      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                      color: isCompleted
                          ? AppColors.success
                          : AppColors.border,
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
