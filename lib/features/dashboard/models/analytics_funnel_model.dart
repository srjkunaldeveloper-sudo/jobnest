class AnalyticsFunnelModel {
  final String applications;
  final String screened;
  final String interviews;
  final String selected;
  final String conversionRate;
  final String offerRate;
  final String overallSuccessRate;

  const AnalyticsFunnelModel({
    required this.applications,
    required this.screened,
    required this.interviews,
    required this.selected,
    required this.conversionRate,
    required this.offerRate,
    required this.overallSuccessRate,
  });

  static AnalyticsFunnelModel getWeeklyDefault() {
    return const AnalyticsFunnelModel(
      applications: "1,240",
      screened: "840",
      interviews: "520",
      selected: "78",
      conversionRate: "42%",
      offerRate: "15%",
      overallSuccessRate: "82%",
    );
  }

  static AnalyticsFunnelModel getMonthlyDefault() {
    return const AnalyticsFunnelModel(
      applications: "4,960",
      screened: "3,360",
      interviews: "2,080",
      selected: "312",
      conversionRate: "42%",
      offerRate: "15%",
      overallSuccessRate: "85%",
    );
  }
}
