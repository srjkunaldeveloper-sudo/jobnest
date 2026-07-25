import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class AppShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const AppShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<AppShimmerLoading> createState() => _AppShimmerLoadingState();
}

class _AppShimmerLoadingState extends State<AppShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: _animation.value),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          ),
        );
      },
    );
  }
}

class AppSkeletonCard extends StatelessWidget {
  const AppSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppShimmerLoading(width: 40, height: 40, borderRadius: BorderRadius.all(Radius.circular(8))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerLoading(width: 120, height: 16, borderRadius: BorderRadius.circular(4)),
                    const SizedBox(height: 8),
                    AppShimmerLoading(width: 80, height: 12, borderRadius: BorderRadius.circular(4)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppShimmerLoading(width: double.infinity, height: 12, borderRadius: BorderRadius.circular(4)),
          const SizedBox(height: 8),
          AppShimmerLoading(width: MediaQuery.of(context).size.width * 0.6, height: 12, borderRadius: BorderRadius.circular(4)),
        ],
      ),
    );
  }
}
