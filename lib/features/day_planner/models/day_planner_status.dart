enum DayPlannerStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == DayPlannerStatus.initial;

  bool get isLoading => this == DayPlannerStatus.loading;

  bool get isSuccess => this == DayPlannerStatus.success;

  bool get isError => this == DayPlannerStatus.error;
}
