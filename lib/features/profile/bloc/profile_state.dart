import 'package:day_planner/features/profile/models/user_profile.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == ProfileStatus.initial;

  bool get isLoading => this == ProfileStatus.loading;

  bool get isSuccess => this == ProfileStatus.success;

  bool get isError => this == ProfileStatus.error;
}

class ProfileState extends Equatable {
  final UserProfile? userProfile;
  final ProfileStatus profileStatus;

  const ProfileState({
    this.userProfile,
    this.profileStatus = ProfileStatus.initial,
  });

  ProfileState copyWith({
    UserProfile? userProfile,
    ProfileStatus? profileStatus,
  }) =>
      ProfileState(
        userProfile: userProfile ?? this.userProfile,
        profileStatus: profileStatus ?? this.profileStatus,
      );

  @override
  List<Object?> get props => [
        userProfile,
        profileStatus,
      ];
}
