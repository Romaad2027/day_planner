import 'package:day_planner/features/health/services/health.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'health_event.dart';
part 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HealthService _healthService;

  HealthBloc(this._healthService) : super(const HealthState()) {
    on<InitHealth>(_onInitHealth);
  }

  Future<void> _onInitHealth(InitHealth event, Emitter emit) async {
    try {
      _healthService.init();
      final allowed = await _healthService.requestPermission();
      if (allowed) {
        emit(state.copyWith(healthInitStatus: HealthInitStatus.success));
      } else {
        emit(state.copyWith(healthInitStatus: HealthInitStatus.declined));
      }
    } catch (e) {
      emit(state.copyWith(healthInitStatus: HealthInitStatus.error));
    }
  }
}
