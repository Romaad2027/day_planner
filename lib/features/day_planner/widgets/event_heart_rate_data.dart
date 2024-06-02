import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/widgets/data_container.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventHeartRateData extends StatefulWidget {
  final HealthModel healthModel;
  const EventHeartRateData({required this.healthModel, super.key});

  @override
  State<EventHeartRateData> createState() => _EventHeartRateDataState();
}

class _EventHeartRateDataState extends State<EventHeartRateData> {
  bool _isExpanded = false;
  final int _collapseLimit = 6;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final length = widget.healthModel.heartRate?.length;
    return DataContainer(
      child: widget.healthModel.heartRate != null && widget.healthModel.heartRate!.isNotEmpty
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
                      widget.healthModel.averageHeartRate.toString(),
                      style: context.textStyle(TextScale.bodyLarge),
                    ),
                  ],
                ),
                //const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (_isExpanded && (length ?? 0) >= _collapseLimit) ? length : _collapseLimit,
                  itemBuilder: (context, index) {
                    final heartRate = widget.healthModel.heartRate![index];
                    return Opacity(
                      opacity: !_isExpanded && index == _collapseLimit - 1 ? 0.2 : 1,
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(DateFormat('HH:mm').format(heartRate.dateTime)),
                            const SizedBox(width: 4),
                            const Text('-'),
                            const SizedBox(width: 4),
                            Text(heartRate.heartRate.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (widget.healthModel.heartRate!.length > _collapseLimit)
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
