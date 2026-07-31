import 'package:flutter/material.dart';

/// A widget that displays a loading state with skeleton cards for the jobs list.
class JobsLoading extends StatelessWidget {
  const JobsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return const _JobSkeletonCard();
      },
    );
  }
}

/// The internal layout of a single skeleton job card mimicking the real JobCard.
class _JobSkeletonCard extends StatelessWidget {
  const _JobSkeletonCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      color: theme.colorScheme.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _SkeletonContainer(width: 200, height: 20),
                      SizedBox(height: 8),
                      _SkeletonContainer(width: 120, height: 16),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const _SkeletonContainer(width: 24, height: 24, isCircle: true),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                _SkeletonContainer(width: 60, height: 24, borderRadius: 8),
                SizedBox(width: 8),
                _SkeletonContainer(width: 70, height: 24, borderRadius: 8),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: const [
                _SkeletonContainer(width: 100, height: 16),
                _SkeletonContainer(width: 90, height: 16),
                _SkeletonContainer(width: 80, height: 16),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(height: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _SkeletonContainer(width: 70, height: 12),
                    SizedBox(height: 4),
                    _SkeletonContainer(width: 30, height: 16),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _SkeletonContainer(width: 60, height: 12),
                    SizedBox(height: 4),
                    _SkeletonContainer(width: 20, height: 16),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable skeleton container widget used to represent loading content.
class _SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final bool isCircle;
  final double borderRadius;

  const _SkeletonContainer({
    required this.width,
    required this.height,
    this.isCircle = false,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
      ),
    );
  }
}
