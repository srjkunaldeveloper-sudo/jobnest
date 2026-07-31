import 'package:flutter/foundation.dart';

@immutable
class DashboardSummary {
  final int totalJobs;
  final int activeJobs;
  final int totalCandidates;
  final int shortlistedCandidates;
  final int interviewsToday;
  final int hiredCandidates;

  const DashboardSummary({
    required this.totalJobs,
    required this.activeJobs,
    required this.totalCandidates,
    required this.shortlistedCandidates,
    required this.interviewsToday,
    required this.hiredCandidates,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalJobs: json['totalJobs'] as int? ?? 0,
      activeJobs: json['activeJobs'] as int? ?? 0,
      totalCandidates: json['totalCandidates'] as int? ?? 0,
      shortlistedCandidates: json['shortlistedCandidates'] as int? ?? 0,
      interviewsToday: json['interviewsToday'] as int? ?? 0,
      hiredCandidates: json['hiredCandidates'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalJobs': totalJobs,
      'activeJobs': activeJobs,
      'totalCandidates': totalCandidates,
      'shortlistedCandidates': shortlistedCandidates,
      'interviewsToday': interviewsToday,
      'hiredCandidates': hiredCandidates,
    };
  }

  DashboardSummary copyWith({
    int? totalJobs,
    int? activeJobs,
    int? totalCandidates,
    int? shortlistedCandidates,
    int? interviewsToday,
    int? hiredCandidates,
  }) {
    return DashboardSummary(
      totalJobs: totalJobs ?? this.totalJobs,
      activeJobs: activeJobs ?? this.activeJobs,
      totalCandidates: totalCandidates ?? this.totalCandidates,
      shortlistedCandidates: shortlistedCandidates ?? this.shortlistedCandidates,
      interviewsToday: interviewsToday ?? this.interviewsToday,
      hiredCandidates: hiredCandidates ?? this.hiredCandidates,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DashboardSummary &&
        other.totalJobs == totalJobs &&
        other.activeJobs == activeJobs &&
        other.totalCandidates == totalCandidates &&
        other.shortlistedCandidates == shortlistedCandidates &&
        other.interviewsToday == interviewsToday &&
        other.hiredCandidates == hiredCandidates;
  }

  @override
  int get hashCode {
    return totalJobs.hashCode ^
        activeJobs.hashCode ^
        totalCandidates.hashCode ^
        shortlistedCandidates.hashCode ^
        interviewsToday.hashCode ^
        hiredCandidates.hashCode;
  }
}
