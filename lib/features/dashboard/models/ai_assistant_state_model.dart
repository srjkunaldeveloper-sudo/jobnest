class AiAssistantStateModel {
  final bool isLoading;
  final List<String> suggestedPrompts;
  final String recentSuggestionTitle;
  final String recentSuggestionAction;

  const AiAssistantStateModel({
    this.isLoading = false,
    required this.suggestedPrompts,
    required this.recentSuggestionTitle,
    required this.recentSuggestionAction,
  });

  static AiAssistantStateModel getDefault() {
    return const AiAssistantStateModel(
      isLoading: false,
      suggestedPrompts: [
        "Find Python Developers",
        "Schedule Interviews",
        "Generate Job Description",
        "Find Top Candidates",
        "Improve Hiring Rate",
      ],
      recentSuggestionTitle: "Your Sales Executive job is getting fewer applications.",
      recentSuggestionAction: "Increase salary by 10%.",
    );
  }
}
