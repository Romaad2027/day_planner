import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:equatable/equatable.dart';

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

enum CurrentDayStatus {
  initial,
  success,
  error;

  bool get isInitial => this == CurrentDayStatus.initial;

  bool get isSuccess => this == CurrentDayStatus.success;

  bool get isError => this == CurrentDayStatus.error;
}

class DayPlannerState extends Equatable {
  final DayPlannerStatus dayPlannerStatus;
  final CurrentDayStatus currentDayStatus;
  final DateTime? day;

  final List<DayEvent> dayEvents;
  final List<DayEvent> currentDayEvents;

  final String? errorMessage;

  const DayPlannerState({
    this.dayPlannerStatus = DayPlannerStatus.initial,
    this.currentDayStatus = CurrentDayStatus.initial,
    this.dayEvents = const <DayEvent>[],
    this.currentDayEvents = const <DayEvent>[],
    this.day,
    this.errorMessage,
  });

  DayPlannerState copyWith({
    DayPlannerStatus? dayPlannerStatus,
    CurrentDayStatus? currentDayStatus,
    List<DayEvent>? dayEvents,
    List<DayEvent>? currentDayEvents,
    DateTime? day,
    String? errorMessage,
  }) =>
      DayPlannerState(
        dayPlannerStatus: dayPlannerStatus ?? this.dayPlannerStatus,
        currentDayStatus: currentDayStatus ?? this.currentDayStatus,
        dayEvents: dayEvents ?? this.dayEvents,
        day: day ?? this.day,
        currentDayEvents: currentDayEvents ?? this.currentDayEvents,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        dayPlannerStatus,
        currentDayStatus,
        dayEvents,
        day,
        dayEvents,
        currentDayEvents,
        errorMessage,
      ];
}
