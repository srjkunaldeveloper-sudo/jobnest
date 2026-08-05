class LocationModel {
  final String? workMode;
  final List<String> jobLocations;
  final String? officeAddress;

  const LocationModel({
    this.workMode,
    this.jobLocations = const [],
    this.officeAddress,
  });

  LocationModel copyWith({
    String? workMode,
    List<String>? jobLocations,
    String? officeAddress,
  }) {
    return LocationModel(
      workMode: workMode ?? this.workMode,
      jobLocations: jobLocations ?? this.jobLocations,
      officeAddress: officeAddress ?? this.officeAddress,
    );
  }
}
