import 'package:flutter/material.dart';

class ServiceItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> categories;
  final List<String> benefits;
  final bool isAvailable;
  final bool isNew;
  final bool isFeatured;
  final bool isRecent;
  final String? lastUsedTime;
  final bool isFavorite;
  final Widget? screen;

  const ServiceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.categories,
    required this.benefits,
    this.isAvailable = true,
    this.isNew = false,
    this.isFeatured = false,
    this.isRecent = false,
    this.lastUsedTime,
    this.isFavorite = false,
    this.screen,
  });

  ServiceItem copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    Color? color,
    List<String>? categories,
    List<String>? benefits,
    bool? isAvailable,
    bool? isNew,
    bool? isFeatured,
    bool? isRecent,
    String? lastUsedTime,
    bool? isFavorite,
    Widget? screen,
  }) {
    return ServiceItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      categories: categories ?? this.categories,
      benefits: benefits ?? this.benefits,
      isAvailable: isAvailable ?? this.isAvailable,
      isNew: isNew ?? this.isNew,
      isFeatured: isFeatured ?? this.isFeatured,
      isRecent: isRecent ?? this.isRecent,
      lastUsedTime: lastUsedTime ?? this.lastUsedTime,
      isFavorite: isFavorite ?? this.isFavorite,
      screen: screen ?? this.screen,
    );
  }
}
