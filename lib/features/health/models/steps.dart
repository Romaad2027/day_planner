import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:health/health.dart';

class Steps extends Equatable {
  final int steps;
  final DateTime dateTime;

  const Steps({required this.dateTime, required this.steps});

  factory Steps.fromHealthDataPoint(HealthDataPoint healthDataPoint) => Steps(
        dateTime: healthDataPoint.dateTo,
        steps: (healthDataPoint.value as NumericHealthValue).numericValue.toInt(),
      );

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      dateTime: (json['date_time'] as Timestamp).toDate(),
      steps: json['steps'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date_time': dateTime,
        'steps': steps,
      };

  @override
  List<Object?> get props => [steps, dateTime];
}
