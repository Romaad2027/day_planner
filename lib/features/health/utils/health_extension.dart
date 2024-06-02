import 'package:health/health.dart';

extension HealthDataTypeExt on HealthDataType {
  bool get isSteps => this == HealthDataType.STEPS;
  bool get isHeartRate => this == HealthDataType.HEART_RATE;
  bool get isKcal => this == HealthDataType.ACTIVE_ENERGY_BURNED;
}
