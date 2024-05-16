import 'package:day_planner/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    required void Function(String, int?) codeSent,
    required void Function(FirebaseAuthException) verificationFailed,
  });

  Future<void> signInWithSmsCode({required String verificationId, required String smsCode});

  Future<void> logOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  const AuthRepositoryImpl(this.authService);

  @override
  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    required void Function(String, int?) codeSent,
    required void Function(FirebaseAuthException) verificationFailed,
  }) async {
    await authService.verifyPhoneNumber(
      phoneNumber,
      codeSent: codeSent,
      verificationFailed: verificationFailed,
    );
  }

  @override
  Future<void> signInWithSmsCode({required String verificationId, required String smsCode}) async {
    try {
      await authService.signInWithSmsCode(verificationId: verificationId, smsCode: smsCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await authService.logOut();
    } catch (e) {
      rethrow;
    }
  }
}
