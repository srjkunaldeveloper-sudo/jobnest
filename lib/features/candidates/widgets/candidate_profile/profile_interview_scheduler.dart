import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

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
            const Icon(Icons.calendar_month_rounded, color: Colors.blueAccent, size: 24),
            const SizedBox(width: 12),
            Text(
              "Interview Scheduler",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Interview Scheduler calendar API se connect hoga.
        AppCard(
          padding: const EdgeInsets.all(24),
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
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded, size: 16, color: Colors.blueAccent),
                            const SizedBox(width: 8),
                            Text(
                              "28 Oct 2023",
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, size: 16, color: Colors.blueAccent),
                            const SizedBox(width: 8),
                            Text(
                              "10:30 AM - 11:30 AM (IST)",
                              style: theme.textTheme.labelMedium?.copyWith(
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
                        const Icon(Icons.videocam_rounded, size: 16, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(
                          "Google Meet",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_calendar_rounded, size: 18),
                      label: const Text("Reschedule"),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.close_rounded, size: 18),
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
