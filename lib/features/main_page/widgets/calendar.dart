import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      currentDay: _currentDay,
      calendarFormat: CalendarFormat.week,
      onDaySelected: (date, prev) {
        setState(() => _currentDay = date);
      },
    );
  }
}
