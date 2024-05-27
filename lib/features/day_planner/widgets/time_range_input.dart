import 'dart:async';

import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeRangeInput extends StatefulWidget {
  const TimeRangeInput({super.key});

  @override
  _TimeRangeInputState createState() => _TimeRangeInputState();
}

class _TimeRangeInputState extends State<TimeRangeInput> {
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _startTimeController.addListener(_handleTimeChange);
    _endTimeController.addListener(_handleTimeChange);
  }

  void _handleTimeChange() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_startTimeController.text.length == 5 && _endTimeController.text.length == 5) {
        _triggerFunction();
      }
    });
  }

  void _triggerFunction() {
    final from = parseDateTime(_startTimeController.text);
    final to = parseDateTime(_endTimeController.text);
    if (from == null || to == null) {
      return;
    }
    context.read<DayPlannerBloc>().add(ValidateNewEventDateTime(from, to));
    print("Both time fields are fully filled with valid times: "
        "${_startTimeController.text} - ${_endTimeController.text}");
  }

  DateTime? parseDateTime(String time) {
    final components = time.split(':');
    if (components.length != 2) return null;

    final hour = int.tryParse(components[0]);
    final minute = int.tryParse(components[1]);

    if (hour == null || minute == null) return null;

    final date = context.read<DayPlannerBloc>().state.day ?? DateTime.now();
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  @override
  void dispose() {
    _startTimeController.removeListener(_handleTimeChange);
    _endTimeController.removeListener(_handleTimeChange);
    _startTimeController.dispose();
    _endTimeController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _startTimeController,
                decoration: const InputDecoration(labelText: 'Start Time'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TimeInputFormatter(),
                ],
                maxLength: 5,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _endTimeController,
                decoration: const InputDecoration(labelText: 'End Time'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TimeInputFormatter(),
                ],
                maxLength: 5,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        BlocBuilder<DayPlannerBloc, DayPlannerState>(
          buildWhen: (prev, curr) => prev.newDateTimeStatus != curr.newDateTimeStatus,
          builder: (context, state) {
            if (state.newDateTimeStatus.isRangeError) {
              return Text(
                'End time can not be earlier than begin time',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              );
            }
            if (state.newDateTimeStatus.isPlacedError) {
              return Text(
                "You've already scheduled event for this time",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 5) {
      return oldValue;
    }

    String newText = newValue.text;

    if (newValue.text.length == 2 && !newText.contains(':')) {
      newText = '$newText:';
    } else if (newValue.text.length > 2 && newText[2] != ':') {
      newText = '${newText.substring(0, 2)}:${newText.substring(2)}';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
