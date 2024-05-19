import 'package:day_planner/common/services/logger.dart';
import 'package:day_planner/features/auth/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<VerifyPhoneNumber>(_onVerifyPhoneNumber);
    on<UpdatePhoneToken>(_onUpdatePhoneToken);
    on<SignInWithSmsCode>(_onSignInWithSmsCode);
    on<SignInWithPhoneNumberFailed>(_onSignInWithPhoneNumberFailed);
    on<LogOut>(_onLogOut);
    on<SetAuthStatus>(_onSetAuthStatus);

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        add(const SetAuthStatus(AuthStatus.loggedOut));
      }
    });
  }

  Future<void> _onVerifyPhoneNumber(VerifyPhoneNumber event, Emitter emit) async {
    try {
      log.fine('started');
      emit(state.copyWith(loginStatus: LoginStatus.loading));
      _authRepository.verifyPhoneNumber(
        event.phoneNumber.phoneNumber!,
        codeSent: (verificationId, resendToken) {
          add(UpdatePhoneToken(verificationId));
        },
        verificationFailed: (firebaseException) {
          log.fine(firebaseException);
          add(const SignInWithPhoneNumberFailed());
        },
      );
    } catch (e) {
      log.fine('catched');
      emit(state.copyWith(loginStatus: LoginStatus.error));
    }
  }

  void _onSignInWithPhoneNumberFailed(SignInWithPhoneNumberFailed event, Emitter emit) {
    emit(state.copyWith(loginStatus: LoginStatus.error));
  }

  Future<void> _onUpdatePhoneToken(UpdatePhoneToken event, Emitter emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.codeSent, verificationId: event.verificationId));
  }

  Future<void> _onSignInWithSmsCode(SignInWithSmsCode event, Emitter emit) async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.loading));
      final isNewUser =
          await _authRepository.signInWithSmsCode(verificationId: state.verificationId, smsCode: event.smsCode);
      emit(state.copyWith(loginStatus: LoginStatus.success, isNewUser: isNewUser));
    } catch (e) {
      emit(state.copyWith(loginStatus: LoginStatus.error));
    }
  }

  Future<void> _onLogOut(LogOut event, Emitter emit) async {
    try {
      _authRepository.logOut();
    } catch (e) {
      emit(state.copyWith(loginStatus: LoginStatus.error));
    }
  }

  void _onSetAuthStatus(SetAuthStatus event, Emitter emit) {
    emit(state.copyWith(authStatus: event.status));
  }
}
