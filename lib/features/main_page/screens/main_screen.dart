import 'package:day_planner/common/router.dart';
import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/common/widgets/flushbar.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
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
  bool _isFabOpened = false;
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
                child: _showType == 'Calendar' ? const ScheduleViewWrapper() : const DailyList(),
              ),
              const SizedBox(height: 32),
            ],
          ),
          floatingActionButton: BlocBuilder<DayPlannerBloc, DayPlannerState>(
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'fetch',
                  shape: const CircleBorder(),
                  onPressed: () {},
                  child: _offsetPopup(context, state),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: 'create',
                  shape: const CircleBorder(),
                  onPressed: () => context.push(addEventRoute),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _offsetPopup(BuildContext context, DayPlannerState state) => PopupMenuButton<int>(
        surfaceTintColor: Colors.white,
        offset: state.day != null && state.day!.isBefore(getOnlyDate(DateTime.now()))
            ? const Offset(0, -130)
            : const Offset(0, -80),
        icon: _isFabOpened ? const Icon(Icons.close) : const Icon(Icons.more_vert),
        onSelected: (selected) async {
          setState(() {
            _isFabOpened = false;
          });
          if (selected == 1) {
            final dayEvents = context.read<DayPlannerBloc>().state.dayEvents;
            context.read<DayPlannerBloc>().add(FetchHealthData(eventsToFetch: dayEvents));
          } else if (selected == 2) {
            context.push(recommendRoute);
          }
        },
        onOpened: () {
          setState(() {
            _isFabOpened = true;
          });
        },
        onCanceled: () {
          setState(() {
            _isFabOpened = false;
          });
        },
        itemBuilder: (context) => [
          if (state.day != null && state.day!.isBefore(getOnlyDate(DateTime.now())))
            const PopupMenuItem(
              value: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.refresh_outlined),
                    SizedBox(width: 10),
                    Text(
                      'Sync health data',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          const PopupMenuItem(
            value: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.analytics_rounded),
                  SizedBox(width: 10),
                  Text('Recommend Activities'),
                ],
              ),
            ),
          ),
        ],
      );

  void _dayPlannerListener(BuildContext context, DayPlannerState state) {
    if (state.dayPlannerStatus.isSuccess) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showSnackBar(
          context,
          status: FlushbarStatus.success,
          message: 'Event was updated!',
        );
      });
    }
  }
}
