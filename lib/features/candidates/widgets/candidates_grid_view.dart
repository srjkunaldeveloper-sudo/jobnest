import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/candidates/providers/candidate_provider.dart';
import 'package:jobnest/features/candidates/widgets/candidate_list_card.dart';

class CandidatesGridView extends StatelessWidget {
  final CandidateProvider provider;
  final List<CandidateModel> candidates;
  final double availableWidth;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final Set<String> selectedCandidateIds;
  final bool isMultiSelectMode;
  final ValueChanged<String> onToggleSelection;

  const CandidatesGridView({
    super.key,
    required this.provider,
    required this.candidates,
    required this.availableWidth,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
    required this.selectedCandidateIds,
    required this.isMultiSelectMode,
    required this.onToggleSelection,
  });

  void _showSnackBar(BuildContext context, String message, {Duration duration = const Duration(seconds: 4)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: duration),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final double spacing = isMobile ? 16.0 : 24.0;
    
    final double rawCardWidth = (availableWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
    final double cardWidth = rawCardWidth < 0 ? 100.0 : rawCardWidth;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: candidates.map((cand) {
        final isSelected = selectedCandidateIds.contains(cand.id);

        return SizedBox(
          width: cardWidth,
          child: Dismissible(
            key: ValueKey(cand.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              provider.deleteCandidate(cand.id);
              if (selectedCandidateIds.contains(cand.id)) {
                onToggleSelection(cand.id);
              }
              _showSnackBar(context, "Archived '${cand.name}'. Today's Focus updated!", duration: const Duration(seconds: 2));
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: AppRadius.medium,
              ),
              child: Icon(AppIcons.archive_outlined, color: Theme.of(context).colorScheme.error),
            ),
            child: CandidateListCard(
              name: cand.name,
              role: cand.role,
              location: cand.location,
              experience: cand.experience,
              skills: cand.skills,
              matchPercentage: cand.matchPercentage,
              score: cand.score,
              candidate: cand,
              isMultiSelectMode: isMultiSelectMode || selectedCandidateIds.isNotEmpty,
              isSelected: isSelected,
              onSelectChanged: () => onToggleSelection(cand.id),
              onBookmarkTap: () => provider.toggleBookmarkCandidate(cand.id),
              onStageChange: (newStage) {
                provider.updateCandidateStage(cand.id, newStage);
                _showSnackBar(context, "Moved '${cand.name}' to $newStage stage.");
              },
              onScheduleInterviewTap: () => _showSnackBar(context, "Scheduled interview with ${cand.name}. Calendar invite sent."),
              onSendMessageTap: () => _showSnackBar(context, "Opening chat thread with ${cand.name}."),
              onDeleteTap: () {
                provider.deleteCandidate(cand.id);
                if (isSelected) {
                  onToggleSelection(cand.id);
                }
                _showSnackBar(context, "Archived '${cand.name}'.");
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
