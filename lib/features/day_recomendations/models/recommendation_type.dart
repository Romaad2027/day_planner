enum RecommendationType {
  steps,
  kcal,
  sportActivity;

  bool get isSteps => this == RecommendationType.steps;
  bool get isKcal => this == RecommendationType.kcal;
  bool get isSportActivity => this == RecommendationType.sportActivity;
}
