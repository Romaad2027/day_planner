part of 'auth_bloc.dart';

enum LoginStatus {
  initial,
  error,
  success,
  loading,
  codeSent;

  bool get isSuccess => this == LoginStatus.success;

  bool get isInitial => this == LoginStatus.initial;

  bool get isError => this == LoginStatus.error;

  bool get isLoading => this == LoginStatus.loading;

  bool get isCodeSent => this == LoginStatus.codeSent;
}

enum AuthStatus {
  loggedIn,
  loggedOut;

  bool get isLoggedIn => this == AuthStatus.loggedIn;

  bool get isLoggedOut => this == AuthStatus.loggedOut;
}

class AuthState extends Equatable {
  final String? phoneNumber;
  final String verificationId;
  final LoginStatus loginStatus;
  final AuthStatus authStatus;

  const AuthState({
    this.phoneNumber = '',
    this.verificationId = '',
    this.loginStatus = LoginStatus.initial,
    this.authStatus = AuthStatus.loggedOut,
  });

  AuthState copyWith({
    String? phoneNumber,
    String? verificationId,
    LoginStatus? loginStatus,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationId: verificationId ?? this.verificationId,
      loginStatus: loginStatus ?? this.loginStatus,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        verificationId,
        loginStatus,
        authStatus,
      ];
}
