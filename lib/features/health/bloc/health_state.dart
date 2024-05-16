part of 'health_bloc.dart';

enum HealthInitStatus {
  initial,
  loading,
  success,
  declined,
  error;

  bool get isInitial => this == HealthInitStatus.initial;
  bool get isLoading => this == HealthInitStatus.loading;
  bool get isSuccess => this == HealthInitStatus.success;
  bool get isDeclined => this == HealthInitStatus.declined;
  bool get isError => this == HealthInitStatus.error;
}

class HealthState extends Equatable {
  final HealthInitStatus healthInitStatus;

  const HealthState({
    this.healthInitStatus = HealthInitStatus.initial,
  });

  HealthState copyWith({HealthInitStatus? healthInitStatus}) => HealthState(
        healthInitStatus: healthInitStatus ?? this.healthInitStatus,
      );

  @override
  List<Object?> get props => [
        healthInitStatus,
      ];
}
