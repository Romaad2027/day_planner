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
  const FetchHealthData();
}
