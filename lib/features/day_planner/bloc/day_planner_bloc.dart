import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:day_planner/features/day_planner/models/add_event.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_planner/repositories/events_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayPlannerBloc extends Bloc<DayPlannerEvent, DayPlannerState> {
  final EventsRepository _eventsRepository;

  late StreamSubscription<QuerySnapshot> _daySubscription;

  DayPlannerBloc(this._eventsRepository) : super(const DayPlannerState()) {
    on<AddNewEvent>(_onAddNewEvent);
    on<SetDay>(_onSetDay);
    on<ListenToDay>(_onListenToDay);
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
      await _eventsRepository.addEvent(addEvent);
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.success));
    } catch (e) {
      emit(state.copyWith(dayPlannerStatus: DayPlannerStatus.error));
    }
  }

  void _onSetDay(SetDay event, Emitter<DayPlannerState> emit) {
    emit(state.copyWith(day: event.day));
  }

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
        return state.copyWith(dayEvents: dayEvents);
      },
    );
  }
}
