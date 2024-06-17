import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_recomendations/models/generated_events_status.dart';
import 'package:day_planner/features/day_recomendations/models/recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DayRecommendationsState extends Equatable {
  final List<DayEvent> fetchedEvents;
  final Map<String, double> weights;

  final DateTime? day;
  final TimeOfDay from;
  final TimeOfDay to;

  final GenerateEventsStatus generatedEventsStatus;

  final List<Recommendation> recommendations;
  final List<DayEvent> generatedDays;

  const DayRecommendationsState({
    this.fetchedEvents = const [],
    this.weights = const {},
    this.recommendations = const [],
    this.generatedDays = const [],
    this.generatedEventsStatus = GenerateEventsStatus.initial,
    this.from = const TimeOfDay(hour: 8, minute: 0),
    this.to = const TimeOfDay(hour: 21, minute: 0),
    this.day,
  });

  DayRecommendationsState copyWith({
    List<DayEvent>? fetchedEvents,
    List<DayEvent>? generatedDays,
    GenerateEventsStatus? generatedEventsStatus,
    Map<String, double>? weights,
    List<Recommendation>? recommendations,
    DateTime? day,
    TimeOfDay? from,
    TimeOfDay? to,
  }) {
    return DayRecommendationsState(
      fetchedEvents: fetchedEvents ?? this.fetchedEvents,
      generatedDays: generatedDays ?? this.generatedDays,
      generatedEventsStatus: generatedEventsStatus ?? this.generatedEventsStatus,
      weights: weights ?? this.weights,
      recommendations: recommendations ?? this.recommendations,
      from: from ?? this.from,
      to: to ?? this.to,
      day: day ?? this.day,
    );
  }

  @override
  List<Object?> get props => [
        fetchedEvents,
        weights,
        recommendations,
        generatedEventsStatus,
        from,
        to,
        day,
      ];
}
