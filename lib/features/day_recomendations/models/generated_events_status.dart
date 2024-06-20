enum GenerateEventsStatus {
  initial,
  generating,
  loading,
  error;

  bool get isInitial => this == GenerateEventsStatus.initial;
  bool get isGenerating => this == GenerateEventsStatus.generating;
  bool get isLoading => this == GenerateEventsStatus.loading;
  bool get isError => this == GenerateEventsStatus.error;
}

enum RecommendationStatus {
  initial,
  success,
  empty,
  loading,
  error;

  bool get isInitial => this == RecommendationStatus.initial;
  bool get isSuccess => this == RecommendationStatus.success;
  bool get isEmpty => this == RecommendationStatus.empty;
  bool get isLoading => this == RecommendationStatus.loading;
  bool get isError => this == RecommendationStatus.error;
}
