import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';

class CandidatesErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onRestore;

  const CandidatesErrorState({
    super.key,
    required this.onRetry,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: AppErrorState(
        title: "Failed to load candidate profiles",
        message: "Please check your network connection and try again.",
        primaryButtonText: "Retry Loading",
        onRetry: onRetry,
        secondaryButtonText: "Restore Profiles",
        onSecondaryAction: onRestore,
        iconData: AppIcons.cloud_off_rounded,
      ),
    );
  }
}
