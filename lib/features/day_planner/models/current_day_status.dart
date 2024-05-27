enum CurrentDayStatus {
  initial,
  success,
  error;

  bool get isInitial => this == CurrentDayStatus.initial;

  bool get isSuccess => this == CurrentDayStatus.success;

  bool get isError => this == CurrentDayStatus.error;
}
