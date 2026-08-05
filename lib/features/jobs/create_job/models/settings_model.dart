class SettingsModel {
  final bool relocationRequired;
  final String? travelRequirement;
  final String? hiringTimeline;
  final String? priority;
  final String? schedule;
  final String? shiftType;
  final String? startTime;
  final String? endTime;
  final String? recruiterName;
  final String? recruiterEmail;
  final String? recruiterPhone;
  final List<String> screeningQuestions;

  const SettingsModel({
    this.relocationRequired = false,
    this.travelRequirement,
    this.hiringTimeline,
    this.priority,
    this.schedule,
    this.shiftType,
    this.startTime,
    this.endTime,
    this.recruiterName,
    this.recruiterEmail,
    this.recruiterPhone,
    this.screeningQuestions = const [],
  });

  SettingsModel copyWith({
    bool? relocationRequired,
    String? travelRequirement,
    String? hiringTimeline,
    String? priority,
    String? schedule,
    String? shiftType,
    String? startTime,
    String? endTime,
    String? recruiterName,
    String? recruiterEmail,
    String? recruiterPhone,
    List<String>? screeningQuestions,
  }) {
    return SettingsModel(
      relocationRequired: relocationRequired ?? this.relocationRequired,
      travelRequirement: travelRequirement ?? this.travelRequirement,
      hiringTimeline: hiringTimeline ?? this.hiringTimeline,
      priority: priority ?? this.priority,
      schedule: schedule ?? this.schedule,
      shiftType: shiftType ?? this.shiftType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      recruiterName: recruiterName ?? this.recruiterName,
      recruiterEmail: recruiterEmail ?? this.recruiterEmail,
      recruiterPhone: recruiterPhone ?? this.recruiterPhone,
      screeningQuestions: screeningQuestions ?? this.screeningQuestions,
    );
  }
}
