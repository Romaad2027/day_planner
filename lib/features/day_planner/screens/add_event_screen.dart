import 'package:day_planner/common/widgets/flushbar.dart';
import 'package:day_planner/common/widgets/loading_button.dart';
import 'package:day_planner/common/widgets/text_field.dart';
import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String? _category;
  late TimeOfDay _from;
  late TimeOfDay _to;
  final TextEditingController _nameController = TextEditingController();

  bool isTimeValid = true;
  String _timeErrorText = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final now = TimeOfDay.now();
    _from = now;
    _to = TimeOfDay(hour: now.hour + 1, minute: now.minute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          'Add Event',
          style: context.textStyle(TextScale.titleLarge),
        ),
      ),
      body: BlocConsumer<DayPlannerBloc, DayPlannerState>(
        listener: _dayPlannerListener,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Input data',
                    style: context.textStyle(TextScale.headlineMedium),
                  ),
                  const SizedBox(height: 32),
                  CommonTextField(
                    hintText: 'Event name',
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid nickname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Select category'),
                      value: _category,
                      items: const [
                        DropdownMenuItem(
                          value: 'Sport',
                          child: Text('Sport'),
                        ),
                        DropdownMenuItem(
                          value: 'Education',
                          child: Text('Education'),
                        ),
                        DropdownMenuItem(
                          value: 'Rest',
                          child: Text('Rest'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      validator: (value) {
                        if (_category == null) {
                          return 'Select category';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  _timeSelect(
                    context,
                    timeOfDay: _from,
                    onTap: () async {
                      final selected = await showTimePicker(context: context, initialTime: _from);
                      if (selected != null) {
                        setState(() {
                          _from = selected;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _timeSelect(
                    context,
                    timeOfDay: _to,
                    label: 'End',
                    onTap: () async {
                      final selected = await showTimePicker(context: context, initialTime: _to);
                      if (selected != null) {
                        setState(() {
                          _to = selected;
                        });
                      }
                    },
                  ),
                  if (!isTimeValid) ...[
                    const SizedBox(height: 8),
                    Text(
                      _timeErrorText,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                  const SizedBox(height: 32),
                  Center(
                    child: LoadingButton(
                      isLoading: state.dayPlannerStatus.isLoading,
                      onPressed: () => _handleAddButtonPress(context),
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleAddButtonPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final day = context.read<DayPlannerBloc>().state.day ?? DateTime.now();
      final fromDate = _formatAndValidateTime(day, _from);
      final toDate = _formatAndValidateTime(day, _to);

      setState(() => isTimeValid = true);
      if (fromDate == null || toDate == null) {
        setState(() => isTimeValid = false);
        return;
      }
      if (!_compareDates(fromDate, toDate)) {
        setState(() {
          isTimeValid = false;
          _timeErrorText = '"End" date can not be earlier than "begin"';
        });
        return;
      }
      context.read<DayPlannerBloc>().add(
            AddNewEvent(
              name: _nameController.text,
              category: _category!,
              from: fromDate,
              to: toDate,
            ),
          );
    }
  }

  Widget _timeSelect(
    BuildContext context, {
    required TimeOfDay timeOfDay,
    required VoidCallback onTap,
    String label = 'Begin',
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label: ',
          style: context.textStyle(TextScale.titleLarge),
        ),
        Material(
          borderRadius: BorderRadius.circular(16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                timeOfDay.format(context),
                style: context.textStyle(TextScale.headlineSmall),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DateTime? _formatAndValidateTime(DateTime day, TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return null;
    }
    final dateTime = DateTime(
      day.year,
      day.month,
      day.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return dateTime;
  }

  bool _compareDates(DateTime from, DateTime to) {
    return from.compareTo(to) != 1;
  }

  void _dayPlannerListener(BuildContext context, DayPlannerState state) {
    if (state.dayPlannerStatus.isSuccess) {
      context.pop();
    }
    if (state.dayPlannerStatus.isError) {
      showSnackBar(context, status: FlushbarStatus.error);
    }
  }
}
