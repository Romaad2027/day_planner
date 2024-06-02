import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:health/health.dart';

class Kcal extends Equatable {
  final double kcal;
  final DateTime dateTime;

  const Kcal({required this.dateTime, required this.kcal});

  factory Kcal.fromHealthDataPoint(HealthDataPoint healthDataPoint) => Kcal(
        dateTime: healthDataPoint.dateTo,
        kcal: (healthDataPoint.value as NumericHealthValue).numericValue.toDouble(),
      );

  factory Kcal.fromJson(Map<String, dynamic> json) {
    return Kcal(
      dateTime: (json['date_time'] as Timestamp).toDate(),
      kcal: json['steps'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date_time': dateTime,
        'steps': kcal,
      };

  @override
  List<Object?> get props => [kcal, dateTime];
}
