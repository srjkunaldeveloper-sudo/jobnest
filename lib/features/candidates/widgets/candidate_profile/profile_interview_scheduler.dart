import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/constants/app_spacing.dart';

class ProfileInterviewScheduler extends StatelessWidget {
  const ProfileInterviewScheduler({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(AppIcons.calendar_month_rounded, color: Colors.blueAccent, size: 24),
            AppSpacing.w12,
            Text(
              "Interview Scheduler",
              style: AppText.h3,
            ),
          ],
        ),
        AppSpacing.h16,
        // ===== BACKEND TODO =====
        // TODO: Interview Scheduler calendar API se connect hoga.
        AppCard(
          padding: AppSpacing.edgeInsetsAll24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Technical Round 1",
                          style: AppText.h3.copyWith(fontSize: 16),
                        ),
                        AppSpacing.h16,
                        Row(
                          children: [
                            const Icon(AppIcons.calendar_today_rounded, size: 16, color: Colors.blueAccent),
                            AppSpacing.w8,
                            Text(
                              "28 Oct 2023",
                              style: AppText.label.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.h12,
                        Row(
                          children: [
                            const Icon(AppIcons.access_time_rounded, size: 16, color: Colors.blueAccent),
                            AppSpacing.w8,
                            Text(
                              "10:30 AM - 11:30 AM (IST)",
                              style: AppText.label.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(AppIcons.videocam_rounded, size: 16, color: Colors.blueAccent),
                        AppSpacing.w8,
                        Text(
                          "Google Meet",
                          style: AppText.labelSmall.copyWith(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.h24,
              const Divider(),
              AppSpacing.h20,
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () {},
                      icon: const Icon(AppIcons.edit_calendar_rounded, size: 18),
                      label: const Text("Reschedule"),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  AppSpacing.w16,
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(AppIcons.close_rounded, size: 18),
                      label: const Text("Cancel"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
