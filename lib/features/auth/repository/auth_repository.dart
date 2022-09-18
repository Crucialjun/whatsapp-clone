import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatsapp_ui/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_ui/models/user_model.dart';
import 'package:whatsapp_ui/screens/mobile_layout_screen.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository(this.auth, this.firestore);

  Stream checkUserAuthState() {
    return auth.authStateChanges();
  }

  Future<UserModel?> getCurrentUserData() async {
    final userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            //await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: ((verificationId, forceResendingToken) {
            Navigator.pushNamed(context, OtpScreen.routeName,
                arguments: verificationId);
          }),
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

  void verifyOtp(
      BuildContext context, String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await auth.signInWithCredential(credential).then((value) {
        Navigator.pushNamedAndRemoveUntil(
            context, UserInformationScreen.routeName, (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

  void saveUserDataToFirebase(
      {required BuildContext context,
      required String name,
      File? profilePic,
      required ProviderRef ref}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          "https://firebasestorage.googleapis.com/v0/b/whatsappclone-ede88.appspot.com/o/avatar.png?alt=media&token=fbc76b2a-a8ae-4561-89b3-b6255e3a2ef8";
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFiletoFirebase(ref: "profilePic/$uid", file: profilePic);
      }

      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: []);

      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLayoutScreen()),
          (route) => false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Stream<UserModel> userData(String userid) {
    return firestore.collection('users').doc(userid).snapshots().map((event) {
      return UserModel.fromMap(event.data()!);
    });
  }

  void setUserState(bool isOnline) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }
}

final authRepositoryProvider = Provider(((ref) => AuthRepository(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    )));
