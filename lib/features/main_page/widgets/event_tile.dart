import 'package:day_planner/common/router.dart';
import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventTile extends StatelessWidget {
  final bool isCurrEvent;
  final DayEvent dayEvent;
  const EventTile({
    required this.dayEvent,
    this.isCurrEvent = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final healthModel = dayEvent.healthModel;
    return Material(
      elevation: isCurrEvent ? 3.0 : 0,
      child: ListTile(
        tileColor: isCurrEvent ? Theme.of(context).colorScheme.surfaceVariant : null,
        leading: Text(
          formatDateTime(dayEvent.from, dayEvent.to),
        ),
        title: Text(dayEvent.name),
        subtitle: Text(dayEvent.category),
        trailing: healthModel != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (healthModel.averageHeartRate != null) ...[
                    const Icon(Icons.monitor_heart),
                    Text(healthModel.averageHeartRate.toString()),
                    const SizedBox(width: 4),
                  ],
                  if (healthModel.totalSteps != null) ...[
                    const Icon(Icons.local_fire_department),
                    Text(healthModel.totalSteps.toString()),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ],
              )
            : const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
        onTap: () => context.push(viewEventRoute, extra: {'dayEvent': dayEvent}),
      ),
    );
  }
}
