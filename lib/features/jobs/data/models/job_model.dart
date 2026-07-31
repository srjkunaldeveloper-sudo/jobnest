import 'package:flutter/foundation.dart';

/// Represents a job posting within the ATS.
@immutable
class JobModel {
  final String id;
  final String title;
  final String department;
  final String location;
  final String employmentType;
  final String status;
  final double salary;
  final int openPositions;
  final int applicationsCount;
  final DateTime postedDate;
  final DateTime? closingDate;
  final bool isRemote;

  const JobModel({
    required this.id,
    required this.title,
    required this.department,
    required this.location,
    required this.employmentType,
    required this.status,
    required this.salary,
    required this.openPositions,
    required this.applicationsCount,
    required this.postedDate,
    this.closingDate,
    this.isRemote = false,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      title: json['title'] as String,
      department: json['department'] as String,
      location: json['location'] as String,
      employmentType: json['employmentType'] as String,
      status: json['status'] as String,
      salary: (json['salary'] as num).toDouble(),
      openPositions: json['openPositions'] as int,
      applicationsCount: json['applicationsCount'] as int,
      postedDate: DateTime.parse(json['postedDate'] as String),
      closingDate: json['closingDate'] != null
          ? DateTime.parse(json['closingDate'] as String)
          : null,
      isRemote: json['isRemote'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'department': department,
      'location': location,
      'employmentType': employmentType,
      'status': status,
      'salary': salary,
      'openPositions': openPositions,
      'applicationsCount': applicationsCount,
      'postedDate': postedDate.toIso8601String(),
      'closingDate': closingDate?.toIso8601String(),
      'isRemote': isRemote,
    };
  }

  JobModel copyWith({
    String? id,
    String? title,
    String? department,
    String? location,
    String? employmentType,
    String? status,
    double? salary,
    int? openPositions,
    int? applicationsCount,
    DateTime? postedDate,
    DateTime? closingDate,
    bool? isRemote,
    bool clearClosingDate = false,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      department: department ?? this.department,
      location: location ?? this.location,
      employmentType: employmentType ?? this.employmentType,
      status: status ?? this.status,
      salary: salary ?? this.salary,
      openPositions: openPositions ?? this.openPositions,
      applicationsCount: applicationsCount ?? this.applicationsCount,
      postedDate: postedDate ?? this.postedDate,
      closingDate: clearClosingDate ? null : (closingDate ?? this.closingDate),
      isRemote: isRemote ?? this.isRemote,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JobModel &&
        other.id == id &&
        other.title == title &&
        other.department == department &&
        other.location == location &&
        other.employmentType == employmentType &&
        other.status == status &&
        other.salary == salary &&
        other.openPositions == openPositions &&
        other.applicationsCount == applicationsCount &&
        other.postedDate == postedDate &&
        other.closingDate == closingDate &&
        other.isRemote == isRemote;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        department.hashCode ^
        location.hashCode ^
        employmentType.hashCode ^
        status.hashCode ^
        salary.hashCode ^
        openPositions.hashCode ^
        applicationsCount.hashCode ^
        postedDate.hashCode ^
        closingDate.hashCode ^
        isRemote.hashCode;
  }

  @override
  String toString() {
    return 'JobModel(id: $id, title: $title, department: $department, location: $location, employmentType: $employmentType, status: $status, salary: $salary, openPositions: $openPositions, applicationsCount: $applicationsCount, postedDate: $postedDate, closingDate: $closingDate, isRemote: $isRemote)';
  }
}
