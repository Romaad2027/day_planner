import 'package:day_planner/features/profile/models/health_thresholds.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String uid;
  final String name;
  final String phoneNumber;
  final HealthThresholds healthThresholds;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.healthThresholds,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        uid: json['uid'],
        name: json['name'] ?? '',
        phoneNumber: json['phone_number'],
        healthThresholds: HealthThresholds.fromJson(json['health_thresholds']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'phone_number': phoneNumber,
        'health_thresholds': healthThresholds.toJson(),
      };

  @override
  List<Object?> get props => [
        uid,
        name,
        phoneNumber,
        healthThresholds,
      ];
}
