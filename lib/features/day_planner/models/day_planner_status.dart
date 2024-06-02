enum DayPlannerStatus {
  initial,
  loading,
  success,
  updated,
  error;

  bool get isInitial => this == DayPlannerStatus.initial;

  bool get isLoading => this == DayPlannerStatus.loading;

  bool get isSuccess => this == DayPlannerStatus.success;

  bool get isUpdated => this == DayPlannerStatus.updated;

  bool get isError => this == DayPlannerStatus.error;
}
