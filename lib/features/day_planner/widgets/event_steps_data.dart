import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/widgets/data_container.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventStepsData extends StatefulWidget {
  final HealthModel healthModel;
  const EventStepsData({required this.healthModel, super.key});

  @override
  State<EventStepsData> createState() => _EventStepsDataState();
}

class _EventStepsDataState extends State<EventStepsData> {
  bool _isExpanded = false;
  final int _collapseLimit = 6;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final length = widget.healthModel.steps?.length;
    return DataContainer(
      child: widget.healthModel.steps != null && widget.healthModel.steps!.isNotEmpty
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
                      widget.healthModel.totalSteps.toString(),
                      style: context.textStyle(TextScale.bodyLarge),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (_isExpanded || (length ?? 0) <= _collapseLimit) ? length : _collapseLimit,
                  itemBuilder: (context, index) {
                    final steps = widget.healthModel.steps![index];
                    return Opacity(
                      opacity: !_isExpanded && index == _collapseLimit - 1 ? 0.2 : 1,
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(DateFormat('HH:mm').format(steps.dateTime)),
                            const SizedBox(width: 4),
                            const Text('-'),
                            const SizedBox(width: 4),
                            Text(steps.steps.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (widget.healthModel.steps!.length > _collapseLimit)
                  TextButton(
                    onPressed: _toggleExpand,
                    child: Row(
                      children: [
                        Icon(_isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded),
                        Text(_isExpanded ? 'Collapse' : 'Expand'),
                      ],
                    ),
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
