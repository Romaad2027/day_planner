import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String uid;
  final String name;
  final String phoneNumber;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.phoneNumber,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        uid: json['uid'],
        name: json['name'] ?? '',
        phoneNumber: json['phone_number'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'phone_number': phoneNumber,
      };

  @override
  List<Object?> get props => [
        uid,
        name,
        phoneNumber,
      ];
}
