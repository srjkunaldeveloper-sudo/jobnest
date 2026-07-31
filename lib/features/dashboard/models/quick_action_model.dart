import '../../../core/constants/app_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show IconData, Icons;

@immutable
class QuickActionModel {
  final String id;
  final String title;
  final IconData icon;
  final String route;
  final bool enabled;

  const QuickActionModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    required this.enabled,
  });

  factory QuickActionModel.fromJson(Map<String, dynamic> json) {
    return QuickActionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: IconData(json['icon'] as int? ?? AppIcons.widgets.codePoint, fontFamily: 'MaterialIcons'),
      route: json['route'] as String,
      enabled: json['enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon.codePoint,
      'route': route,
      'enabled': enabled,
    };
  }

  QuickActionModel copyWith({
    String? id,
    String? title,
    IconData? icon,
    String? route,
    bool? enabled,
  }) {
    return QuickActionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuickActionModel &&
        other.id == id &&
        other.title == title &&
        other.icon == icon &&
        other.route == route &&
        other.enabled == enabled;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ icon.hashCode ^ route.hashCode ^ enabled.hashCode;
  }
}
