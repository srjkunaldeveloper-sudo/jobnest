import 'package:flutter/foundation.dart';
import 'package:jobnest/core/models/recruitment_models.dart';

class CandidateFilterProvider extends ChangeNotifier {
  static const String _allLabel = "All";
  static const String _defaultSort = "Newest";
  static const List<String> _pipelineStages = [
    "Applied",
    "Screening",
    "Interview",
    "Offer",
    "Hired",
    "Rejected",
  ];

  List<CandidateModel> _allCandidates = const [];
  List<CandidateModel> _filteredCandidates = const [];
  List<String> _activeFilters = const [];
  Map<String, int> _pipelineStageCounts = const {
    "Applied": 0,
    "Screening": 0,
    "Interview": 0,
    "Offer": 0,
    "Hired": 0,
    "Rejected": 0,
  };

  String _searchQuery = "";
  String _selectedFilter = _allLabel;
  String _selectedSort = _defaultSort;
  String _selectedPipelineStage = _allLabel;
  bool _bookmarkedOnly = false;
  int _filteredCandidateCount = 0;
  int _totalCandidateCount = 0;

  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;
  String get selectedSort => _selectedSort;
  String get pipelineActiveStage => _selectedPipelineStage;
  String get selectedPipelineStage => _selectedPipelineStage;
  bool get bookmarkedOnly => _bookmarkedOnly;
  bool get hasSearch => _searchQuery.trim().isNotEmpty;
  bool get hasFilters =>
      _selectedFilter != _allLabel ||
      _selectedPipelineStage != _allLabel ||
      _bookmarkedOnly;
  List<String> get activeFilters => List.unmodifiable(_activeFilters);
  List<CandidateModel> get filteredCandidates =>
      List.unmodifiable(_filteredCandidates);
  List<CandidateModel> get computedFilteredCandidates => filteredCandidates;
  int get filteredCount => _filteredCandidateCount;
  int get filteredCandidateCount => _filteredCandidateCount;
  int get totalCandidateCount => _totalCandidateCount;
  int get appliedCount => _pipelineStageCounts["Applied"] ?? 0;
  int get screeningCount => _pipelineStageCounts["Screening"] ?? 0;
  int get interviewCount => _pipelineStageCounts["Interview"] ?? 0;
  int get offerCount => _pipelineStageCounts["Offer"] ?? 0;
  int get hiredCount => _pipelineStageCounts["Hired"] ?? 0;
  int get rejectedCount => _pipelineStageCounts["Rejected"] ?? 0;

  void updateCandidates(List<CandidateModel> candidates) {
    if (_candidateListsEqual(_allCandidates, candidates)) {
      return;
    }

    _allCandidates = List<CandidateModel>.unmodifiable(candidates);
    _recomputeCaches();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) {
      return;
    }

