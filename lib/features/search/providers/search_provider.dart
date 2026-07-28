import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final List<String> _recentSearches = [];
  final List<String> _trendingSearches = [];

  static const List<String> _defaultRecentSearches = [
    'Senior Flutter Developer',
    'Product Designer',
    'NodeJS Backend',
  ];

  static const List<String> _defaultTrendingSearches = [
    'Remote Python Jobs',
    'Flutter Developer',
    'UI/UX Lead',
    'Bangalore Candidates',
    'TechCorp India',
    'AI Engineers',
  ];

  SearchProvider() {
    restoreDefault(notify: false);
  }

  List<String> get recentSearches => List.unmodifiable(_recentSearches);
  List<String> get trendingSearches => List.unmodifiable(_trendingSearches);

  void restoreDefault({bool notify = true}) {
    _recentSearches.clear();
    _recentSearches.addAll(_defaultRecentSearches);
    
    _trendingSearches.clear();
    _trendingSearches.addAll(_defaultTrendingSearches);
    
    if (notify) notifyListeners();
  }

  void addRecentSearch(String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;
    
    _recentSearches.removeWhere((item) => item.toLowerCase() == cleanQuery.toLowerCase());
    _recentSearches.insert(0, cleanQuery);
    if (_recentSearches.length > 5) {
      _recentSearches.removeLast();
    }
    notifyListeners();
  }

  void deleteRecentSearch(String query) {
    _recentSearches.removeWhere((item) => item.toLowerCase() == query.trim().toLowerCase());
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }
}
