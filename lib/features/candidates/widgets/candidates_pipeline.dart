import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'dart:async';

class CandidatesPipeline extends StatefulWidget {
  const CandidatesPipeline({super.key});

  @override
  State<CandidatesPipeline> createState() => _CandidatesPipelineState();
}

class _CandidatesPipelineState extends State<CandidatesPipeline> {
  static bool _hasShownHint = false;
  bool _isHintVisible = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!_hasShownHint) {
      _hasShownHint = true;
      _isHintVisible = true;
      
      // Auto-hide the hint after 3 seconds
      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isHintVisible = false;
          });
        }
      });
      
      // Smooth peek animation to indicate scrollability
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Future.delayed(const Duration(milliseconds: 600), () {
            if (mounted && _scrollController.hasClients) {
              _scrollController.animateTo(
                80.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
              ).then((_) {
                if (mounted && _scrollController.hasClients) {
                  _scrollController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInCubic,
                  );
                }
              });
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hiring Pipeline",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Pipeline backend se sync hogi.
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Fade Gradient Mask
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white, 
                      Colors.white, 
                      Colors.transparent
                    ],
                    stops: [0.0, 0.9, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: false,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPipelineStage(context, "Applied", 124, Colors.grey, isFirst: true),
                        _buildPipelineStage(context, "Shortlisted", 45, Colors.blue),
                        _buildPipelineStage(context, "Interview", 12, Colors.orange),
                        _buildPipelineStage(context, "Selected", 3, Colors.green),
                        _buildPipelineStage(context, "Rejected", 86, Colors.redAccent, isLast: true),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Swipe Hint Overlay
              IgnorePointer(
                child: AnimatedOpacity(
                  opacity: _isHintVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_ios_rounded, size: 12, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          "Swipe to view more",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPipelineStage(BuildContext context, String title, int count, Color color, {bool isFirst = false, bool isLast = false}) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFirst)
          Container(
            width: 40,
            height: 2,
            margin: const EdgeInsets.only(top: 24),
            color: theme.dividerColor,
          ),
        SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      count.toString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: 1.0,
                backgroundColor: theme.dividerColor.withValues(alpha: 0.5),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                borderRadius: BorderRadius.circular(4),
                minHeight: 4,
              ),
              const SizedBox(height: 16),
              _buildAvatarStack(theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack(ThemeData theme) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.primaryContainer, child: Text("A", style: TextStyle(fontSize: 12, color: theme.colorScheme.onPrimaryContainer))),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.secondaryContainer, child: Text("B", style: TextStyle(fontSize: 12, color: theme.colorScheme.onSecondaryContainer))),
          ),
          Positioned(
            left: 40,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.tertiaryContainer, child: Text("C", style: TextStyle(fontSize: 12, color: theme.colorScheme.onTertiaryContainer))),
          ),
          Positioned(
            left: 60,
            child: CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.surfaceContainerHighest, child: Text("+9", style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurfaceVariant))),
          ),
        ],
      ),
    );
  }
}

