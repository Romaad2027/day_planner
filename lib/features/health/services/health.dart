import 'package:health/health.dart';

enum HealthDataAggregateMethod {
  sum,
  average;

  bool get isSum => this == HealthDataAggregateMethod.sum;
  bool get isAverage => this == HealthDataAggregateMethod.average;
}

class HealthService {
  final Health _health = Health();

  final types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  static const Map<HealthDataType, HealthDataAggregateMethod> methods = {
    HealthDataType.STEPS: HealthDataAggregateMethod.sum,
    HealthDataType.HEART_RATE: HealthDataAggregateMethod.average,
    HealthDataType.ACTIVE_ENERGY_BURNED: HealthDataAggregateMethod.sum,
  };

  Future<void> init() async {
    try {
      _health.configure(useHealthConnectIfAvailable: true);
      await _health.requestAuthorization(types);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> requestPermission() async {
    try {
      final requested = await _health.hasPermissions(types);
      return requested ?? true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<HealthDataPoint>> fetchHealthData(DateTime from, DateTime to) async {
    List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(types: types, startTime: from, endTime: to);
    return healthData;
  }
}
