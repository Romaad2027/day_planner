part of 'health_bloc.dart';

abstract class HealthEvent {
  const HealthEvent();
}

class InitHealth extends HealthEvent {
  const InitHealth();
}
