import 'package:flutter/material.dart';

class ProfileQuickActions extends StatelessWidget {
  const ProfileQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ===== BACKEND TODO =====
        // TODO: Shortlist API connect hogi.
        // TODO: Message backend integration future me hogi.
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check_rounded, size: 20),
                label: const Text("Shortlist Candidate"),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today_rounded, size: 20),
                label: const Text("Schedule Interview"),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                label: const Text("Send Message"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.close_rounded, size: 20),
                label: const Text("Reject"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
