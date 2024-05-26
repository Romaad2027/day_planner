import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:health/health.dart';

class HeartRate extends Equatable {
  final int heartRate;
  final DateTime dateTime;

  const HeartRate({required this.dateTime, required this.heartRate});

  factory HeartRate.fromHealthDataPoint(HealthDataPoint healthDataPoint) => HeartRate(
        dateTime: healthDataPoint.dateTo,
        heartRate: (healthDataPoint.value as NumericHealthValue).numericValue.toInt(),
      );

  factory HeartRate.fromJson(Map<String, dynamic> json) {
    return HeartRate(
      dateTime: (json['date_time'] as Timestamp).toDate(),
      heartRate: json['heart_rate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date_time': dateTime,
        'heart_rate': heartRate,
      };

  @override
  List<Object?> get props => [
        heartRate,
        dateTime,
      ];
}
