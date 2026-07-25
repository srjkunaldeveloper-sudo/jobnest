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
  // TODO: Loading state, error state, and data will be fetched here.
  final bool _isLoading = false; // Set to true to see Skeletons
  final bool _hasCandidates = true; // Set to false to see Empty State
  
  // Dummy selection state for Bulk Actions
  final bool _isSelectionMode = true; // Forced true for prototyping

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
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CandidatesHeader(),
              const CandidatesSmartSearch(),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: CandidatesFilters()),
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

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "All Candidates",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              
              if (_isLoading)
                _buildSkeletonGrid()
              else if (!_hasCandidates)
                _buildEmptyState(context)
              else
                _buildCandidateGrid(),
                
              const SizedBox(height: 120), // Extra padding for bottom bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isSelectionMode ? _buildBulkActionBar(theme) : null,
    );
  }

  Widget _buildBulkActionBar(ThemeData theme) {
    // ===== BACKEND TODO =====
    // TODO: Bulk Actions API connect hongi.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
      child: SafeArea(
        child: Row(
          children: [
            Text(
              "2 Selected",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_rounded, color: Colors.green),
              label: const Text("Shortlist", style: TextStyle(color: Colors.green)),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.close_rounded, color: Colors.red),
              label: const Text("Reject", style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              label: const Text("Message"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
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

  Widget _buildSkeletonGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth;
        if (constraints.maxWidth > 1000) {
          cardWidth = (constraints.maxWidth - 32) / 3;
        } else if (constraints.maxWidth > 650) {
          cardWidth = (constraints.maxWidth - 16) / 2;
        } else {
          cardWidth = constraints.maxWidth;
        }

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(4, (index) {
            return SizedBox(
              width: cardWidth,
              child: const SkeletonLoaderCard(),
            );
          }),
        );
      },
    );
  }

  Widget _buildCandidateGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth;
        if (constraints.maxWidth > 1000) {
          cardWidth = (constraints.maxWidth - 32) / 3;
        } else if (constraints.maxWidth > 650) {
          cardWidth = (constraints.maxWidth - 16) / 2;
        } else {
          cardWidth = constraints.maxWidth;
        }

        return Wrap(
          spacing: 16,
          runSpacing: 16,
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
      },
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
