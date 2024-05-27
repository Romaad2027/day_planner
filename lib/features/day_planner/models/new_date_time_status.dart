enum NewDateTimeStatus {
  initial,
  checking,
  success,
  rangeError,
  placedError;

  bool get isInitial => this == NewDateTimeStatus.initial;
  bool get isChecking => this == NewDateTimeStatus.checking;
  bool get isSuccess => this == NewDateTimeStatus.success;
  bool get isPlacedError => this == NewDateTimeStatus.placedError;
  bool get isRangeError => this == NewDateTimeStatus.rangeError;
}
