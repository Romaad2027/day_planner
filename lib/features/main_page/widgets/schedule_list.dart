import 'dart:async';

import 'package:day_planner/common/utils/utils.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:day_planner/features/day_planner/models/add_event.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/main_page/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double hourSlotHeight = 80.0;
const double timeLabelWidth = 60.0;
const double cardMarginVertical = 2.0;
const double cardMarginHorizontal = 8.0;
const EdgeInsets cardPadding = EdgeInsets.all(8.0);

class ScheduleViewWrapper extends StatelessWidget {
  final AddEventModel? addNewEvent;

  const ScheduleViewWrapper({
    this.addNewEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayPlannerBloc, DayPlannerState>(
      builder: (context, state) => ScheduleView(
        events: state.dayEvents,
        day: state.day,
      ),
    );
  }
}

class ScheduleManageEventView extends StatelessWidget {
  final AddEventModel? addNewEvent;
  final List<DayEvent> dayEvents;
  final DateTime? day;

  const ScheduleManageEventView({
    required this.dayEvents,
    required this.day,
    this.addNewEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScheduleView(
      addNewEvent: addNewEvent,
      events: dayEvents,
      day: day,
    );
  }
}

class ScheduleView extends StatelessWidget {
  // For dynamically showing new adding events
  final AddEventModel? addNewEvent;

  final List<DayEvent> events;

  final DateTime? day;

  const ScheduleView({
    required this.events,
    required this.day,
    this.addNewEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: List.generate(24, (index) {
                final time = TimeOfDay(hour: index, minute: 0);
                return TimeSlotRow(time: time);
              }),
            ),
          ),
          ...events.map((event) => PositionedEventCard(event: event)).toList(),
          if (day == null || day?.day == DateTime.now().day) const TimeLine(),
          if (addNewEvent != null)
            Positioned(
              top: calculateEventTop(DayEvent.fromAddNewEvent(addNewEvent!), hourSlotHeight),
              left: timeLabelWidth,
              right: 0,
              height: calculateEventHeight(DayEvent.fromAddNewEvent(addNewEvent!), hourSlotHeight),
              child: EventCard(
                cardColor: Theme.of(context).colorScheme.inversePrimary,
                event: DayEvent.fromAddNewEvent(addNewEvent!),
              ),
            ),
        ],
      ),
    );
  }
}

class TimeSlotRow extends StatelessWidget {
  final TimeOfDay time;

  const TimeSlotRow({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: timeLabelWidth,
          padding: const EdgeInsets.all(4.0),
          child: Text(time.format(context)),
        ),
        Expanded(
          child: Container(
            height: hourSlotHeight,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  late int nowHour;
  late int nowMinute;

  late Timer _timeTimer;

  @override
  void initState() {
    nowHour = DateTime.now().hour;
    nowMinute = DateTime.now().minute;
    _timeTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        nowHour = DateTime.now().hour;
        nowMinute = DateTime.now().minute;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = ((nowHour * 60 + nowMinute) / 60) * hourSlotHeight;
    return Positioned(
      top: top,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Divider(
          color: Theme.of(context).colorScheme.tertiary,
          thickness: 2,
        ),
      ),
    );
  }
}

class PositionedEventCard extends StatelessWidget {
  final DayEvent event;

  const PositionedEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final top = calculateEventTop(event, hourSlotHeight);
    final height = calculateEventHeight(event, hourSlotHeight);

    return Positioned(
      top: top,
      left: timeLabelWidth,
      right: 0,
      height: height <= 29 ? 30 : height + 16,
      child: EventCard(event: event),
    );
  }
}
