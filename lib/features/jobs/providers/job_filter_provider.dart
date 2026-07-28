import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';

class JobFilterProvider extends ChangeNotifier {
  List<JobModel> _allJobs = [];

  // Search, Filter & Sort State
  String _searchQuery = "";
  String _selectedFilter = "All";
  String _selectedSort = "Newest";

  static const List<String> defaultFilters = [
    "All",
    "Open",
    "Hiring",
    "Paused",
    "Closed",
    "Draft",
    "Remote",
    "Full Time",
    "Hybrid",
  ];

  static const List<String> defaultSortOptions = [
    "Newest",
    "Oldest",
    "Recently Updated",
    "Highest Salary",
    "Lowest Salary",
    "Most Applicants",
  ];

  // State Getters
  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;
  String get currentFilter => _selectedFilter; // Alias
  String get selectedSort => _selectedSort;
  String get currentSort => _selectedSort; // Alias
  List<String> get filters => defaultFilters;
  List<String> get sortOptions => defaultSortOptions;

  int get filterCount {
    int count = 0;
    if (_searchQuery.isNotEmpty) count++;
    if (_selectedFilter != "All") count++;
    if (_selectedSort != "Newest") count++;
    return count;
  }

  // Synchronized jobs update from JobProvider (No duplicated repository data)
  void updateJobs(List<JobModel> jobs) {
    _allJobs = jobs;
  }

  // Filter & Sort Mutators
  void setSearchQuery(String val) {
    if (_searchQuery != val) {
      _searchQuery = val;
      notifyListeners();
    }
  }

  void setSelectedFilter(String val) {
    if (_selectedFilter != val) {
      _selectedFilter = val;
      notifyListeners();
    }
  }

  void setSelectedSort(String val) {
    if (_selectedSort != val) {
      _selectedSort = val;
      notifyListeners();
    }
  }

  void clearFilters() {
    if (_searchQuery.isNotEmpty || _selectedFilter != "All" || _selectedSort != "Newest") {
      _searchQuery = "";
      _selectedFilter = "All";
      _selectedSort = "Newest";
      notifyListeners();
    }
  }

  void resetFilters() => clearFilters();

  // Salary Parsing Helper
  int _extractSalary(String salaryStr) {
    final reg = RegExp(r'\d+');
    final match = reg.firstMatch(salaryStr);
    return match != null ? int.tryParse(match.group(0) ?? '0') ?? 0 : 0;
  }

  // Filtered List Computation
  List<JobModel> get filteredJobs {
    List<JobModel> list = List.of(_allJobs);

    // 1. Instant Local Search Filter (Title, Company, Location, JobType, Skills)
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase().trim();
      list = list.where((j) {
        return j.title.toLowerCase().contains(q) ||
               j.company.toLowerCase().contains(q) ||
               j.location.toLowerCase().contains(q) ||
               j.jobType.toLowerCase().contains(q) ||
               j.skills.any((s) => s.toLowerCase().contains(q));
      }).toList();
    }

    // 2. Chip Filtering (Status or JobType)
    if (_selectedFilter != "All") {
      if (_selectedFilter == "Active" || _selectedFilter == "Open") {
        list = list.where((j) => j.status.toLowerCase() == "active" || j.status.toLowerCase() == "open").toList();
      } else if (["Hiring", "Paused", "Closed", "Draft"].contains(_selectedFilter)) {
        list = list.where((j) => j.status.toLowerCase() == _selectedFilter.toLowerCase()).toList();
      } else if (["Remote", "Hybrid", "Full Time", "Part Time", "Internship"].contains(_selectedFilter)) {
        list = list.where((j) => j.jobType.toLowerCase() == _selectedFilter.toLowerCase()).toList();
      }
    }

    // 3. Sorting
    switch (_selectedSort) {
      case "Newest":
        break;
      case "Oldest":
        list = list.reversed.toList();
        break;
      case "Recently Updated":
        list.sort((a, b) => b.aiMatchScore.compareTo(a.aiMatchScore));
        break;
      case "Highest Salary":
        list.sort((a, b) => _extractSalary(b.salary).compareTo(_extractSalary(a.salary)));
        break;
      case "Lowest Salary":
        list.sort((a, b) => _extractSalary(a.salary).compareTo(_extractSalary(b.salary)));
        break;
      case "Most Applicants":
        list.sort((a, b) {
          final countA = int.tryParse(a.applicationsCount.replaceAll(',', '')) ?? 0;
          final countB = int.tryParse(b.applicationsCount.replaceAll(',', '')) ?? 0;
          return countB.compareTo(countA);
        });
        break;
    }

    return list;
  }

  // Statistics Helpers for Overview Cards
  int get activeJobsCount => _allJobs.where((j) {
        final s = j.status.toLowerCase();
        return s == 'active' || s == 'open' || s == 'hiring';
      }).length;

  int get closedJobsCount => _allJobs.where((j) {
        final s = j.status.toLowerCase();
        return s == 'closed' || s == 'paused' || s == 'draft';
      }).length;

  int get totalApplications => _allJobs.fold<int>(
        0,
        (sum, j) => sum + (int.tryParse(j.applicationsCount.replaceAll(',', '')) ?? 0),
      );

  int get urgentJobsCount => _allJobs.where((j) => j.isUrgent).length;
}
