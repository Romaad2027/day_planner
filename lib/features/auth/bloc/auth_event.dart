part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class VerifyPhoneNumber extends AuthEvent {
  final PhoneNumber phoneNumber;

  const VerifyPhoneNumber(this.phoneNumber);
}

class UpdatePhoneToken extends AuthEvent {
  final String verificationId;

  const UpdatePhoneToken(this.verificationId);
}

class SignInWithSmsCode extends AuthEvent {
  final String smsCode;

  const SignInWithSmsCode(this.smsCode);
}

class SignInWithPhoneNumberFailed extends AuthEvent {
  const SignInWithPhoneNumberFailed();
}

class SetAuthStatus extends AuthEvent {
  final AuthStatus status;
  const SetAuthStatus(this.status);
}

class LogOut extends AuthEvent {
  const LogOut();
}
