import 'package:day_planner/common/utils/utils.dart';
import 'package:day_planner/common/widgets/common_app_bar.dart';
import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_planner/widgets/data_container.dart';
import 'package:day_planner/features/day_planner/widgets/event_heart_rate_data.dart';
import 'package:day_planner/features/day_planner/widgets/event_steps_data.dart';
import 'package:flutter/material.dart';

class ViewEventScreen extends StatelessWidget {
  final DayEvent dayEvent;

  const ViewEventScreen({
    required this.dayEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final healthModel = dayEvent.healthModel;
    return Scaffold(
      appBar: const CommonAppBar(
        title: Text('Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              DataContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayEvent.name,
                      style: context.textStyle(TextScale.headlineMedium, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      dayEvent.category,
                      style: context.textStyle(TextScale.titleLarge),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      formatDateTime(dayEvent.from, dayEvent.to),
                      style: context.textStyle(TextScale.titleLarge),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (healthModel != null) ...[
                EventStepsData(healthModel: healthModel),
                const SizedBox(height: 16),
                EventHeartRateData(healthModel: healthModel),
              ] else ...[
                const SizedBox(height: 64),
                Text(
                  'No health data',
                  style: context.textStyle(
                    TextScale.headlineMedium,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
