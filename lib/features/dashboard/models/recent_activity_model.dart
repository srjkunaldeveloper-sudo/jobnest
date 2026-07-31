import 'package:flutter/foundation.dart';

@immutable
class RecentActivityModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String type;

  const RecentActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.type,
  });

  factory RecentActivityModel.fromJson(Map<String, dynamic> json) {
    return RecentActivityModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'type': type,
    };
  }

  RecentActivityModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    String? type,
  }) {
    return RecentActivityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecentActivityModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ createdAt.hashCode ^ type.hashCode;
  }
}
