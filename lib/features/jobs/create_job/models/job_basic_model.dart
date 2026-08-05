class JobBasicModel {
  final String? postingType;
  final String? title;
  final String? companyName;
  final String? department;
  final String? employmentType;
  final String? seniorityLevel;
  final String? experienceLevel;
  final int? numberOfPositions;

  const JobBasicModel({
    this.postingType,
    this.title,
    this.companyName,
    this.department,
    this.employmentType,
    this.seniorityLevel,
    this.experienceLevel,
    this.numberOfPositions,
  });

  JobBasicModel copyWith({
    String? postingType,
    String? title,
    String? companyName,
    String? department,
    String? employmentType,
    String? seniorityLevel,
    String? experienceLevel,
    int? numberOfPositions,
  }) {
    return JobBasicModel(
      postingType: postingType ?? this.postingType,
      title: title ?? this.title,
      companyName: companyName ?? this.companyName,
      department: department ?? this.department,
      employmentType: employmentType ?? this.employmentType,
      seniorityLevel: seniorityLevel ?? this.seniorityLevel,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      numberOfPositions: numberOfPositions ?? this.numberOfPositions,
    );
  }
}
