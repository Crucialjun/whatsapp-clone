import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/models/user_model.dart';
import 'package:whatsapp_ui/screens/mobile_chat_screen.dart';

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository(this.firestore);

  getContact() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return contacts;
  }

  void selectContact(
      {required BuildContext context, required Contact selectedContact}) async {
    try {
      var userColecction = await firestore.collection('users').get();
      bool isFound = false;

      for (var user in userColecction.docs) {
        var userData = UserModel.fromMap(user.data());
        String selectedPhoneNumber =
            selectedContact.phones[0].number.replaceAll(" ", "");
        if (userData.phoneNumber == selectedPhoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName,
              arguments: {'name': userData.name, 'uid': userData.uid});
        }
      }

      if (!isFound) {
        showSnackbar(context, 'User not found');
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}

final selectContactsRepositoryProvider = Provider((ref) {
  return SelectContactRepository(FirebaseFirestore.instance);
});
