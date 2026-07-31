import 'package:flutter/foundation.dart';
import '../models/navigation_item.dart';

/// Provider responsible for managing the state of the main navigation system.
class NavigationProvider extends ChangeNotifier {
  final List<NavigationItem> _items;
  int _currentIndex = 0;

  NavigationProvider({
    required List<NavigationItem> items,
  }) : _items = items {
    assert(_items.isNotEmpty, 'Navigation items cannot be empty');
  }

  /// Exposes the list of navigation items.
  List<NavigationItem> get items => _items;

  /// Exposes the currently selected index.
  int get currentIndex => _currentIndex;

  /// Exposes the currently selected [NavigationItem].
  NavigationItem get selectedItem => _items[_currentIndex];

  /// Changes the active tab based on the provided [index].
  void changeTab(int index) {
    if (index < 0 || index >= _items.length) {
      return; // Ignore invalid indexes
    }
    
    if (index == _currentIndex) {
      return; // Avoid unnecessary notifications
    }
    
    if (!_items[index].enabled) {
      return; // Ignore disabled tabs
    }

    _currentIndex = index;
    notifyListeners();
  }

  /// Attempts to change the active tab based on a given [route].
  void jumpToRoute(String route) {
    final targetIndex = _items.indexWhere((item) => item.route == route);
    
    if (targetIndex != -1) {
      changeTab(targetIndex);
    }
  }

  /// Resets the navigation state to the first enabled tab.
  void reset() {
    int defaultIndex = 0;
    
    // Find the first enabled index to reset to, or default to 0
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].enabled) {
        defaultIndex = i;
        break;
      }
    }

    changeTab(defaultIndex);
  }
}
