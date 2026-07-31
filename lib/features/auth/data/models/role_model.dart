import 'package:flutter/foundation.dart';
import 'permission_model.dart';

/// Represents a role assigned to a user, comprising multiple permissions.
@immutable
class RoleModel {
  final String id;
  final String name;
  final List<PermissionModel> permissions;

  const RoleModel({
    required this.id,
    required this.name,
    required this.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions.map((e) => e.toJson()).toList(),
    };
  }

  RoleModel copyWith({
    String? id,
    String? name,
    List<PermissionModel>? permissions,
  }) {
    return RoleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RoleModel &&
        other.id == id &&
        other.name == name &&
        listEquals(other.permissions, permissions);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ Object.hashAll(permissions);
}
