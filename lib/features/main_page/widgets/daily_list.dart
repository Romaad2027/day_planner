import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:easy_localization/easy_localization.dart';
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.dayEvents.length,
          itemBuilder: (context, index) {
            final dayEvent = state.dayEvents[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Theme.of(context).colorScheme.error,
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              onDismissed: (direction) {
                context.read<DayPlannerBloc>().add(DeleteEvent(dayEvent.docId, dayEvent.from));
              },
              direction: DismissDirection.endToStart,
              child: ListTile(
                leading: Text(
                  _formatDateTime(dayEvent.from, dayEvent.to),
                ),
                title: Text(dayEvent.name),
                subtitle: Text(dayEvent.category),
                trailing: dayEvent.healthModel != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.monitor_heart),
                          Text(dayEvent.healthModel!.averageHeartRate.toString()),
                          const Icon(Icons.local_fire_department),
                          Text(dayEvent.healthModel!.totalSteps.toString()),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      )
                    : null,
              ),
            );
          },
        ),
      );
    });
  }

  String _formatDateTime(DateTime from, DateTime to) {
    return '${DateFormat('HH:mm').format(from)} - ${DateFormat('HH:mm').format(to)}';
  }
}