    _searchQuery = query;
    _recomputeCaches(notifyForStateChange: true);
  }

  void setSelectedFilter(String filter) {
    if (_selectedFilter == filter) {
      return;
    }

    _selectedFilter = filter;
    _recomputeCaches(notifyForStateChange: true);
  }

  void setSelectedSort(String sort) {
    if (_selectedSort == sort) {
      return;
    }

    _selectedSort = sort;
    _recomputeCaches(notifyForStateChange: true);
  }

  void setPipelineActiveStage(String stage) {
    if (_selectedPipelineStage == stage) {
      return;
    }

    _selectedPipelineStage = stage;
    _recomputeCaches(notifyForStateChange: true);
  }

  void setBookmarkedOnly(bool value) {
    if (_bookmarkedOnly == value) {
      return;
    }

    _bookmarkedOnly = value;
    _recomputeCaches(notifyForStateChange: true);
  }

  void clearAll() {
    bool changed = false;

    if (_selectedFilter != _allLabel) {
      _selectedFilter = _allLabel;
      changed = true;
    }

    if (_selectedSort != _defaultSort) {
      _selectedSort = _defaultSort;
      changed = true;
    }

    if (_selectedPipelineStage != _allLabel) {
      _selectedPipelineStage = _allLabel;
      changed = true;
    }

    if (_bookmarkedOnly) {
      _bookmarkedOnly = false;
      changed = true;
    }

    if (_searchQuery.isNotEmpty) {
      _searchQuery = "";
      changed = true;
    }

    if (!changed) {
      return;
    }

    _recomputeCaches(notifyForStateChange: true);
  }

  void _recomputeCaches({bool notifyForStateChange = false}) {
    final List<CandidateModel> nextFilteredCandidates =
        _buildFilteredCandidates(_allCandidates);
    final Map<String, int> nextStageCounts = _buildStageCounts(_allCandidates);
    final List<String> nextActiveFilters = _buildActiveFilters();
    final int nextFilteredCount = nextFilteredCandidates.length;
    final int nextTotalCount = _allCandidates.length;

    final bool filteredChanged =
        !_candidateListsEqual(_filteredCandidates, nextFilteredCandidates);
    final bool stageCountsChanged =
        !_stageCountsEqual(_pipelineStageCounts, nextStageCounts);
    final bool activeFiltersChanged =
        !listEquals(_activeFilters, nextActiveFilters);
    final bool countChanged =
        _filteredCandidateCount != nextFilteredCount ||
        _totalCandidateCount != nextTotalCount;

    _filteredCandidates =
        List<CandidateModel>.unmodifiable(nextFilteredCandidates);
    _pipelineStageCounts = Map<String, int>.unmodifiable(nextStageCounts);
    _activeFilters = List<String>.unmodifiable(nextActiveFilters);
    _filteredCandidateCount = nextFilteredCount;
    _totalCandidateCount = nextTotalCount;

    if (notifyForStateChange ||
        filteredChanged ||
        stageCountsChanged ||
        activeFiltersChanged ||
        countChanged) {
      notifyListeners();
    }
  }

  List<CandidateModel> _buildFilteredCandidates(List<CandidateModel> candidates) {
    final List<CandidateModel> filtered = candidates.where((candidate) {
      if (!_matchesSearch(candidate)) {
        return false;
      }

      if (!_matchesPipelineStage(candidate)) {
        return false;
      }

      if (!_matchesSelectedFilter(candidate)) {
        return false;
      }

      if (_bookmarkedOnly && !candidate.isBookmarked) {
        return false;
      }

      return true;
    }).toList();

    filtered.sort((a, b) {
      switch (_selectedSort) {
        case "Oldest":
          return a.id.compareTo(b.id);
        case "Highest Experience":
          final int expA = _extractExperienceValue(a.experience);
          final int expB = _extractExperienceValue(b.experience);
          return expB.compareTo(expA);
        case "Lowest Experience":
          final int expA = _extractExperienceValue(a.experience);
          final int expB = _extractExperienceValue(b.experience);
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

    return filtered;
  }

  bool _matchesSearch(CandidateModel candidate) {
    if (_searchQuery.isEmpty) {
      return true;
    }

    final String query = _searchQuery.toLowerCase();
    final bool nameMatch = candidate.name.toLowerCase().contains(query);
    final bool roleMatch = candidate.role.toLowerCase().contains(query);
    final bool locationMatch = candidate.location.toLowerCase().contains(query);
    final bool companyMatch = candidate.company.toLowerCase().contains(query);
    final bool experienceMatch =
        candidate.experience.toLowerCase().contains(query);
    final bool skillMatch = candidate.skills.any(
      (skill) => skill.toLowerCase().contains(query),
    );

    return nameMatch ||
        roleMatch ||
        locationMatch ||
        companyMatch ||
        experienceMatch ||
        skillMatch;
  }

  bool _matchesPipelineStage(CandidateModel candidate) {
    if (_selectedPipelineStage == _allLabel) {
      return true;
    }

    return candidate.stage.toLowerCase() ==
        _selectedPipelineStage.toLowerCase();
  }

  bool _matchesSelectedFilter(CandidateModel candidate) {
    if (_selectedFilter == _allLabel) {
      return true;
    }

    final String filter = _selectedFilter.toLowerCase();

    if (filter == "shortlisted" ||
        filter == "interview" ||
        filter == "offer" ||
        filter == "hired" ||
        filter == "applied" ||
        filter == "screening" ||
        filter == "rejected") {
      return candidate.stage.toLowerCase() == filter;
    }

    if (filter == "remote") {
      return candidate.location.toLowerCase().contains("remote");
    }

    if (filter.contains("years") || filter.contains("year")) {
      return candidate.experience.toLowerCase().contains(filter.split(' ')[0]);
    }

    if (filter.contains("bangalore") ||
        filter.contains("delhi") ||
        filter.contains("mumbai")) {
      return candidate.location.toLowerCase().contains(filter);
    }

    if (filter.contains("lpa")) {
      return candidate.expectedSalary.toLowerCase().contains(filter.split(' ')[0]);
    }

    return true;
  }

  List<String> _buildActiveFilters() {
    final List<String> filters = <String>[];

    if (_selectedFilter != _allLabel) {
      filters.add(_selectedFilter);
    }

    if (_selectedPipelineStage != _allLabel) {
      filters.add('Stage: $_selectedPipelineStage');
    }

    if (_bookmarkedOnly) {
      filters.add('Bookmarked');
    }

    return filters;
  }

  Map<String, int> _buildStageCounts(List<CandidateModel> candidates) {
    final Map<String, int> counts = <String, int>{
      for (final String stage in _pipelineStages) stage: 0,
    };

    for (final CandidateModel candidate in candidates) {
      for (final String stage in _pipelineStages) {
        if (candidate.stage.toLowerCase() == stage.toLowerCase()) {
          counts[stage] = (counts[stage] ?? 0) + 1;
          break;
        }
      }
    }

    return counts;
  }

  int _extractExperienceValue(String experience) {
    return int.tryParse(experience.split(' ')[0]) ?? 0;
  }

  bool _stageCountsEqual(
    Map<String, int> previous,
    Map<String, int> next,
  ) {
    for (final String stage in _pipelineStages) {
      if ((previous[stage] ?? 0) != (next[stage] ?? 0)) {
        return false;
      }
    }

    return true;
  }

  bool _candidateListsEqual(
    List<CandidateModel> previous,
    List<CandidateModel> next,
  ) {
    if (identical(previous, next)) {
      return true;
    }

    if (previous.length != next.length) {
      return false;
    }

    for (int index = 0; index < previous.length; index++) {
      if (!_candidateEquals(previous[index], next[index])) {
        return false;
      }
    }

    return true;
  }

  bool _candidateEquals(CandidateModel previous, CandidateModel next) {
    return previous.id == next.id &&
        previous.name == next.name &&
        previous.role == next.role &&
        previous.location == next.location &&
        previous.experience == next.experience &&
        listEquals(previous.skills, next.skills) &&
        previous.matchPercentage == next.matchPercentage &&
        previous.score == next.score &&
        previous.isNew == next.isNew &&
        previous.expectedSalary == next.expectedSalary &&
        previous.appliedDate == next.appliedDate &&
        previous.stage == next.stage &&
        previous.rating == next.rating &&
        previous.company == next.company &&
        previous.about == next.about &&
        previous.resumeSummary == next.resumeSummary &&
        listEquals(previous.education, next.education) &&
        listEquals(previous.notes, next.notes) &&
        listEquals(previous.interviewTimeline, next.interviewTimeline) &&
        listEquals(previous.activityHistory, next.activityHistory) &&
        previous.isBookmarked == next.isBookmarked &&
        previous.avatarUrl == next.avatarUrl;
  }
}
