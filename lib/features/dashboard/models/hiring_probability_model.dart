import 'package:flutter/material.dart';

class DepartmentProbabilityItem {
  final String name;
  final double score;
  final String displayValue;
  final String colorName;

  const DepartmentProbabilityItem({
    required this.name,
    required this.score,
    required this.displayValue,
    required this.colorName,
  });

  Color get color {
    switch (colorName.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orangeAccent;
      case 'blue':
        return Colors.blueAccent;
      case 'purple':
        return Colors.purpleAccent;
      default:
        return Colors.green;
    }
  }
}

class HiringProbabilityModel {
  final double overallProbability;
  final List<DepartmentProbabilityItem> departmentBreakdown;
  final String lastUpdated;
  final String confidence;
  final String insightText;

  const HiringProbabilityModel({
    required this.overallProbability,
    required this.departmentBreakdown,
    required this.lastUpdated,
    required this.confidence,
    required this.insightText,
  });

  String get overallPercentage => "${(overallProbability * 100).round()}%";

  static HiringProbabilityModel getDefault() {
    return const HiringProbabilityModel(
      overallProbability: 0.82,
      departmentBreakdown: [
        DepartmentProbabilityItem(
          name: "Candidate Fit Score",
          score: 0.75,
          displayValue: "75%",
          colorName: "green",
        ),
        DepartmentProbabilityItem(
          name: "Average Time To Hire",
          score: 0.60,
          displayValue: "12 Days",
          colorName: "orange",
        ),
      ],
      lastUpdated: "Updated 2 hours ago",
      confidence: "Based on recent candidate pipelines",
      insightText: "Your hiring success has increased by 8% this week.",
    );
  }
}
