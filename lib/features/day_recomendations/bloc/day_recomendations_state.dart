import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_recomendations/models/recommendation.dart';
import 'package:equatable/equatable.dart';

class DayRecommendationsState extends Equatable {
  final List<DayEvent> fetchedEvents;
  final Map<String, double> weights;

  final List<Recommendation> recommendations;

  const DayRecommendationsState({
    this.fetchedEvents = const [],
    this.weights = const {},
    this.recommendations = const [],
  });

  DayRecommendationsState copyWith({
    List<DayEvent>? fetchedEvents,
    Map<String, double>? weights,
    List<Recommendation>? recommendations,
  }) {
    return DayRecommendationsState(
      fetchedEvents: fetchedEvents ?? this.fetchedEvents,
      weights: weights ?? this.weights,
      recommendations: recommendations ?? this.recommendations,
    );
  }

  @override
  List<Object?> get props => [
        fetchedEvents,
        weights,
        recommendations,
      ];
}
