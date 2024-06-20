import 'package:day_planner/features/day_planner/models/day_event.dart';

abstract class DayPlannerEvent {
  const DayPlannerEvent();
}

class AddNewEvent extends DayPlannerEvent {
  final String name;
  final String category;
  final DateTime from;
  final DateTime to;

  const AddNewEvent({
    required this.name,
    required this.category,
    required this.from,
    required this.to,
  });
}

class AddSeveralActivities extends DayPlannerEvent {
  final List<DayEvent> dayEvents;

  const AddSeveralActivities(this.dayEvents);
}

class UpdateEvent extends DayPlannerEvent {
  final DayEvent dayEvent;

  const UpdateEvent(this.dayEvent);
}

class SetDay extends DayPlannerEvent {
  final DateTime day;

  const SetDay(this.day);
}

class ListenToDay extends DayPlannerEvent {
  final DateTime day;
  const ListenToDay(this.day);
}

class ListenToCurrentDay extends DayPlannerEvent {
  const ListenToCurrentDay();
}

class DeleteEvent extends DayPlannerEvent {
  final String docId;
  final DateTime day;

  const DeleteEvent(this.docId, this.day);
}

class FetchHealthData extends DayPlannerEvent {
  final bool onlyCurrentEvent;
  final List<DayEvent>? eventsToFetch;
  const FetchHealthData({this.onlyCurrentEvent = false, this.eventsToFetch});
}

class StartTimer extends DayPlannerEvent {
  const StartTimer();
}

class ValidateNewEventDateTime extends DayPlannerEvent {
  final DateTime from;
  final DateTime to;

  final String? docId;
  final bool isEditMode;

  const ValidateNewEventDateTime({
    required this.from,
    required this.to,
    this.isEditMode = false,
    this.docId,
  });
}

class ClearAddStatus extends DayPlannerEvent {
  const ClearAddStatus();
}
