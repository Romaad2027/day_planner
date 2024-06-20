import 'dart:async';

import 'package:collection/collection.dart';
import 'package:day_planner/common/utils/utils.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:day_planner/features/day_planner/models/add_event.dart';
import 'package:day_planner/features/day_planner/models/current_day_status.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_planner/models/day_planner_status.dart';
import 'package:day_planner/features/day_planner/models/new_date_time_status.dart';
import 'package:day_planner/features/day_planner/repositories/events_repository.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:day_planner/features/health/models/heart_rate.dart';
import 'package:day_planner/features/health/models/kcal.dart';
import 'package:day_planner/features/health/models/steps.dart';
import 'package:day_planner/features/health/services/health.dart';
import 'package:day_planner/features/health/utils/health_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';

class DayPlannerBloc extends Bloc<DayPlannerEvent, DayPlannerState> {
  final EventsRepository _eventsRepository;
  final HealthService _healthService;

  late Timer _timer;

  DayPlannerBloc(this._eventsRepository, this._healthService) : super(const DayPlannerState()) {
    on<AddNewEvent>(_onAddNewEvent);
    on<AddSeveralActivities>(_onAddSeveralActivities);
    on<UpdateEvent>(_onUpdateEvent);
    on<SetDay>(_onSetDay);
    on<ListenToDay>(_onListenToDay);
    on<ListenToCurrentDay>(_onListenToCurrentDay);
    on<DeleteEvent>(_onDeleteEvent);
    on<FetchHealthData>(_onFetchHealthData);
    on<StartTimer>(_onStartTimer);
    on<ValidateNewEventDateTime>(_onValidateNewEventDateTime);
    on<ClearAddStatus>(_onClearAddStatus);
  }

