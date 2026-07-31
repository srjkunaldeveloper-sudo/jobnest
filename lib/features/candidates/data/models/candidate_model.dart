import 'package:flutter/foundation.dart';

/// Represents a candidate profile in the ATS.
@immutable
class CandidateModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String jobTitle;
  final String department;
  final String experience;
  final String location;
  final String status;
  final String? resumeUrl;
  final String? avatarUrl;
  final List<String> skills;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CandidateModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.jobTitle,
    required this.department,
    required this.experience,
    required this.location,
    required this.status,
    this.resumeUrl,
    this.avatarUrl,
    required this.skills,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a [CandidateModel] from a JSON map.
  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      jobTitle: json['jobTitle'] as String,
      department: json['department'] as String,
      experience: json['experience'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
      resumeUrl: json['resumeUrl'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts this [CandidateModel] into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'jobTitle': jobTitle,
      'department': department,
      'experience': experience,
      'location': location,
      'status': status,
      'resumeUrl': resumeUrl,
      'avatarUrl': avatarUrl,
      'skills': skills,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy of this model with the given fields replaced by the new values.
  CandidateModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? jobTitle,
    String? department,
    String? experience,
    String? location,
    String? status,
    String? resumeUrl,
    String? avatarUrl,
    List<String>? skills,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearResumeUrl = false,
    bool clearAvatarUrl = false,
  }) {
    return CandidateModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      jobTitle: jobTitle ?? this.jobTitle,
      department: department ?? this.department,
      experience: experience ?? this.experience,
      location: location ?? this.location,
      status: status ?? this.status,
      resumeUrl: clearResumeUrl ? null : (resumeUrl ?? this.resumeUrl),
      avatarUrl: clearAvatarUrl ? null : (avatarUrl ?? this.avatarUrl),
      skills: skills ?? this.skills,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CandidateModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phone == phone &&
        other.jobTitle == jobTitle &&
        other.department == department &&
        other.experience == experience &&
        other.location == location &&
        other.status == status &&
        other.resumeUrl == resumeUrl &&
        other.avatarUrl == avatarUrl &&
        listEquals(other.skills, skills) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        jobTitle.hashCode ^
        department.hashCode ^
        experience.hashCode ^
        location.hashCode ^
        status.hashCode ^
        resumeUrl.hashCode ^
        avatarUrl.hashCode ^
        skills.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'CandidateModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, jobTitle: $jobTitle, department: $department, experience: $experience, location: $location, status: $status, resumeUrl: $resumeUrl, avatarUrl: $avatarUrl, skills: $skills, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
