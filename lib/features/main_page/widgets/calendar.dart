import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _currentDay;
  late DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    _currentDay = context.read<DayPlannerBloc>().state.day ?? DateTime.now();
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      currentDay: _currentDay,
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) => _focusedDay = focusedDay,
      selectedDayPredicate: (day) => isSameDay(_currentDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusedDay = focusedDay;
        });
        context.read<DayPlannerBloc>().add(SetDay(selectedDay));
        context.read<DayPlannerBloc>().add(ListenToDay(selectedDay));
      },
    );
  }
}
