import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_ui/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_ui/models/user_model.dart';

class AuthController {
  final AuthRepository _authRepository;
  final ProviderRef ref;

  AuthController(
    this._authRepository,
    this.ref,
  );

  Stream authStateChanges() {
    return _authRepository.checkUserAuthState();
  }

  Future<UserModel?> getUserData() async {
    final userData = ref.read(authRepositoryProvider).getCurrentUserData();
    return userData;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    _authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String otp) {
    _authRepository.verifyOtp(context, verificationId, otp);
  }

  void saveUserDataToFirebase(
      {required BuildContext context, required String name, File? profipic}) {
    _authRepository.saveUserDataToFirebase(
        context: context, name: name, ref: ref, profilePic: profipic);
  }

  Stream<UserModel> userDatabyId(String userId) {
    return _authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    _authRepository.setUserState(isOnline);
  }
}

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository, ref);
});

final userAuthProvider = StreamProvider((ref) {
  return ref.watch(authControllerProvider).authStateChanges();
});
