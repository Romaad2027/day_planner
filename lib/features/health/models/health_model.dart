import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/features/health/models/heart_rate.dart';
import 'package:day_planner/features/health/models/steps.dart';
import 'package:equatable/equatable.dart';

class HealthModel extends Equatable {
  final List<Steps>? steps;
  final List<HeartRate>? heartRate;
  final int? bloodPressure;

  final int? totalSteps;
  final int? averageHeartRate;

  const HealthModel({
    this.averageHeartRate,
    this.totalSteps,
    this.steps,
    this.bloodPressure,
    this.heartRate,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) {
    return HealthModel(
      steps: List.from(json['steps']).map((e) => Steps.fromJson(e)).toList(),
      heartRate: List.from(json['heart_rate']).map((e) => HeartRate.fromJson(e)).toList(),
      bloodPressure: json['bloodPressure'],
      totalSteps: json['total_steps'],
      averageHeartRate: json['average_heart_rate'],
    );
  }

  factory HealthModel.fromHealthData(List<Steps> steps, List<HeartRate> heartRates) {
    final totalSteps = calculateTotalSteps(steps);
    final averageHeartRate = calculateAverageHeartRate(heartRates);
    return HealthModel(
      steps: steps,
      heartRate: heartRates,
      totalSteps: totalSteps,
      averageHeartRate: averageHeartRate,
    );
  }

  Map<String, dynamic> toJson() => {
        'steps': steps?.map((e) => e.toJson()),
        'heart_rate': heartRate?.map((e) => e.toJson()),
        'total_steps': totalSteps,
        'average_heart_rate': averageHeartRate,
        'blood_pressure': bloodPressure,
      };

  @override
  List<Object?> get props => [
        steps,
        heartRate,
        bloodPressure,
        totalSteps,
        averageHeartRate,
      ];
}
