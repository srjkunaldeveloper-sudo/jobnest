import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show IconData;

/// Represents a single navigation item in a bottom navigation bar or drawer.
@immutable
class NavigationItem {
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final String route;
  final bool enabled;
  final int? badgeCount;

  const NavigationItem({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    required this.route,
    this.enabled = true,
    this.badgeCount,
  });

  /// Creates a copy of this object with the given fields replaced with new values.
  NavigationItem copyWith({
    String? title,
    IconData? icon,
    IconData? selectedIcon,
    String? route,
    bool? enabled,
    int? badgeCount,
    bool clearBadgeCount = false,
  }) {
    return NavigationItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      route: route ?? this.route,
      enabled: enabled ?? this.enabled,
      badgeCount: clearBadgeCount ? null : (badgeCount ?? this.badgeCount),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NavigationItem &&
        other.title == title &&
        other.icon == icon &&
        other.selectedIcon == selectedIcon &&
        other.route == route &&
        other.enabled == enabled &&
        other.badgeCount == badgeCount;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        icon.hashCode ^
        selectedIcon.hashCode ^
        route.hashCode ^
        enabled.hashCode ^
        badgeCount.hashCode;
  }
}
