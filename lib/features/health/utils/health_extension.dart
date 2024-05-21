import 'package:health/health.dart';

extension HealthDataTypeExt on HealthDataType {
  bool get isSteps => this == HealthDataType.STEPS;
  bool get isHeartRate => this == HealthDataType.HEART_RATE;
  bool get isBloodPressure => this == HealthDataType.BLOOD_PRESSURE_DIASTOLIC;
}
