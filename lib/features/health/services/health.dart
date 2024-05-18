import 'package:health/health.dart';

class HealthService {
  final Health _health = Health();

  final types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
  ];

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
}
