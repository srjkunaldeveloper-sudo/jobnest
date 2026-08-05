class ApplicationModel {
  final String? applicationMethod;
  final String? externalUrl;
  final String? email;
  final DateTime? applicationDeadline;

  const ApplicationModel({
    this.applicationMethod,
    this.externalUrl,
    this.email,
    this.applicationDeadline,
  });

  ApplicationModel copyWith({
    String? applicationMethod,
    String? externalUrl,
    String? email,
    DateTime? applicationDeadline,
  }) {
    return ApplicationModel(
      applicationMethod: applicationMethod ?? this.applicationMethod,
      externalUrl: externalUrl ?? this.externalUrl,
      email: email ?? this.email,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
    );
  }
}
