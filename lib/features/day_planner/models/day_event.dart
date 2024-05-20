import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:equatable/equatable.dart';

class DayEvent extends Equatable {
  final String name;
  final String category;
  final DateTime from;
  final DateTime to;

  final HealthModel? healthModel;

  const DayEvent({
    required this.name,
    required this.category,
    required this.from,
    required this.to,
    required this.healthModel,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'from': from,
        'to': to,
        'health_model': healthModel?.toJson(),
      };

  factory DayEvent.fromJson(Map<String, dynamic> json) {
    return DayEvent(
      name: json['name'],
      category: json['category'],
      from: (json['from'] as Timestamp).toDate(),
      to: (json['to'] as Timestamp).toDate(),
      healthModel: json['health_model'] != null ? HealthModel.fromJson(json['health_model']) : null,
    );
  }

  @override
  List<Object?> get props => [
        name,
        category,
        from,
        to,
      ];
}
