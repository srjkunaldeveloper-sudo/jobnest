import 'package:flutter/foundation.dart';

/// Represents a specific permission granted to a role.
@immutable
class PermissionModel {
  final String id;
  final String action;
  final String resource;

  const PermissionModel({
    required this.id,
    required this.action,
    required this.resource,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'] as String,
      action: json['action'] as String,
      resource: json['resource'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'action': action,
      'resource': resource,
    };
  }

  PermissionModel copyWith({
    String? id,
    String? action,
    String? resource,
  }) {
    return PermissionModel(
      id: id ?? this.id,
      action: action ?? this.action,
      resource: resource ?? this.resource,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PermissionModel &&
        other.id == id &&
        other.action == action &&
        other.resource == resource;
  }

  @override
  int get hashCode => id.hashCode ^ action.hashCode ^ resource.hashCode;
}
