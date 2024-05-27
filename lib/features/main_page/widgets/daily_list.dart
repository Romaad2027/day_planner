import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:day_planner/features/main_page/widgets/event_tile.dart';
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
          final healthModel = dayEvent.healthModel;
          final isCurrEvent = checkIfDateInRange(
            check: DateTime.now(),
            begin: dayEvent.from,
            end: dayEvent.to,
          );
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: EventTile(
                dayEvent: dayEvent,
                isCurrEvent: isCurrEvent,
              ),
            ),
          );
        },
      );
    });
  }
}
