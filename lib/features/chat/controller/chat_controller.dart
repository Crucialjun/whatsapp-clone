import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}

final chatControllerProvider = Provider(((ref) {
  return ChatController(
    chatRepository: ref.watch(chatRepositoryProvider),
    ref: ref,
  );
}));