  Future<void> _onAddNewEvent(AddNewEvent event, Emitter<DayPlannerState> emit) async {
    try {
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.loading));
      final addEvent = AddEventModel(
        name: event.name,
        category: event.category,
        from: event.from,
        to: event.to,
      );
      if (!isValidNewEventTime(addEvent.from, addEvent.to, state.currentDayEvents)) {
        emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.error, errorMessage: ''));
        return;
      }
      final docId = await _eventsRepository.addEvent(addEvent);
      final dayEvent = DayEvent.fromAddNewEvent(addEvent, docId);
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.success));
    } catch (e) {
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.error));
    }
  }

  Future<void> _onAddSeveralActivities(AddSeveralActivities event, Emitter<DayPlannerState> emit) async {
    emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.loading));
    for (final e in event.dayEvents) {
      final addEvent = AddEventModel(
        name: e.name,
        category: e.category,
        from: e.from,
        to: e.to,
      );
      await _eventsRepository.addEvent(addEvent);
    }
    emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.success));
  }

  Future<void> _onUpdateEvent(UpdateEvent event, Emitter<DayPlannerState> emit) async {
    try {
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.loading));
      final eventToUpdate = event.dayEvent;
      await _eventsRepository.updateEvent(eventToUpdate);
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.success));
      add(FetchHealthData(eventsToFetch: [eventToUpdate]));
    } catch (e) {
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.error));
    }
  }

  void _onSetDay(SetDay event, Emitter<DayPlannerState> emit) {
    emit(state.copyWith(day: event.day));
  }

  /// Listens only to current day for health data update
  Future<void> _onListenToCurrentDay(ListenToCurrentDay event, Emitter<DayPlannerState> emit) async {
    final dateTime = DateTime.now();
    final day = DateTime(dateTime.year, dateTime.month, dateTime.day);
    await emit.forEach(
      _eventsRepository.dayEventStream(day.millisecondsSinceEpoch.toString()),
      onData: (snapshot) {
        final currentDayEvents = <DayEvent>[];
        for (final qDocSnap in snapshot.docs) {
          final data = qDocSnap.data();
          if (data != null) {
            currentDayEvents.add(data);
          }
        }
        return state.copyWith(currentDayEvents: currentDayEvents, currentDayStatus: CurrentDayStatus.success);
      },
    );
  }

  /// Listens to selected on calendar day
  Future<void> _onListenToDay(ListenToDay event, Emitter<DayPlannerState> emit) async {
    final dateTime = event.day;
    final day = DateTime(dateTime.year, dateTime.month, dateTime.day);
    await emit.forEach(
      _eventsRepository.dayEventStream(day.millisecondsSinceEpoch.toString()),
      onData: (snapshot) {
        final dayEvents = <DayEvent>[];
        for (final qDocSnap in snapshot.docs) {
          final data = qDocSnap.data();
          if (data != null) {
            dayEvents.add(data);
          }
        }
        dayEvents.sort((a, b) => a.from.compareTo(b.from));
        return state.copyWith(dayEvents: dayEvents);
      },
    );
  }

  Future<void> _onDeleteEvent(DeleteEvent event, Emitter<DayPlannerState> emit) async {
    final dateTime = event.day;
    final day = DateTime(dateTime.year, dateTime.month, dateTime.day);

    await _eventsRepository.deleteEvent(day.millisecondsSinceEpoch.toString(), event.docId);
  }

  // void aggregateData(List<DayEvent> dayEvents, List<HealthDataPoint> healthData) {
  //   for (final dayEvent in dayEvents) {
  //     final eventRangeHealthData = healthData.where((d) {
  //       return checkIfDateInRange(check: d.dateFrom, begin: dayEvent.from, end: dayEvent.to);
  //     }).toList();
  //
  //     int totalSteps = 0;
  //     for (final evRaHeDa in eventRangeHealthData) {
  //       if (evRaHeDa.type == HealthDataType.STEPS) {
  //         // totalSteps += evRaHeDa.;
  //       }
  //     }
  //   }
  // }

  Future<void> _onFetchHealthData(FetchHealthData event, Emitter<DayPlannerState> emit) async {
    final currentDayEvents = event.eventsToFetch ?? _getEventsForHealthUpdate(event.onlyCurrentEvent);
    for (final currEvent in currentDayEvents) {
      final healthData = await _healthService.fetchHealthData(currEvent.from, currEvent.to);
      if (healthData.isEmpty) {
        continue;
      }
      final healthModel = _sortHealthData(healthData);
      final date = extractTimeFromDate(currEvent.from);
      await _eventsRepository.addHealthData(
        docId: currEvent.docId,
        dateMilliSeconds: date.millisecondsSinceEpoch.toString(),
        healthModel: healthModel,
      );
    }
  }

  void _onStartTimer(StartTimer event, Emitter<DayPlannerState> emit) {
    _timer = Timer.periodic(const Duration(minutes: 2), (timer) {
      add(const FetchHealthData(onlyCurrentEvent: true));
    });
  }

  void _onValidateNewEventDateTime(ValidateNewEventDateTime event, Emitter<DayPlannerState> emit) {
    emit(state.copyWith(newDateTimeStatus: NewDateTimeStatus.checking));
    final events = [...state.dayEvents];
    if (event.isEditMode) {
      events.removeWhere((e) => e.docId == event.docId);
    }
    final addEventModel = AddEventModel(
      name: 'New',
      category: 'Event',
      from: event.from,
      to: event.to,
    );
    if (!compareDates(event.from, event.to)) {
      emit(state.copyWith(newDateTimeStatus: NewDateTimeStatus.rangeError, addEventModel: addEventModel));
      return;
    }
    if (!isValidNewEventTime(event.from, event.to, events)) {
      emit(state.copyWith(newDateTimeStatus: NewDateTimeStatus.placedError, addEventModel: addEventModel));
      return;
    }
    emit(state.copyWith(newDateTimeStatus: NewDateTimeStatus.success, addEventModel: addEventModel));
  }

  void _onClearAddStatus(ClearAddStatus event, Emitter<DayPlannerState> emit) {
    emit(state.copyWith(
      newDateTimeStatus: NewDateTimeStatus.initial,
      clearAddModel: true,
    ));
  }

  List<DayEvent> _getEventsForHealthUpdate(bool onlyCurrentEvent) {
    if (!onlyCurrentEvent) {
      return state.currentDayEvents;
    }
    final currEvent = _getCurrentEvent();
    if (currEvent == null) {
      return [];
    }
    return [currEvent];
  }

  DayEvent? _getCurrentEvent() {
    return state.currentDayEvents.firstWhereOrNull(
      (d) => checkIfDateInRange(
        check: DateTime.now(),
        begin: d.from,
        end: d.to,
      ),
    );
  }

  HealthModel _sortHealthData(List<HealthDataPoint> healthData) {
    final heartRates = <HeartRate>[];
    final steps = <Steps>[];
    final kcal = <Kcal>[];
    for (final hd in healthData) {
      if (hd.type.isSteps) {
        steps.add(Steps.fromHealthDataPoint(hd));
      }
      if (hd.type.isHeartRate) {
        heartRates.add(HeartRate.fromHealthDataPoint(hd));
      }
      if (hd.type.isKcal) {
        kcal.add(Kcal.fromHealthDataPoint(hd));
      }
    }
    return HealthModel.fromHealthData(steps, heartRates, kcal);
  }
}
