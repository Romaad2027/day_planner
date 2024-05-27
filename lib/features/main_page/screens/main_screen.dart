import 'package:day_planner/common/router.dart';
import 'package:day_planner/common/widgets/flushbar.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:day_planner/features/main_page/widgets/calendar.dart';
import 'package:day_planner/features/main_page/widgets/daily_list.dart';
import 'package:day_planner/features/main_page/widgets/schedule_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _showType = 'List';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<DayPlannerBloc, DayPlannerState>(
        listenWhen: (prev, curr) => prev.dayPlannerStatus != curr.dayPlannerStatus,
        listener: _dayPlannerListener,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Calendar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoSlidingSegmentedControl<String>(
                    groupValue: _showType,
                    onValueChanged: (String? value) {
                      setState(() {
                        _showType = value;
                      });
                    },
                    children: const {
                      'List': Text('List'),
                      'Calendar': Text('Calendar'),
                    },
                  ),
                ),
              ),
              Flexible(
                child: _showType == 'Calendar' ? const ScheduleView() : const DailyList(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () => context.push(addEventRoute),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _dayPlannerListener(BuildContext context, DayPlannerState state) {
    if (state.dayPlannerStatus.isSuccess) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showSnackBar(
          context,
          status: FlushbarStatus.success,
          message: 'Event was added!',
        );
      });
    }
  }
}
