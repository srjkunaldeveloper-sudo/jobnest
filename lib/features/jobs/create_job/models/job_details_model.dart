class JobDetailsModel {
  final String? jobDescription;
  final String? responsibilities;
  final String? requirements;
  final List<String> keySkills;
  final String? industryPreference;
  final String? educationQualification;
  final String? languageRequirements;
  final String? requiredCertifications;
  final String? preferredCertifications;
  final String? interviewConfiguration;

  const JobDetailsModel({
    this.jobDescription,
    this.responsibilities,
    this.requirements,
    this.keySkills = const [],
    this.industryPreference,
    this.educationQualification,
    this.languageRequirements,
    this.requiredCertifications,
    this.preferredCertifications,
    this.interviewConfiguration,
  });

  JobDetailsModel copyWith({
    String? jobDescription,
    String? responsibilities,
    String? requirements,
    List<String>? keySkills,
    String? industryPreference,
    String? educationQualification,
    String? languageRequirements,
    String? requiredCertifications,
    String? preferredCertifications,
    String? interviewConfiguration,
  }) {
    return JobDetailsModel(
      jobDescription: jobDescription ?? this.jobDescription,
      responsibilities: responsibilities ?? this.responsibilities,
      requirements: requirements ?? this.requirements,
      keySkills: keySkills ?? this.keySkills,
      industryPreference: industryPreference ?? this.industryPreference,
      educationQualification: educationQualification ?? this.educationQualification,
      languageRequirements: languageRequirements ?? this.languageRequirements,
      requiredCertifications: requiredCertifications ?? this.requiredCertifications,
      preferredCertifications: preferredCertifications ?? this.preferredCertifications,
      interviewConfiguration: interviewConfiguration ?? this.interviewConfiguration,
    );
  }
}
