class CompensationModel {
  final double? minSalary;
  final double? maxSalary;
  final bool showSalary;
  final List<String> benefits;

  const CompensationModel({
    this.minSalary,
    this.maxSalary,
    this.showSalary = true,
    this.benefits = const [],
  });

  CompensationModel copyWith({
    double? minSalary,
    double? maxSalary,
    bool? showSalary,
    List<String>? benefits,
  }) {
    return CompensationModel(
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      showSalary: showSalary ?? this.showSalary,
      benefits: benefits ?? this.benefits,
    );
  }
}
