import 'package:flutter/material.dart';

import 'package:jobnest/features/candidates/widgets/candidates_header.dart';
import 'package:jobnest/features/candidates/widgets/candidates_smart_search.dart';
import 'package:jobnest/features/candidates/widgets/candidates_filters.dart';
import 'package:jobnest/features/candidates/widgets/candidates_overview.dart';
import 'package:jobnest/features/candidates/widgets/candidate_list_card.dart';
import 'package:jobnest/features/candidates/widgets/candidates_pipeline.dart';
import 'package:jobnest/features/candidates/widgets/candidates_auto_screening.dart';
import 'package:jobnest/features/candidates/widgets/candidates_advanced_filters.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  // ===== BACKEND TODO =====
  // TODO: Future me selected candidate IDs backend se maintain honge.
  final bool _isLoading = false; 
  final bool _hasCandidates = true; 
  int _selectedCandidates = 0; 

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CandidatesAdvancedFilters(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            
            // Responsive Breakpoints
            final bool isMobile = screenWidth < 600;
            final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
            final bool isDesktop = screenWidth >= 1024;
            
            double contentMaxWidth = screenWidth;
            if (isDesktop) {
              contentMaxWidth = 1200.0;
            }

            final double horizontalPadding = isMobile ? 16.0 : (isTablet ? 24.0 : 32.0);
            
            // Calculate exact width available for grid
            double actualContentWidth = screenWidth > contentMaxWidth ? contentMaxWidth : screenWidth;
            final double availableGridWidth = actualContentWidth - (horizontalPadding * 2);

            return Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
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
                            // Ensure bottom padding is large enough so content scrolls ABOVE the floating action bar
                            bottom: _selectedCandidates > 0 
                                ? 140.0 + MediaQuery.of(context).padding.bottom 
                                : 32.0 + MediaQuery.of(context).padding.bottom,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CandidatesHeader(),
                              const SizedBox(height: 24),
                              const CandidatesSmartSearch(),
                              const SizedBox(height: 24),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(child: CandidatesFilters()),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    onPressed: _showAdvancedFilters,
                                    icon: const Icon(Icons.tune_rounded),
                                    style: IconButton.styleFrom(
                                      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),

                              const CandidatesPipeline(),
                              const SizedBox(height: 32),

                              const CandidatesOverview(),
                              const SizedBox(height: 32),
                              
                              const CandidatesAutoScreening(),
                              const SizedBox(height: 32),

                              GestureDetector(
                                onTap: () {
                                  // Dummy toggle for prototyping
                                  setState(() {
                                    _selectedCandidates = _selectedCandidates == 0 ? 2 : 0;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    "All Candidates",
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),
                              ),
                              
                              _isLoading
                                ? _buildSkeletonGrid(availableGridWidth, isMobile, isTablet, isDesktop)
                                : (!_hasCandidates
                                    ? _buildEmptyState(context)
                                    : _buildCandidateGrid(availableGridWidth, isMobile, isTablet, isDesktop)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Floating Bottom Action Bar
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  left: 0,
                  right: 0,
                  bottom: _selectedCandidates > 0 ? 0 : -120.0 - MediaQuery.of(context).padding.bottom,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _selectedCandidates > 0 ? 1.0 : 0.0,
                    child: _buildBulkActionBar(theme, isMobile),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBulkActionBar(ThemeData theme, bool isMobile) {
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
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "$_selectedCandidates Selected",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Bulk Shortlist API yaha connect hogi.
                    },
                    icon: const Icon(Icons.check_rounded, color: Colors.green),
                    label: const Text("Shortlist", style: TextStyle(color: Colors.green)),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Bulk Reject API yaha connect hogi.
                    },
                    icon: const Icon(Icons.close_rounded, color: Colors.red),
                    label: const Text("Reject", style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Bulk Message API future integration.
                    },
                    icon: const Icon(Icons.chat_bubble_outline_rounded),
                    label: const Text("Message"),
                  ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    tooltip: "More Actions",
                    onSelected: (value) {
                      // TODO: Bulk AI Actions future me add hongi.
                    },
                    itemBuilder: (context) => [
                      // Reserved for future actions: Move to Interview, Assign Recruiter, Send Email, Generate AI Summary, Export, Schedule Interview
                      const PopupMenuItem(
                        value: "more",
                        child: Text("More coming soon..."),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.more_horiz_rounded, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text("More", style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
              "Try adjusting your advanced filters or search terms.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Clear Filters"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid(double availableWidth, bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    double spacing = isMobile ? 16.0 : 24.0;
    
    // Ensure cardWidth never goes negative
    double cardWidth = (availableWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
    if (cardWidth < 0) cardWidth = 100;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(4, (index) {
        return SizedBox(
          width: cardWidth,
          child: const SkeletonLoaderCard(),
        );
      }),
    );
  }

  Widget _buildCandidateGrid(double availableWidth, bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    double spacing = isMobile ? 16.0 : 24.0;
    
    // Ensure cardWidth never goes negative
    double cardWidth = (availableWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
    if (cardWidth < 0) cardWidth = 100;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [
        SizedBox(
          width: cardWidth,
          child: const CandidateListCard(
            name: "Rahul Sharma",
            role: "Senior Flutter Developer",
            location: "Delhi, India",
            experience: "5 Years",
            skills: ["Flutter", "Dart", "Firebase", "BLoC"],
            matchPercentage: 94,
            score: 8.5,
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const CandidateListCard(
            name: "Priya Singh",
            role: "Python Backend Engineer",
            location: "Bangalore, India",
            experience: "4 Years",
            skills: ["Python", "Django", "PostgreSQL", "AWS"],
            matchPercentage: 88,
            score: 7.9,
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const CandidateListCard(
            name: "Amit Patel",
            role: "UI/UX Designer",
            location: "Mumbai, India",
            experience: "3 Years",
            skills: ["Figma", "Prototyping", "Wireframing"],
            matchPercentage: 82,
            score: 7.2,
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const CandidateListCard(
            name: "Sneha Reddy",
            role: "Frontend Developer",
            location: "Remote",
            experience: "2 Years",
            skills: ["React", "JavaScript", "HTML/CSS"],
            matchPercentage: 76,
            score: 6.8,
          ),
        ),
      ],
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 120, height: 16, color: skeletonColor),
                  const SizedBox(height: 8),
                  Container(width: 80, height: 12, color: skeletonColor),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(width: double.infinity, height: 12, color: skeletonColor),
          const SizedBox(height: 8),
          Container(width: 200, height: 12, color: skeletonColor),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(width: 60, height: 24, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(12))),
              const SizedBox(width: 8),
              Container(width: 60, height: 24, decoration: BoxDecoration(color: skeletonColor, borderRadius: BorderRadius.circular(12))),
            ],
          ),
        ],
      ),
    );
  }
}
