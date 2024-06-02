import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_event.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_state.dart';
import 'package:day_planner/features/day_recomendations/repository/recommendations_repository.dart';
import 'package:day_planner/features/day_recomendations/services/events_analyzer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayRecommendationsBloc extends Bloc<DayRecommendationsEvent, DayRecommendationsState> {
  final RecommendationsRepository _recommendationsRepository;
  final EventsAnalyzer _analyzer = EventsAnalyzer();
  DayRecommendationsBloc(this._recommendationsRepository) : super(const DayRecommendationsState()) {
    on<FetchEventsForRange>(_onFetchEventsForRange);
    on<AnalyzeRecommendations>(_onAnalyzeRecommendations);
  }

  Future<void> _onFetchEventsForRange(FetchEventsForRange event, Emitter<DayRecommendationsState> emit) async {
    try {
      final events = await _recommendationsRepository.rangeHealthData(event.from, event.to);
      emit(state.copyWith(fetchedEvents: events));
      add(const AnalyzeRecommendations());
    } catch (e, st) {
      print(st);
    }
  }

  void _onAnalyzeRecommendations(AnalyzeRecommendations event, Emitter<DayRecommendationsState> emit) {
    Map<String, double> weights = {
      'steps': 0.3,
      'kcal': 0.3,
      'heartRate': 0.2,
      'sport': 0.2,
    };

    final w = {...state.weights};

    final events = [...state.fetchedEvents];
    final recommendations = _analyzer.recommendActivities(events, weights);
    emit(state.copyWith(recommendations: recommendations));
  }

  void recommendActivities() {}
}
