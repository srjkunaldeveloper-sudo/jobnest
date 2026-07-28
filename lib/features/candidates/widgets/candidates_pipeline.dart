import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/candidates/widgets/candidate_stage_badge.dart';
import 'dart:async';


class CandidatesPipeline extends StatefulWidget {
  final String activeStage;
  final ValueChanged<String>? onStageSelected;

  const CandidatesPipeline({
    super.key,
    this.activeStage = "All",
    this.onStageSelected,
  });

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
    final candidates = context.select<RecruitmentDataProvider, List<CandidateModel>>((provider) => provider.candidates);

    // Dynamically count candidates for each ATS Stage
    int appliedCount = candidates.where((c) => c.stage.toLowerCase() == "applied").length;
    int screeningCount = candidates.where((c) => c.stage.toLowerCase() == "screening").length;
    int interviewCount = candidates.where((c) => c.stage.toLowerCase() == "interview").length;
    int offerCount = candidates.where((c) => c.stage.toLowerCase() == "offer").length;
    int hiredCount = candidates.where((c) => c.stage.toLowerCase() == "hired").length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: [
            Text(
              "Hiring Pipeline (${candidates.length} Total)",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
            if (widget.activeStage != "All")
              TextButton.icon(
                onPressed: () => widget.onStageSelected?.call("All"),
                icon: const Icon(Icons.filter_alt_off_rounded, size: 16),
                label: const Text("Show All Stages"),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // ===== BACKEND TODO =====
        // TODO: Pipeline backend se sync hogi.
        // TODO: Candidate stage update API.
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
                        _buildPipelineStage(context, "Applied", appliedCount, CandidateStageBadge.getStageColor("Applied"), isFirst: true),
                        _buildPipelineStage(context, "Screening", screeningCount, CandidateStageBadge.getStageColor("Screening")),
                        _buildPipelineStage(context, "Interview", interviewCount, CandidateStageBadge.getStageColor("Interview")),
                        _buildPipelineStage(context, "Offer", offerCount, CandidateStageBadge.getStageColor("Offer")),
                        _buildPipelineStage(context, "Hired", hiredCount, CandidateStageBadge.getStageColor("Hired"), isLast: true),
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
                        AppSpacing.w8,
                        const Text(
                          "Swipe to view more",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        AppSpacing.w8,
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

  Widget _buildPipelineStage(
    BuildContext context,
    String title,
    int count,
    Color color, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    final bool isSelected = widget.activeStage.toLowerCase() == title.toLowerCase();
    
    return Semantics(
      label: "Stage $title with $count candidates. Tap to filter by $title.",
      button: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isFirst)
            Container(
              width: 32,
              height: 2,
              margin: const EdgeInsets.only(top: 24),
              color: theme.dividerColor,
            ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (widget.onStageSelected != null) {
                  widget.onStageSelected!(isSelected ? "All" : title);
                }
              },
              borderRadius: AppRadius.medium,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 150,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? color.withValues(alpha: 0.12) : Colors.transparent,
                  borderRadius: AppRadius.medium,
                  border: isSelected ? Border.all(color: color, width: 2.0) : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? color : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
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
                    AppSpacing.h12,
                    LinearProgressIndicator(
                      value: 1.0,
                      backgroundColor: theme.dividerColor.withValues(alpha: 0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      borderRadius: BorderRadius.circular(4),
                      minHeight: isSelected ? 6 : 4,
                    ),
                    AppSpacing.h16,
                    _buildAvatarStack(theme, color, isSelected),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarStack(ThemeData theme, Color stageColor, bool isSelected) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: isSelected ? stageColor.withValues(alpha: 0.3) : theme.colorScheme.primaryContainer,
              child: Text("A", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? stageColor : theme.colorScheme.onPrimaryContainer)),
            ),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: isSelected ? stageColor.withValues(alpha: 0.25) : theme.colorScheme.secondaryContainer,
              child: Text("B", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? stageColor : theme.colorScheme.onSecondaryContainer)),
            ),
          ),
          Positioned(
            left: 40,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: isSelected ? stageColor.withValues(alpha: 0.2) : theme.colorScheme.tertiaryContainer,
              child: Text("C", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? stageColor : theme.colorScheme.onTertiaryContainer)),
            ),
          ),
          Positioned(
            left: 60,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              child: Text("+", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurfaceVariant)),
            ),
          ),
        ],
      ),
    );
  }
}
