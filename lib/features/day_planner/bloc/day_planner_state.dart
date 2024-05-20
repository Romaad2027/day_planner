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

class DayPlannerState extends Equatable {
  final DayPlannerStatus dayPlannerStatus;
  final DateTime? day;

  final List<DayEvent> dayEvents;

  const DayPlannerState({
    this.dayPlannerStatus = DayPlannerStatus.initial,
    this.dayEvents = const <DayEvent>[],
    this.day,
  });

  DayPlannerState copyWith({
    DayPlannerStatus? dayPlannerStatus,
    List<DayEvent>? dayEvents,
    DateTime? day,
  }) =>
      DayPlannerState(
        dayPlannerStatus: dayPlannerStatus ?? this.dayPlannerStatus,
        dayEvents: dayEvents ?? this.dayEvents,
        day: day ?? this.day,
      );

  @override
  List<Object?> get props => [
        dayPlannerStatus,
        dayEvents,
        day,
        dayEvents,
      ];
}
