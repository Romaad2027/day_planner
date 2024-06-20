import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_event.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_state.dart';
import 'package:day_planner/features/day_recomendations/models/generated_events_status.dart';
import 'package:day_planner/features/day_recomendations/repository/recommendations_repository.dart';
import 'package:day_planner/features/day_recomendations/services/events_analyzer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayRecommendationsBloc extends Bloc<DayRecommendationsEvent, DayRecommendationsState> {
  final RecommendationsRepository _recommendationsRepository;
  final EventsAnalyzer _analyzer = EventsAnalyzer();
  DayRecommendationsBloc(this._recommendationsRepository) : super(const DayRecommendationsState()) {
    on<FetchEventsForRange>(_onFetchEventsForRange);
    on<AnalyzeRecommendations>(_onAnalyzeRecommendations);
    on<CreateActivities>(_onCreateActivities);
    on<UpdateEvent>(_onUpdateEvent);
  }

  Future<void> _onFetchEventsForRange(FetchEventsForRange event, Emitter<DayRecommendationsState> emit) async {
    try {
      emit(state.copyWith(recommendationStatus: RecommendationStatus.loading));
      final events = await _recommendationsRepository.rangeHealthData(event.from, event.to);
      final day = getOnlyDate(event.to);
      emit(state.copyWith(fetchedEvents: events, day: day));
      add(AnalyzeRecommendations(event.thresholds));
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
    final recommendations = _analyzer.recommendActivities(events, weights, event.thresholds);
    if (recommendations.isEmpty) {
      return emit(state.copyWith(
        recommendations: recommendations,
        recommendationStatus: RecommendationStatus.empty,
      ));
    }
    emit(state.copyWith(
      recommendations: recommendations,
      recommendationStatus: RecommendationStatus.success,
    ));
  }

  void _onCreateActivities(CreateActivities event, Emitter<DayRecommendationsState> emit) {
    emit(state.copyWith(generatedEventsStatus: GenerateEventsStatus.loading));
    final recommendations = [...state.recommendations];
    final allAnalysisRangeEvent = [...state.fetchedEvents];
    final day = state.day;
    final dayEvents = _analyzer.createActivities(
      recommendations: recommendations,
      events: event.dayEvents,
      allAnalysisRangeEvent: allAnalysisRangeEvent,
      recommendationStart: state.from,
      recommendationEnd: state.to,
      day: day ?? getOnlyDate(DateTime.now()),
    );
    emit(state.copyWith(generatedDays: dayEvents, generatedEventsStatus: GenerateEventsStatus.generating));
  }

  void _onUpdateEvent(UpdateEvent event, Emitter<DayRecommendationsState> emit) {
    final events = [...state.generatedDays];
    events.removeWhere((e) => e.docId == event.dayEvent.docId);

    events.add(event.dayEvent);
    emit(state.copyWith(generatedDays: events));
  }
}
