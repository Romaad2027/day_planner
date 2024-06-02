import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/widgets/data_container.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:flutter/material.dart';

class EventKcalData extends StatelessWidget {
  final HealthModel healthModel;
  const EventKcalData({required this.healthModel, super.key});

  @override
  Widget build(BuildContext context) {
    return DataContainer(
      child: healthModel.totalKcal != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kcal',
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
                      healthModel.totalKcal!.toStringAsFixed(2),
                      style: context.textStyle(TextScale.bodyLarge),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_fire_department),
                  const SizedBox(width: 8),
                  Text(
                    'No Kcal data',
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
