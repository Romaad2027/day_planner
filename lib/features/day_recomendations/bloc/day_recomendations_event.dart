import 'package:day_planner/features/day_planner/models/day_event.dart';

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

class CreateActivities extends DayRecommendationsEvent {
  final List<DayEvent> dayEvents;

  const CreateActivities(this.dayEvents);
}

class SetRange extends DayRecommendationsEvent {
  final DateTime from;
  final DateTime to;
  const SetRange(this.from, this.to);
}
