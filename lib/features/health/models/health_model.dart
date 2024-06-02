import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/features/health/models/heart_rate.dart';
import 'package:day_planner/features/health/models/kcal.dart';
import 'package:day_planner/features/health/models/steps.dart';
import 'package:equatable/equatable.dart';

class HealthModel extends Equatable {
  final List<Steps>? steps;
  final List<HeartRate>? heartRate;
  final List<Kcal>? kcal;
  final int? bloodPressure;

  final int? totalSteps;
  final int? averageHeartRate;
  final double? totalKcal;

  const HealthModel({
    this.averageHeartRate,
    this.totalSteps,
    this.steps,
    this.bloodPressure,
    this.heartRate,
    this.kcal,
    this.totalKcal,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) {
    return HealthModel(
      steps: List.from(json['steps']).map((e) => Steps.fromJson(e)).toList(),
      heartRate: List.from(json['heart_rate']).map((e) => HeartRate.fromJson(e)).toList(),
      kcal: List.from(json['kcal'] ?? []).map((e) => Kcal.fromJson(e)).toList(),
      bloodPressure: json['bloodPressure'],
      totalSteps: json['total_steps'],
      totalKcal: json['total_kcal'],
      averageHeartRate: json['average_heart_rate'],
    );
  }

  factory HealthModel.fromHealthData(List<Steps> steps, List<HeartRate> heartRates, List<Kcal> kcal) {
    final totalSteps = calculateTotalSteps(steps);
    final totalKcal = calculateTotalKcal(kcal);
    final averageHeartRate = calculateAverageHeartRate(heartRates);
    return HealthModel(
      steps: steps,
      heartRate: heartRates,
      kcal: kcal,
      totalSteps: totalSteps,
      totalKcal: totalKcal,
      averageHeartRate: averageHeartRate,
    );
  }

  Map<String, dynamic> toJson() => {
        'steps': steps?.map((e) => e.toJson()),
        'heart_rate': heartRate?.map((e) => e.toJson()),
        'kcal': kcal?.map((e) => e.toJson()),
        'total_steps': totalSteps,
        'total_kcal': totalKcal,
        'average_heart_rate': averageHeartRate,
        'blood_pressure': bloodPressure,
      };

  @override
  List<Object?> get props => [
        steps,
        heartRate,
        kcal,
        bloodPressure,
        totalSteps,
        totalKcal,
        averageHeartRate,
      ];
}
