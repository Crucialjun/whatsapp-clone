import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_ui/features/auth/repository/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository;
  final ProviderRef ref;

  AuthController(
    this._authRepository,
    this.ref,
  );

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
}

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository, ref);
});
