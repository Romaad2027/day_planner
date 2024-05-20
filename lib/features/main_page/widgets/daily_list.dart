import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyList extends StatelessWidget {
  const DailyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayPlannerBloc, DayPlannerState>(builder: (context, state) {
      if (state.dayEvents.isEmpty) {
        return const Center(
          child: Text('No data for today'),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.dayEvents.length,
        itemBuilder: (context, index) {
          final dayEvent = state.dayEvents[index];
          return ListTile(
            title: Text(dayEvent.name),
            subtitle: Text(dayEvent.category),
            trailing: dayEvent.healthModel != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.monitor_heart),
                      Text(dayEvent.healthModel!.heartRate.toString()),
                      const Icon(Icons.local_fire_department),
                      Text(dayEvent.healthModel!.steps.toString()),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  )
                : null,
          );
        },
      );
    });
  }
}
