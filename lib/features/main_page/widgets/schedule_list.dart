import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/main_page/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double hourSlotHeight = 80.0;
const double timeLabelWidth = 60.0;
const double cardMarginVertical = 2.0;
const double cardMarginHorizontal = 8.0;
const EdgeInsets cardPadding = EdgeInsets.all(8.0);

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayPlannerBloc, DayPlannerState>(builder: (context, state) {
      final events = state.dayEvents;
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
            const TimeLine(),
          ],
        ),
      );
    });
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

class TimeLine extends StatelessWidget {
  const TimeLine({super.key});

  @override
  Widget build(BuildContext context) {
    final nowHour = DateTime.now().hour;
    final nowMinute = DateTime.now().minute;
    final top = ((nowHour * 60 + nowMinute) / 60) * hourSlotHeight;
    return Positioned(
      top: top,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Divider(
          color: Theme.of(context).colorScheme.primary,
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
    final fromHour = event.from.hour;
    final fromMinute = event.from.minute;
    final toHour = event.to.hour;
    final toMinute = event.to.minute;

    final top = ((fromHour * 60 + fromMinute) / 60) * hourSlotHeight; // Calculate top position using global constant
    final height = (((toHour * 60 + toMinute) - (fromHour * 60 + fromMinute)) / 60) *
        hourSlotHeight; // Calculate height using global constant

    return Positioned(
      top: top,
      left: timeLabelWidth, // Use global constant
      right: 0,
      height: height <= 29 ? 30 : height + 16,
      child: EventCard(event: event),
    );
  }
}
