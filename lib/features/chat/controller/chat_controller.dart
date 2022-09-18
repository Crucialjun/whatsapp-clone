import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

import 'package:whatsapp_ui/features/chat/repositories/chat_repository.dart';
import 'package:whatsapp_ui/models/chat_contact.dart';
import 'package:whatsapp_ui/models/message_model.dart';

import '../../../models/user_model.dart';

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContact() {
    return chatRepository.getChatContacts();
  }

  Stream<List<MessageModel>> chatStream(String receiverUid) {
    return chatRepository.getChatStream(receiverUid);
  }

  void sendTextMessage(
      BuildContext context, String message, String receiverUid) async {
    UserModel? sender = await ref.read(authControllerProvider).getUserData();
    ref.read(userAuthProvider).when(
        data: (value) {
          chatRepository.sendMessage(
              context: context,
              message: message,
              receiverId: receiverUid,
              sender: sender!);
        },
        error: (error, trace) {
          showSnackbar(context, error.toString());
        },
        loading: () {});
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageType,
  }) async {
    UserModel? sender = await ref.read(authControllerProvider).getUserData();
    ref.read(userAuthProvider).when(
        data: (value) {
          chatRepository.sendFileMessage(
              context: context,
              receiverUserId: receiverUserId,
              messageType: messageType,
              file: file,
              ref: ref,
              sender: sender!);
        },
        error: (error, trace) {
          showSnackbar(context, error.toString());
        },
        loading: () {});
  }

  void sendGifMessage(
      {required BuildContext context,
      required String gifUrl,
      required String receiverUid}) async {
    UserModel? sender = await ref.read(authControllerProvider).getUserData();

    int gifPartIndex = gifUrl.lastIndexOf("-") + 1;
    String gifUrlPart = gifUrl.substring(gifPartIndex);
    String fullGifUrl = "https://i.giphy.com/media/$gifUrlPart/200.gif";

    ref.read(userAuthProvider).when(
        data: (value) {
          chatRepository.sendGifMessage(
              context: context,
              gifUrl: fullGifUrl,
              receiverId: receiverUid,
              sender: sender!);
        },
        error: (error, trace) {
          showSnackbar(context, error.toString());
        },
        loading: () {});
  }
}

final chatControllerProvider = Provider(((ref) {
  return ChatController(
    chatRepository: ref.watch(chatRepositoryProvider),
    ref: ref,
  );
}));
