class DayRecommendationsEvent {
  const DayRecommendationsEvent();
}

class FetchEventsForRange extends DayRecommendationsEvent {
  final DateTime from;
  final DateTime to;
  const FetchEventsForRange(this.from, this.to);
}

class AnalyzeRecommendations extends DayRecommendationsEvent {
  const AnalyzeRecommendations();
}
