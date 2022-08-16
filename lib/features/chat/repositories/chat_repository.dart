import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/models/chat_contact.dart';
import 'package:whatsapp_ui/models/user_model.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  void sendMessage({
    required BuildContext context,
    required String message,
    required String receiverId,
    required UserModel sender,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel receiverUserData;
      var messageId = const Uuid().v4();

      var receiverDataSnapshot =
          await firestore.collection('users').doc(receiverId).get();

      receiverUserData = UserModel.fromMap(receiverDataSnapshot.data()!);

      _saveDataToContactsSubCollection(
          sender: sender,
          receiver: receiverUserData,
          message: message,
          timeSent: timeSent);

      _saveMessageToMessageSubCollection(
          sender: sender,
          receiver: receiverUserData,
          message: message,
          timeSent: timeSent,
          messageType: MessageEnum.text,
          messageId: messageId);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void _saveDataToContactsSubCollection(
      {required UserModel sender,
      required UserModel receiver,
      required String message,
      required DateTime timeSent}) async {
    ChatContact receiverChatContact = ChatContact(
      name: sender.name,
      profilePicture: sender.profilePic,
      contactId: sender.uid,
      timeSent: timeSent,
      lastMessage: message,
    );

    await firestore
        .collection('users')
        .doc(receiver.uid)
        .collection('chats')
        .doc(sender.uid)
        .set(receiverChatContact.toMap());

    ChatContact senderChatContact = ChatContact(
      name: receiver.name,
      profilePicture: receiver.profilePic,
      contactId: receiver.uid,
      timeSent: timeSent,
      lastMessage: message,
    );

    await firestore
        .collection('users')
        .doc(sender.uid)
        .collection('chats')
        .doc(receiver.uid)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToMessageSubCollection({
    required UserModel receiver,
    required String message,
    required DateTime timeSent,
    required String messageId,
    required UserModel sender,
    required MessageEnum messageType,
  }) async {}
}
