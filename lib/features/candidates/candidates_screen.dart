import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/candidates/widgets/candidates_header.dart';
import 'package:jobnest/features/candidates/widgets/candidates_smart_search.dart';
import 'package:jobnest/features/candidates/widgets/candidates_filters.dart';
import 'package:jobnest/features/candidates/widgets/candidates_overview.dart';
import 'package:jobnest/features/candidates/widgets/candidates_pipeline.dart';
import 'package:jobnest/features/candidates/widgets/candidates_auto_screening.dart';
import 'package:jobnest/features/candidates/widgets/candidates_advanced_filters.dart';
import 'package:jobnest/features/candidates/widgets/candidates_simulation_panel.dart';
import 'package:jobnest/features/candidates/widgets/candidates_grid_header.dart';
import 'package:jobnest/features/candidates/widgets/candidates_skeleton_grid.dart';
import 'package:jobnest/features/candidates/widgets/candidates_empty_state.dart';
import 'package:jobnest/features/candidates/widgets/candidates_error_state.dart';
import 'package:jobnest/features/candidates/widgets/candidates_grid_view.dart';
import 'package:jobnest/features/candidates/widgets/candidates_bulk_action_bar.dart';
import 'package:jobnest/features/candidates/providers/candidate_selection_provider.dart';
import 'package:jobnest/features/candidates/providers/candidate_filter_provider.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';
import 'package:jobnest/core/models/recruitment_models.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  // ===== BACKEND TODO =====
  // TODO: Future me selected candidate IDs backend se maintain honge.
  // TODO: Candidate API integration with real-time WebSocket sync.

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CandidatesAdvancedFilters(),
    );
  }

  void _addDummyCandidate(BuildContext context) {
    final provider = context.read<RecruitmentDataProvider>();
    final newId = 'cand_${DateTime.now().millisecondsSinceEpoch}';
    final newCandidate = CandidateModel(
      id: newId,
      name: "New Candidate #${provider.candidates.length + 1}",
      role: "Senior AI Engineer",
      location: "Bangalore, India",
      experience: "4 Years",
      skills: const ["Python", "PyTorch", "LLMs", "FastAPI"],
      matchPercentage: 93,
      score: 8.7,
      isNew: true,
      stage: "Screening",
      expectedSalary: "₹ 24 - 30 LPA",
      rating: 4.8,
      company: "Google India",
      appliedDate: "Just now",
    );
    provider.addCandidate(newCandidate);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Added '${newCandidate.name}'. Today's Focus updated!"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<CandidateModel> _getFilteredAndSortedCandidates(List<CandidateModel> allCandidates, CandidateFilterProvider filter) {
    var list = allCandidates.where((c) {
      // 1. Search filter
      if (filter.searchQuery.isNotEmpty) {
        final q = filter.searchQuery.toLowerCase();
        final nameMatch = c.name.toLowerCase().contains(q);
        final roleMatch = c.role.toLowerCase().contains(q);
        final locMatch = c.location.toLowerCase().contains(q);
        final compMatch = c.company.toLowerCase().contains(q);
        final expMatch = c.experience.toLowerCase().contains(q);
        final skillMatch = c.skills.any((s) => s.toLowerCase().contains(q));
        if (!nameMatch && !roleMatch && !locMatch && !compMatch && !expMatch && !skillMatch) {
          return false;
        }
      }

      // 2. Pipeline Active Stage filter
      if (filter.pipelineActiveStage != "All") {
        if (c.stage.toLowerCase() != filter.pipelineActiveStage.toLowerCase()) {
          return false;
        }
      }

      // 3. Chip Filter
      if (filter.selectedFilter != "All") {
        final f = filter.selectedFilter.toLowerCase();
        if (f == "shortlisted" || f == "interview" || f == "offer" || f == "hired" || f == "applied" || f == "screening" || f == "rejected") {
          if (c.stage.toLowerCase() != f) return false;
        } else if (f == "remote") {
          if (!c.location.toLowerCase().contains("remote")) return false;
        } else if (f.contains("years") || f.contains("year")) {
          if (!c.experience.toLowerCase().contains(f.split(' ')[0])) return false;
        } else if (f.contains("bangalore") || f.contains("delhi") || f.contains("mumbai")) {
          if (!c.location.toLowerCase().contains(f)) return false;
        } else if (f.contains("lpa")) {
          if (!c.expectedSalary.toLowerCase().contains(f.split(' ')[0])) return false;
        }
      }

      return true;
    }).toList();

    // 4. Sorting
    list.sort((a, b) {
      switch (filter.selectedSort) {
        case "Oldest":
          return a.id.compareTo(b.id);
        case "Highest Experience":
          int expA = int.tryParse(a.experience.split(' ')[0]) ?? 0;
          int expB = int.tryParse(b.experience.split(' ')[0]) ?? 0;
          return expB.compareTo(expA);
        case "Lowest Experience":
          int expA = int.tryParse(a.experience.split(' ')[0]) ?? 0;
          int expB = int.tryParse(b.experience.split(' ')[0]) ?? 0;
          return expA.compareTo(expB);
        case "Highest Rating":
          return b.rating.compareTo(a.rating);
        case "Recently Updated":
          if (b.isNew != a.isNew) return b.isNew ? 1 : -1;
          return b.rating.compareTo(a.rating);
        case "Newest":
        default:
          return b.id.compareTo(a.id);
      }
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<RecruitmentDataProvider>();
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CandidateSelectionProvider>(
          create: (_) => CandidateSelectionProvider(),
        ),
        ChangeNotifierProvider<CandidateFilterProvider>(
          create: (_) => CandidateFilterProvider(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final double screenWidth = constraints.maxWidth;
              
              // Responsive Breakpoints (320px - 1024px+)
              final bool isMobile = screenWidth < 600;
              final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
              final bool isDesktop = screenWidth >= 1024;
              
              double contentMaxWidth = screenWidth;
              if (isDesktop) {
                contentMaxWidth = 1200.0;
              }

              final double horizontalPadding = isMobile ? 16.0 : (isTablet ? 24.0 : 32.0);
              double actualContentWidth = screenWidth > contentMaxWidth ? contentMaxWidth : screenWidth;
              final double availableGridWidth = actualContentWidth - (horizontalPadding * 2);

              return Stack(
                children: [
                  Positioned.fill(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await provider.refreshCandidates();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: contentMaxWidth),
                            child: Selector<CandidateSelectionProvider, bool>(
                              selector: (_, selection) => selection.selectedCandidateIds.isNotEmpty,
                              builder: (context, hasSelection, child) {
                                return AnimatedPadding(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOutCubic,
                                  padding: EdgeInsets.only(
                                    left: horizontalPadding,
                                    right: horizontalPadding,
                                    top: 24.0,
                                    bottom: hasSelection
                                        ? 160.0 + MediaQuery.of(context).padding.bottom 
                                        : 40.0 + MediaQuery.of(context).padding.bottom,
                                  ),
                                  child: child,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CandidatesHeader(),
                                  AppSpacing.h20,

                                  // QA Testing Toolbar (Simulation Panel) - Hidden in release/demo mode
                                  if (kDebugMode) ...[
                                    CandidatesSimulationPanel(provider: provider),
                                    AppSpacing.h24,
                                  ],

                                  Selector<CandidateFilterProvider, String>(
                                    selector: (_, filter) => filter.searchQuery,
                                    builder: (context, searchQuery, _) {
                                      final filter = context.read<CandidateFilterProvider>();
                                      return CandidatesSmartSearch(
                                        searchQuery: searchQuery,
                                        onSearchChanged: filter.setSearchQuery,
                                        onClearSearch: () => filter.setSearchQuery(""),
                                        onRecentSelected: filter.setSearchQuery,
                                      );
                                    },
                                  ),
                                  AppSpacing.h20,
                                  
                                  Consumer<CandidateFilterProvider>(
                                    builder: (context, filter, _) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CandidatesFilters(
                                              selectedFilter: filter.selectedFilter,
                                              onFilterChanged: filter.setSelectedFilter,
                                              selectedSort: filter.selectedSort,
                                              onSortChanged: filter.setSelectedSort,
                                              onClearAll: filter.clearAll,
                                            ),
                                          ),
                                          AppSpacing.w12,
                                          Semantics(
                                            label: "Advanced Candidate Filters",
                                            button: true,
                                            child: IconButton(
                                              onPressed: _showAdvancedFilters,
                                              icon: const Icon(Icons.tune_rounded),
                                              style: IconButton.styleFrom(
                                                backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                                                minimumSize: const Size(48, 48),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 28),

                                  Selector<CandidateFilterProvider, String>(
                                    selector: (_, filter) => filter.pipelineActiveStage,
                                    builder: (context, activeStage, _) {
                                      final filter = context.read<CandidateFilterProvider>();
                                      return CandidatesPipeline(
                                        activeStage: activeStage,
                                        onStageSelected: filter.setPipelineActiveStage,
                                      );
                                    },
                                  ),
                                  AppSpacing.h32,

                                  const CandidatesOverview(),
                                  AppSpacing.h32,
                                  
                                  const CandidatesAutoScreening(),
                                  AppSpacing.h32,

                                  // Candidate Grid Header & Grid Views
                                  Consumer3<RecruitmentDataProvider, CandidateSelectionProvider, CandidateFilterProvider>(
                                    builder: (context, provider, selection, filter, _) {
                                      final filteredCandidates = _getFilteredAndSortedCandidates(provider.candidates, filter);
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CandidatesGridHeader(
                                            candidateCount: filteredCandidates.length,
                                            selectedCount: selection.selectedCandidateIds.length,
                                            isMultiSelectMode: selection.isMultiSelectMode,
                                            onSelectAllVisible: () => selection.selectAll(filteredCandidates.map((c) => c.id)),
                                            onToggleMultiSelect: () {
                                              if (selection.isMultiSelectMode) {
                                                selection.clearSelection();
                                              } else {
                                                selection.selectAll(filteredCandidates.map((c) => c.id));
                                              }
                                            },
                                            onAddCandidate: () => _addDummyCandidate(context),
                                          ),
                                          if (provider.isCandidatesLoading)
                                            CandidatesSkeletonGrid(
                                              availableWidth: availableGridWidth,
                                              isMobile: isMobile,
                                              isTablet: isTablet,
                                              isDesktop: isDesktop,
                                            )
                                          else if (provider.isCandidatesError)
                                            CandidatesErrorState(
                                              onRetry: () => provider.refreshCandidates(),
                                              onRestore: () => provider.restoreCandidatesDefault(),
                                            )
                                          else if (filteredCandidates.isEmpty)
                                            CandidatesEmptyState(
                                              onClearFilters: filter.clearAll,
                                              onAddDummyCandidate: () => _addDummyCandidate(context),
                                            )
                                          else
                                            CandidatesGridView(
                                              provider: provider,
                                              candidates: filteredCandidates,
                                              availableWidth: availableGridWidth,
                                              isMobile: isMobile,
                                              isTablet: isTablet,
                                              isDesktop: isDesktop,
                                              selectedCandidateIds: selection.selectedCandidateIds,
                                              isMultiSelectMode: selection.isMultiSelectMode,
                                              onToggleSelection: selection.toggleSelection,
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Floating Bottom Action Bar (Section 4: MULTI SELECT & BULK ACTIONS)
                  Consumer<CandidateSelectionProvider>(
                    builder: (context, selection, _) {
                      final hasSelection = selection.selectedCandidateIds.isNotEmpty;
                      return AnimatedPositioned(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        left: 0,
                        right: 0,
                        bottom: hasSelection ? 0 : -140.0 - MediaQuery.of(context).padding.bottom,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: hasSelection ? 1.0 : 0.0,
                          child: CandidatesBulkActionBar(
                            selectedCandidateIds: selection.selectedCandidateIds,
                            onClearSelection: selection.clearSelection,
                            provider: provider,
                            isMobile: isMobile,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

