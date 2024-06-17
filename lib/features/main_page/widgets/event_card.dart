import 'package:day_planner/common/router.dart';
import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/main_page/widgets/schedule_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventCard extends StatelessWidget {
  final DayEvent event;
  final Color? cardColor;

  const EventCard({
    super.key,
    required this.event,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final healthModel = event.healthModel;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: cardMarginVertical, horizontal: cardMarginHorizontal),
      child: GestureDetector(
        onTap: () => context.push(viewEventRoute, extra: {'dayEvent': event}),
        child: Card(
          color: cardColor ?? colorScheme.primary,
          child: ClipRect(
            child: Container(
              padding: cardPadding,
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: double.infinity, // Ensure the container takes full height of the card
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            '${event.from.hour}:${event.from.minute.toString().padLeft(2, '0')} - ${event.to.hour}:${event.to.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      if (healthModel != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (healthModel.averageHeartRate != null) ...[
                              Icon(
                                Icons.monitor_heart,
                                color: colorScheme.onPrimary,
                                size: 20,
                              ),
                              Text(
                                healthModel.averageHeartRate.toString(),
                                style: context.textStyle(TextScale.labelMedium, color: colorScheme.onPrimary),
                              ),
                              const SizedBox(width: 4),
                            ],
                            if (healthModel.totalSteps != null) ...[
                              Icon(
                                Icons.local_fire_department,
                                color: colorScheme.onPrimary,
                                size: 20,
                              ),
                              Text(
                                healthModel.totalSteps.toString(),
                                style: context.textStyle(TextScale.labelMedium, color: colorScheme.onPrimary),
                              ),
                            ],
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
