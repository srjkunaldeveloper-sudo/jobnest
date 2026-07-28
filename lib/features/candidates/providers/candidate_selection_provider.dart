import 'package:flutter/material.dart';

class CandidateSelectionProvider extends ChangeNotifier {
  final Set<String> _selectedCandidateIds = {};

  Set<String> get selectedCandidateIds => Set.unmodifiable(_selectedCandidateIds);

  bool get isMultiSelectMode => _selectedCandidateIds.isNotEmpty;

  void toggleSelection(String id) {
    if (_selectedCandidateIds.contains(id)) {
      _selectedCandidateIds.remove(id);
    } else {
      _selectedCandidateIds.add(id);
    }
    notifyListeners();
  }

  void selectAll(Iterable<String> ids) {
    final idList = ids.toList();
    if (_selectedCandidateIds.length == idList.length &&
        idList.every(_selectedCandidateIds.contains)) {
      _selectedCandidateIds.clear();
    } else {
      _selectedCandidateIds.clear();
      _selectedCandidateIds.addAll(idList);
    }
    notifyListeners();
  }

  void clearSelection() {
    if (_selectedCandidateIds.isNotEmpty) {
      _selectedCandidateIds.clear();
      notifyListeners();
    }
  }
}
