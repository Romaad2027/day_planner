import 'package:day_planner/features/day_planner/models/add_event.dart';
import 'package:day_planner/features/day_planner/models/current_day_status.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_planner/models/day_planner_status.dart';
import 'package:day_planner/features/day_planner/models/new_date_time_status.dart';
import 'package:equatable/equatable.dart';

class DayPlannerState extends Equatable {
  final DayPlannerStatus dayPlannerStatus;
  final CurrentDayStatus currentDayStatus;
  final DateTime? day;

  final AddEventModel? addEventModel;

  final List<DayEvent> dayEvents;
  final List<DayEvent> currentDayEvents;

  final String? errorMessage;

  final NewDateTimeStatus newDateTimeStatus;

  const DayPlannerState({
    this.dayPlannerStatus = DayPlannerStatus.initial,
    this.currentDayStatus = CurrentDayStatus.initial,
    this.dayEvents = const <DayEvent>[],
    this.currentDayEvents = const <DayEvent>[],
    this.newDateTimeStatus = NewDateTimeStatus.initial,
    this.day,
    this.addEventModel,
    this.errorMessage,
  });

  DayPlannerState copyWith({
    DayPlannerStatus? dayPlannerStatus,
    CurrentDayStatus? currentDayStatus,
    List<DayEvent>? dayEvents,
    List<DayEvent>? currentDayEvents,
    NewDateTimeStatus? newDateTimeStatus,
    DateTime? day,
    String? errorMessage,
    AddEventModel? addEventModel,
    bool clearAddModel = false,
  }) =>
      DayPlannerState(
        dayPlannerStatus: dayPlannerStatus ?? this.dayPlannerStatus,
        currentDayStatus: currentDayStatus ?? this.currentDayStatus,
        dayEvents: dayEvents ?? this.dayEvents,
        newDateTimeStatus: newDateTimeStatus ?? this.newDateTimeStatus,
        day: day ?? this.day,
        currentDayEvents: currentDayEvents ?? this.currentDayEvents,
        errorMessage: errorMessage ?? this.errorMessage,
        addEventModel: clearAddModel ? null : (addEventModel ?? this.addEventModel),
      );

  @override
  List<Object?> get props => [
        dayPlannerStatus,
        currentDayStatus,
        dayEvents,
        day,
        newDateTimeStatus,
        dayEvents,
        currentDayEvents,
        errorMessage,
        addEventModel,
      ];
}
