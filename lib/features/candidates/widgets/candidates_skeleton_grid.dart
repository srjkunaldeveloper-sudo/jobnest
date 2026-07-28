import 'package:flutter/material.dart';
import 'package:jobnest/features/candidates/widgets/candidate_skeleton_card.dart';

class CandidatesSkeletonGrid extends StatelessWidget {
  final double availableWidth;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const CandidatesSkeletonGrid({
    super.key,
    required this.availableWidth,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final double spacing = isMobile ? 16.0 : 24.0;
    
    final double rawCardWidth = (availableWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
    final double cardWidth = rawCardWidth < 0 ? 100.0 : rawCardWidth;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(6, (index) {
        return SizedBox(
          width: cardWidth,
          child: const SkeletonLoaderCard(),
        );
      }),
    );
  }
}
