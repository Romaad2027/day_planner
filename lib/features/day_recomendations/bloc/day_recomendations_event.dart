import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/profile/models/health_thresholds.dart';

class DayRecommendationsEvent {
  const DayRecommendationsEvent();
}

class FetchEventsForRange extends DayRecommendationsEvent {
  final DateTime from;
  final DateTime to;
  final HealthThresholds thresholds;

  const FetchEventsForRange(this.from, this.to, this.thresholds);
}

class AnalyzeRecommendations extends DayRecommendationsEvent {
  final HealthThresholds thresholds;
  const AnalyzeRecommendations(this.thresholds);
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

class UpdateEvent extends DayRecommendationsEvent {
  final DayEvent dayEvent;

  const UpdateEvent(this.dayEvent);
}
