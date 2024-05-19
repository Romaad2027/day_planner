import 'package:day_planner/features/profile/models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileEvent {
  const ProfileEvent();
}

class AddUser extends ProfileEvent {
  final User user;
  const AddUser(this.user);
}

class ListenToUser extends ProfileEvent {
  const ListenToUser();
}

class FetchUser extends ProfileEvent {
  final UserProfile userProfile;

  const FetchUser(this.userProfile);
}

class UpdateUser extends ProfileEvent {
  final String? name;

  const UpdateUser({
    this.name,
  });
}
