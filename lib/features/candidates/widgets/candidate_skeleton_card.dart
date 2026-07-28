import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

// Minimal skeleton for premium loading state
class SkeletonLoaderCard extends StatelessWidget {
  const SkeletonLoaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skeletonColor = theme.dividerColor.withValues(alpha: 0.3);

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 56, height: 56, decoration: BoxDecoration(color: skeletonColor, shape: BoxShape.circle)),
              AppSpacing.w16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 140, height: 16, color: skeletonColor),
                    AppSpacing.h8,
                    Container(width: 100, height: 12, color: skeletonColor),
                  ],
                ),
              ),
              Container(width: 70, height: 24, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(12))),
            ],
          ),
          AppSpacing.h20,
          Row(
            children: [
              Container(width: 80, height: 12, color: skeletonColor),
              AppSpacing.w12,
              Container(width: 80, height: 12, color: skeletonColor),
              AppSpacing.w12,
              Container(width: 60, height: 12, color: skeletonColor),
            ],
          ),
          AppSpacing.h20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(width: 50, height: 24, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(12))),
                  const SizedBox(width: 6),
                  Container(width: 50, height: 24, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(12))),
                ],
              ),
              Container(width: 80, height: 26, decoration: BoxDecoration(color: skeletonColor, borderRadius: AppRadius.medium)),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 70, height: 20, color: skeletonColor),
              Row(
                children: [
                  Container(width: 80, height: 36, decoration: BoxDecoration(color: skeletonColor, borderRadius: AppRadius.small)),
                  AppSpacing.w8,
                  Container(width: 36, height: 36, decoration: BoxDecoration(color: skeletonColor, shape: BoxShape.circle)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
