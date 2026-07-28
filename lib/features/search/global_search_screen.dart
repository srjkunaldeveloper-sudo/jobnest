import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/job_details_screen.dart';
import 'package:jobnest/features/candidates/candidate_profile_screen.dart';
import 'package:jobnest/features/search/providers/search_provider.dart';
import 'package:jobnest/features/companies/providers/company_provider.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';
import 'package:jobnest/features/candidates/providers/candidate_provider.dart';

class GlobalSearchScreen extends StatefulWidget {
  final String? initialQuery;

  const GlobalSearchScreen({super.key, this.initialQuery});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _query = '';
  int _selectedFilterIndex = 0; // 0: All, 1: Jobs, 2: Candidates, 3: Companies

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery ?? '';
    _searchController = TextEditingController(text: _query);
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    setState(() {
      _query = val.trim();
    });
  }

  void _submitSearch(String term) {
    final clean = term.trim();
    if (clean.isEmpty) return;
    
    _searchController.text = clean;
    setState(() {
      _query = clean;
    });
    
    // Save to local recent searches in single source of truth
    context.read<SearchProvider>().addRecentSearch(clean);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final jobProvider = context.watch<JobProvider>();
    final candidateProvider = context.watch<CandidateProvider>();
    final searchProvider = context.watch<SearchProvider>();
    final companyProvider = context.watch<CompanyProvider>();

    // Live Search filtering
    final lowerQuery = _query.toLowerCase();
    final matchingJobs = lowerQuery.isEmpty
        ? <JobModel>[]
        : jobProvider.jobs.where((j) =>
            j.title.toLowerCase().contains(lowerQuery) ||
            j.company.toLowerCase().contains(lowerQuery) ||
            j.location.toLowerCase().contains(lowerQuery) ||
            j.skillsOrTags().contains(lowerQuery)).toList();

    final matchingCandidates = lowerQuery.isEmpty
        ? <CandidateModel>[]
        : candidateProvider.candidates.where((c) =>
            c.name.toLowerCase().contains(lowerQuery) ||
            c.role.toLowerCase().contains(lowerQuery) ||
            c.location.toLowerCase().contains(lowerQuery) ||
            c.skills.any((s) => s.toLowerCase().contains(lowerQuery))).toList();

    final matchingCompanies = lowerQuery.isEmpty
        ? <CompanyModel>[]
        : companyProvider.companies.where((comp) =>
            comp.name.toLowerCase().contains(lowerQuery) ||
            comp.industry.toLowerCase().contains(lowerQuery) ||
            comp.location.toLowerCase().contains(lowerQuery)).toList();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header with auto-focus search bar
            _buildSearchHeader(theme),
            
            // Filter Chips if actively searching
            if (_query.isNotEmpty) _buildFilterChips(theme, matchingJobs.length, matchingCandidates.length, matchingCompanies.length),
            
            // Body: Suggestions or Live Results
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _query.isEmpty
                    ? _buildSuggestionsView(theme, searchProvider, jobProvider, candidateProvider, companyProvider)
                    : _buildLiveResultsView(theme, matchingJobs, matchingCandidates, matchingCompanies),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
            splashRadius: 24,
          ),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: widget.initialQuery == null || widget.initialQuery!.isEmpty,
                onChanged: _onSearchChanged,
                onSubmitted: _submitSearch,
                textInputAction: TextInputAction.search,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Search jobs, candidates or companies",
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  prefixIcon: Icon(Icons.search_rounded, color: theme.colorScheme.primary, size: 22),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(ThemeData theme, int jobsCount, int candCount, int compCount) {
    final int totalCount = jobsCount + candCount + compCount;
    final List<String> filters = [
      "All ($totalCount)",
      "Jobs ($jobsCount)",
      "Candidates ($candCount)",
      "Companies ($compCount)",
    ];

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return FilterChip(
            label: Text(filters[index]),
            selected: isSelected,
            onSelected: (val) {
              setState(() => _selectedFilterIndex = index);
            },
            selectedColor: theme.colorScheme.primaryContainer,
            labelStyle: theme.textTheme.labelMedium?.copyWith(
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestionsView(ThemeData theme, SearchProvider searchProvider, JobProvider jobProvider, CandidateProvider candidateProvider, CompanyProvider companyProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches (Maximum 5, Delete single, Clear all)
          if (searchProvider.recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Searches",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => searchProvider.clearRecentSearches(),
                  child: Text("Clear all", style: TextStyle(color: theme.colorScheme.primary, fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: searchProvider.recentSearches.map((term) {
                return InputChip(
                  label: Text(term),
                  avatar: const Icon(Icons.history_rounded, size: 16),
                  deleteIcon: const Icon(Icons.close_rounded, size: 16),
                  onDeleted: () => searchProvider.deleteRecentSearch(term),
                  onPressed: () => _submitSearch(term),
                  backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Trending Searches
          Text(
            "Trending Searches",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: searchProvider.trendingSearches.map((term) {
              return ActionChip(
                label: Text(term),
                avatar: const Icon(Icons.trending_up_rounded, size: 16, color: Colors.amber),
                onPressed: () => _submitSearch(term),
                backgroundColor: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: theme.dividerColor),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),

          // Suggested Jobs
          _buildSectionHeader(theme, "Suggested Jobs", Icons.work_outline_rounded),
          const SizedBox(height: 12),
          ...jobProvider.jobs.take(3).map((job) => _buildSuggestedJobCard(theme, job)),
          const SizedBox(height: 24),

          // Suggested Candidates
          _buildSectionHeader(theme, "Suggested Candidates", Icons.people_outline_rounded),
          const SizedBox(height: 12),
          ...candidateProvider.candidates.take(3).map((cand) => _buildSuggestedCandidateCard(theme, cand)),
          const SizedBox(height: 24),

          // Suggested Companies
          _buildSectionHeader(theme, "Suggested Companies", Icons.business_rounded),
          const SizedBox(height: 12),
          ...companyProvider.companies.take(3).map((comp) => _buildSuggestedCompanyCard(theme, comp)),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildLiveResultsView(ThemeData theme, List<JobModel> jobs, List<CandidateModel> candidates, List<CompanyModel> companies) {
    final bool showJobs = _selectedFilterIndex == 0 || _selectedFilterIndex == 1;
    final bool showCandidates = _selectedFilterIndex == 0 || _selectedFilterIndex == 2;
    final bool showCompanies = _selectedFilterIndex == 0 || _selectedFilterIndex == 3;

    final int totalMatches = (showJobs ? jobs.length : 0) + (showCandidates ? candidates.length : 0) + (showCompanies ? companies.length : 0);

    if (totalMatches == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off_rounded, size: 64, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
              const SizedBox(height: 16),
              Text(
                "No results found for '$_query'",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Try checking for spelling errors or use broader search terms.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        if (showJobs && jobs.isNotEmpty) ...[
          _buildSectionHeader(theme, "Jobs (${jobs.length})", Icons.work_rounded),
          const SizedBox(height: 12),
          ...jobs.map((j) => _buildSuggestedJobCard(theme, j)),
          const SizedBox(height: 20),
        ],
        if (showCandidates && candidates.isNotEmpty) ...[
          _buildSectionHeader(theme, "Candidates (${candidates.length})", Icons.person_rounded),
          const SizedBox(height: 12),
          ...candidates.map((c) => _buildSuggestedCandidateCard(theme, c)),
          const SizedBox(height: 20),
        ],
        if (showCompanies && companies.isNotEmpty) ...[
          _buildSectionHeader(theme, "Companies (${companies.length})", Icons.business_rounded),
          const SizedBox(height: 12),
          ...companies.map((comp) => _buildSuggestedCompanyCard(theme, comp)),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildSuggestedJobCard(ThemeData theme, JobModel job) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _submitSearch(job.title);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobDetailsScreen(
                  title: job.title,
                  company: job.company,
                  location: job.location,
                  salary: job.salary,
                  jobType: job.jobType,
                  status: job.status,
                ),
              ),
            );
          },
          child: AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.work_rounded, color: theme.colorScheme.primary, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("${job.company} • ${job.location}", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("${job.aiMatchScore}% Match", style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSecondaryContainer, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedCandidateCard(ThemeData theme, CandidateModel cand) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _submitSearch(cand.name);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CandidateProfileScreen(
                  name: cand.name,
                  role: cand.role,
                  location: cand.location,
                  experience: cand.experience,
                ),
              ),
            );
          },
          child: AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(cand.name.substring(0, 1), style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cand.name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("${cand.role} • ${cand.experience}", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedCompanyCard(ThemeData theme, CompanyModel comp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _submitSearch(comp.name);
          },
          child: AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.apartment_rounded, color: Colors.blueGrey, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comp.name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("${comp.industry} • ${comp.location}", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("${comp.openPositions} Jobs", style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on JobModel {
  String skillsOrTags() => "$jobType $salary";
}
