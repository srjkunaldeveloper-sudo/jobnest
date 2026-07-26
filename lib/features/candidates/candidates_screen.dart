import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/features/candidates/widgets/candidates_header.dart';
import 'package:jobnest/features/candidates/widgets/candidates_smart_search.dart';
import 'package:jobnest/features/candidates/widgets/candidates_filters.dart';
import 'package:jobnest/features/candidates/widgets/candidates_overview.dart';
import 'package:jobnest/features/candidates/widgets/candidate_list_card.dart';
import 'package:jobnest/features/candidates/widgets/candidates_pipeline.dart';
import 'package:jobnest/features/candidates/widgets/candidates_auto_screening.dart';
import 'package:jobnest/features/candidates/widgets/candidates_advanced_filters.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';
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
  String _searchQuery = "";
  String _selectedFilter = "All";
  String _selectedSort = "Newest";
  String _pipelineActiveStage = "All";
  final Set<String> _selectedCandidateIds = {};
  bool _isMultiSelectMode = false;

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

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedCandidateIds.contains(id)) {
        _selectedCandidateIds.remove(id);
        if (_selectedCandidateIds.isEmpty) {
          _isMultiSelectMode = false;
        }
      } else {
        _selectedCandidateIds.add(id);
        _isMultiSelectMode = true;
      }
    });
  }

  void _selectAllVisible(List<CandidateModel> visibleCandidates) {
    setState(() {
      if (_selectedCandidateIds.length == visibleCandidates.length) {
        _selectedCandidateIds.clear();
        _isMultiSelectMode = false;
      } else {
        _selectedCandidateIds.addAll(visibleCandidates.map((c) => c.id));
        _isMultiSelectMode = true;
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedCandidateIds.clear();
      _isMultiSelectMode = false;
    });
  }

  void _showBulkMoveStageDialog(BuildContext context, RecruitmentDataProvider provider) {
    final theme = Theme.of(context);
    final stages = ["Applied", "Screening", "Interview", "Offer", "Hired", "Rejected"];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Move ${_selectedCandidateIds.length} Candidates", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: stages.map((stg) {
            return ListTile(
              leading: Icon(Icons.swap_horiz_rounded, color: theme.colorScheme.primary),
              title: Text("Move to $stg"),
              onTap: () {
                Navigator.pop(ctx);
                provider.bulkUpdateCandidateStage(_selectedCandidateIds.toList(), stg);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Moved ${_selectedCandidateIds.length} candidates to $stg stage.")),
                );
                _clearSelection();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  List<CandidateModel> _getFilteredAndSortedCandidates(List<CandidateModel> allCandidates) {
    var list = allCandidates.where((c) {
      // 1. Search filter
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
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
      if (_pipelineActiveStage != "All") {
        if (c.stage.toLowerCase() != _pipelineActiveStage.toLowerCase()) {
          return false;
        }
      }

      // 3. Chip Filter
      if (_selectedFilter != "All") {
        final f = _selectedFilter.toLowerCase();
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
      switch (_selectedSort) {
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
    final provider = context.watch<RecruitmentDataProvider>();
    final filteredCandidates = _getFilteredAndSortedCandidates(provider.candidates);
    
    return SafeArea(
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
                          child: AnimatedPadding(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            padding: EdgeInsets.only(
                              left: horizontalPadding,
                              right: horizontalPadding,
                              top: 24.0,
                              bottom: _selectedCandidateIds.isNotEmpty
                                  ? 160.0 + MediaQuery.of(context).padding.bottom 
                                  : 40.0 + MediaQuery.of(context).padding.bottom,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CandidatesHeader(),
                                const SizedBox(height: 20),

                                // QA Testing Toolbar (Simulation Panel) - Hidden in release/demo mode
                                if (kDebugMode) ...[
                                  _buildSimulationPanel(context, provider, theme),
                                  const SizedBox(height: 24),
                                ],

                                CandidatesSmartSearch(
                                  searchQuery: _searchQuery,
                                  onSearchChanged: (query) => setState(() => _searchQuery = query),
                                  onClearSearch: () => setState(() => _searchQuery = ""),
                                  onRecentSelected: (recent) => setState(() => _searchQuery = recent),
                                ),
                                const SizedBox(height: 20),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CandidatesFilters(
                                        selectedFilter: _selectedFilter,
                                        onFilterChanged: (filter) => setState(() => _selectedFilter = filter),
                                        selectedSort: _selectedSort,
                                        onSortChanged: (sort) => setState(() => _selectedSort = sort),
                                        onClearAll: () {
                                          setState(() {
                                            _selectedFilter = "All";
                                            _selectedSort = "Newest";
                                            _pipelineActiveStage = "All";
                                            _searchQuery = "";
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
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
                                ),
                                const SizedBox(height: 28),

                                CandidatesPipeline(
                                  activeStage: _pipelineActiveStage,
                                  onStageSelected: (stg) => setState(() => _pipelineActiveStage = stg),
                                ),
                                const SizedBox(height: 32),

                                const CandidatesOverview(),
                                const SizedBox(height: 32),
                                
                                const CandidatesAutoScreening(),
                                const SizedBox(height: 32),

                                // Candidate Grid Header
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    spacing: 16,
                                    runSpacing: 12,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "All Candidates (${filteredCandidates.length})",
                                            style: theme.textTheme.titleLarge?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.3,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          if (_isMultiSelectMode || _selectedCandidateIds.isNotEmpty)
                                            TextButton.icon(
                                              onPressed: () => _selectAllVisible(filteredCandidates),
                                              icon: Icon(
                                                _selectedCandidateIds.length == filteredCandidates.length && filteredCandidates.isNotEmpty
                                                    ? Icons.check_box_rounded
                                                    : Icons.select_all_rounded,
                                                size: 18,
                                              ),
                                              label: Text(
                                                _selectedCandidateIds.length == filteredCandidates.length && filteredCandidates.isNotEmpty
                                                    ? "Deselect All"
                                                    : "Select All Visible",
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                _isMultiSelectMode = !_isMultiSelectMode;
                                                if (!_isMultiSelectMode) {
                                                  _selectedCandidateIds.clear();
                                                }
                                              });
                                            },
                                            icon: Icon(_isMultiSelectMode ? Icons.checklist_rtl_rounded : Icons.checklist_rounded, size: 18),
                                            label: Text(_isMultiSelectMode ? "Exit Select" : "Multi Select"),
                                            style: TextButton.styleFrom(
                                              foregroundColor: _isMultiSelectMode ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          TextButton.icon(
                                            onPressed: () => _addDummyCandidate(context),
                                            icon: const Icon(Icons.person_add_rounded, size: 18),
                                            label: const Text("Add Candidate"),
                                            style: TextButton.styleFrom(
                                              foregroundColor: theme.colorScheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Skeleton / Error / Empty / Grid Views
                                if (provider.isCandidatesLoading)
                                  _buildSkeletonGrid(availableGridWidth, isMobile, isTablet, isDesktop)
                                else if (provider.isCandidatesError)
                                  _buildErrorState(context, provider)
                                else if (filteredCandidates.isEmpty)
                                  _buildEmptyState(context, provider)
                                else
                                  _buildCandidateGrid(provider, filteredCandidates, availableGridWidth, isMobile, isTablet, isDesktop),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Floating Bottom Action Bar (Section 4: MULTI SELECT & BULK ACTIONS)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  left: 0,
                  right: 0,
                  bottom: _selectedCandidateIds.isNotEmpty ? 0 : -140.0 - MediaQuery.of(context).padding.bottom,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _selectedCandidateIds.isNotEmpty ? 1.0 : 0.0,
                    child: _buildBulkActionBar(theme, isMobile, provider, filteredCandidates),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSimulationPanel(BuildContext context, RecruitmentDataProvider provider, ThemeData theme) {
    if (!kDebugMode) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(Icons.science_outlined, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              "QA State Test:",
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => provider.simulateCandidatesLoading(),
              icon: const Icon(Icons.hourglass_empty_rounded, size: 14),
              label: const Text("Loading Skeleton", style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => provider.simulateCandidatesError(),
              icon: const Icon(Icons.error_outline_rounded, size: 14),
              label: const Text("Error State", style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.5)),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => provider.simulateCandidatesEmpty(),
              icon: const Icon(Icons.inbox_rounded, size: 14),
              label: const Text("Empty State", style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => provider.restoreCandidatesDefault(),
              icon: const Icon(Icons.restore_rounded, size: 14),
              label: const Text("Restore Data", style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulkActionBar(ThemeData theme, bool isMobile, RecruitmentDataProvider provider, List<CandidateModel> visibleCandidates) {
    return Container(
      padding: EdgeInsets.only(
        left: isMobile ? 16 : 24, 
        right: isMobile ? 16 : 24, 
        top: 16, 
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${_selectedCandidateIds.length}",
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Selected for Bulk ATS Actions",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _clearSelection,
                icon: const Icon(Icons.close_rounded, size: 18),
                label: const Text("Clear"),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Scheduled batch interview invitations for ${_selectedCandidateIds.length} candidates.")),
                    );
                    _clearSelection();
                  },
                  icon: const Icon(Icons.calendar_month_outlined, size: 18),
                  label: const Text("Schedule Interview"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () => _showBulkMoveStageDialog(context, provider),
                  icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                  label: const Text("Move Stage"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Opening broadcast message composer for ${_selectedCandidateIds.length} candidates.")),
                    );
                    _clearSelection();
                  },
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                  label: const Text("Send Message"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Exported profile summaries of ${_selectedCandidateIds.length} candidates as PDF/CSV.")),
                    );
                    _clearSelection();
                  },
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: const Text("Export Profiles"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    final count = _selectedCandidateIds.length;
                    provider.bulkDeleteCandidates(_selectedCandidateIds.toList());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Archived $count candidate profiles.")),
                    );
                    _clearSelection();
                  },
                  icon: Icon(Icons.archive_outlined, size: 18, color: theme.colorScheme.error),
                  label: Text("Archive", style: TextStyle(color: theme.colorScheme.error)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.5)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, RecruitmentDataProvider provider) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            Icon(Icons.inbox_rounded, size: 80, color: theme.dividerColor),
            const SizedBox(height: 16),
            Text(
              "No candidates found.",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your advanced filters, pipeline stages, or search terms.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedFilter = "All";
                      _selectedSort = "Newest";
                      _pipelineActiveStage = "All";
                      _searchQuery = "";
                    });
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text("Clear Filters"),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _addDummyCandidate(context),
                  icon: const Icon(Icons.person_add_rounded, size: 18),
                  label: const Text("Add Dummy Candidate"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, RecruitmentDataProvider provider) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: AppErrorState(
        title: "Failed to load candidate profiles",
        message: "Please check your network connection and try again.",
        primaryButtonText: "Retry Loading",
        onRetry: () => provider.refreshCandidates(),
        secondaryButtonText: "Restore Profiles",
        onSecondaryAction: () => provider.restoreCandidatesDefault(),
        iconData: Icons.cloud_off_rounded,
      ),
    );
  }

  Widget _buildSkeletonGrid(double availableWidth, bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    double spacing = isMobile ? 16.0 : 24.0;
    
    double cardWidth = (availableWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
    if (cardWidth < 0) cardWidth = 100;

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

  Widget _buildCandidateGrid(
    RecruitmentDataProvider provider,
    List<CandidateModel> candidatesList,
    double availableWidth,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    double spacing = isMobile ? 16.0 : 24.0;
    
    double cardWidth = (availableWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
    if (cardWidth < 0) cardWidth = 100;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: candidatesList.map((cand) {
        final isSelected = _selectedCandidateIds.contains(cand.id);

        return SizedBox(
          width: cardWidth,
          child: Dismissible(
            key: ValueKey(cand.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              provider.deleteCandidate(cand.id);
              if (_selectedCandidateIds.contains(cand.id)) {
                _toggleSelection(cand.id);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Archived '${cand.name}'. Today's Focus updated!"),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.archive_outlined, color: Theme.of(context).colorScheme.error),
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
              isMultiSelectMode: _isMultiSelectMode || _selectedCandidateIds.isNotEmpty,
              isSelected: isSelected,
              onSelectChanged: () => _toggleSelection(cand.id),
              onBookmarkTap: () => provider.toggleBookmarkCandidate(cand.id),
              onStageChange: (newStage) {
                provider.updateCandidateStage(cand.id, newStage);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Moved '${cand.name}' to $newStage stage.")),
                );
              },
              onScheduleInterviewTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Scheduled interview with ${cand.name}. Calendar invite sent.")),
                );
              },
              onSendMessageTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Opening chat thread with ${cand.name}.")),
                );
              },
              onDeleteTap: () {
                provider.deleteCandidate(cand.id);
                if (isSelected) {
                  _toggleSelection(cand.id);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Archived '${cand.name}'.")),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}

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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 140, height: 16, color: skeletonColor),
                    const SizedBox(height: 8),
                    Container(width: 100, height: 12, color: skeletonColor),
                  ],
                ),
              ),
              Container(width: 70, height: 24, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(12))),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(width: 80, height: 12, color: skeletonColor),
              const SizedBox(width: 12),
              Container(width: 80, height: 12, color: skeletonColor),
              const SizedBox(width: 12),
              Container(width: 60, height: 12, color: skeletonColor),
            ],
          ),
          const SizedBox(height: 20),
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
              Container(width: 80, height: 26, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(16))),
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
                  Container(width: 80, height: 36, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(10))),
                  const SizedBox(width: 8),
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
