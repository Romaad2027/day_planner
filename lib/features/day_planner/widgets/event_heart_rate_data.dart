import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/widgets/data_container.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventHeartRateData extends StatelessWidget {
  final HealthModel healthModel;
  const EventHeartRateData({required this.healthModel, super.key});

  @override
  Widget build(BuildContext context) {
    return DataContainer(
      child: healthModel.heartRate != null && healthModel.heartRate!.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heart Rate',
                  style: context.textStyle(TextScale.titleLarge),
                ),
                const SizedBox(height: 4),
                Divider(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.monitor_heart),
                    const SizedBox(width: 4),
                    Text(
                      'Average:',
                      style: context.textStyle(TextScale.bodyLarge),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      healthModel.averageHeartRate.toString(),
                      style: context.textStyle(TextScale.bodyLarge),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: healthModel.heartRate?.length,
                  itemBuilder: (context, index) {
                    final heartRate = healthModel.heartRate![index];
                    return ListTile(
                      title: Row(
                        children: [
                          Text(DateFormat('HH:mm').format(heartRate.dateTime)),
                          const SizedBox(width: 4),
                          const Text('-'),
                          const SizedBox(width: 4),
                          Text(heartRate.heartRate.toString()),
                        ],
                      ),
                    );
                  },
                )
              ],
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monitor_heart),
                  const SizedBox(width: 8),
                  Text(
                    'No heart rate data',
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
