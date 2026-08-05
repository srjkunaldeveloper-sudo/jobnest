import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_radius.dart';

class WizardFooter extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const WizardFooter({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFirstStep = currentStep == 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.15)),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: isFirstStep ? null : onPrevious,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(120, 52),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.button,
                ),
                backgroundColor: theme.colorScheme.surface,
                side: BorderSide(
                  color: isFirstStep
                      ? theme.dividerColor.withValues(alpha: 0.15)
                      : theme.dividerColor,
                ),
              ),
              child: Text(
                isFirstStep ? "Cancel" : "Back",
                style: TextStyle(
                  color: isFirstStep
                      ? theme.colorScheme.onSurface.withValues(alpha: 0.3)
                      : theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FilledButton(
              onPressed: onNext,
              style: FilledButton.styleFrom(
                minimumSize: const Size(120, 52),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.button,
                ),
                backgroundColor: theme.colorScheme.primary,
              ),
              child: Text(
                currentStep == totalSteps - 1 ? "Publish Job" : "Next",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
