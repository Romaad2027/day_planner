import 'package:day_planner/features/profile/bloc/profile_event.dart';
import 'package:day_planner/features/profile/bloc/profile_state.dart';
import 'package:day_planner/features/profile/repositories/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(const ProfileState()) {
    on<AddUser>(_onAddUser);
    on<ListenToUser>(_onListenToUser);
    on<FetchUser>(_onFetchUser);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onAddUser(AddUser event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      await _profileRepository.addProfile(event.user);
      emit(state.copyWith(profileStatus: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }

  void _onListenToUser(ListenToUser event, Emitter<ProfileState> emit) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    _profileRepository.fetchUser(uid).snapshots().listen((userProfileSnap) {
      add(FetchUser(userProfileSnap.docs.first.data()));
    });
  }

  void _onFetchUser(FetchUser event, Emitter<ProfileState> emit) {
    emit(state.copyWith(userProfile: event.userProfile));
  }

  void _onUpdateUser(UpdateUser event, Emitter<ProfileState> emit) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      final data = {
        'name': event.name,
      };
      await _profileRepository.updateUser(uid, data);
      emit(state.copyWith(profileStatus: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }
}
