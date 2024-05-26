import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/widgets/data_container.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventStepsData extends StatelessWidget {
  final HealthModel healthModel;
  const EventStepsData({required this.healthModel, super.key});

  @override
  Widget build(BuildContext context) {
    return DataContainer(
      child: healthModel.steps != null && healthModel.steps!.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Steps',
                  style: context.textStyle(TextScale.titleLarge),
                ),
                const SizedBox(height: 4),
                Divider(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department),
                    const SizedBox(width: 4),
                    Text(
                      'Total:',
                      style: context.textStyle(TextScale.bodyLarge),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      healthModel.totalSteps.toString(),
                      style: context.textStyle(TextScale.bodyLarge),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: healthModel.steps?.length,
                  itemBuilder: (context, index) {
                    final steps = healthModel.steps![index];
                    return ListTile(
                      title: Row(
                        children: [
                          Text(DateFormat('HH:mm').format(steps.dateTime)),
                          const SizedBox(width: 4),
                          const Text('-'),
                          const SizedBox(width: 4),
                          Text(steps.steps.toString()),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_fire_department),
                  const SizedBox(width: 8),
                  Text(
                    'No steps data',
                    style: context.textStyle(
                      TextScale.titleMedium,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
