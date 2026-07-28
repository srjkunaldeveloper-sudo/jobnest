import 'package:flutter/material.dart';

class CandidateFilterProvider extends ChangeNotifier {
  String _searchQuery = "";
  String _selectedFilter = "All";
  String _selectedSort = "Newest";
  String _pipelineActiveStage = "All";

  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;
  String get selectedSort => _selectedSort;
  String get pipelineActiveStage => _pipelineActiveStage;

  void setSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      notifyListeners();
    }
  }

  void setSelectedFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      notifyListeners();
    }
  }

  void setSelectedSort(String sort) {
    if (_selectedSort != sort) {
      _selectedSort = sort;
      notifyListeners();
    }
  }

  void setPipelineActiveStage(String stage) {
    if (_pipelineActiveStage != stage) {
      _pipelineActiveStage = stage;
      notifyListeners();
    }
  }

  void clearAll() {
    bool changed = false;
    if (_selectedFilter != "All") {
      _selectedFilter = "All";
      changed = true;
    }
    if (_selectedSort != "Newest") {
      _selectedSort = "Newest";
      changed = true;
    }
    if (_pipelineActiveStage != "All") {
      _pipelineActiveStage = "All";
      changed = true;
    }
    if (_searchQuery.isNotEmpty) {
      _searchQuery = "";
      changed = true;
    }
    if (changed) {
      notifyListeners();
    }
  }
}
