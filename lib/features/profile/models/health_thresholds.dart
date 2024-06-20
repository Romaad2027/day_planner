import 'package:equatable/equatable.dart';

class HealthThresholds extends Equatable {
  final int steps;
  final int heartRate;
  final double kcal;

  const HealthThresholds({
    required this.steps,
    required this.kcal,
    required this.heartRate,
  });

  factory HealthThresholds.fromJson(Map<String, dynamic> json) => HealthThresholds(
        steps: json['steps'],
        heartRate: json['heart_rate'],
        kcal: (json['kcal']).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'steps': steps,
        'heart_rate': heartRate,
        'kcal': kcal,
      };

  @override
  List<Object?> get props => [
        steps,
        heartRate,
        kcal,
      ];
}
