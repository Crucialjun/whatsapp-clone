import 'dart:convert';

import 'package:whatsapp_ui/common/enums/message_enum.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final MessageEnum messageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  MessageModel copyWith({
    String? senderId,
    String? receiverId,
    String? message,
    MessageEnum? messageType,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'message': message});
    result.addAll({'messageType': messageType.type});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'messageId': messageId});
    result.addAll({'isSeen': isSeen});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      message: map['message'] ?? '',
      messageType: MessageEnum.values.byName(map['messageType']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(senderId: $senderId, receiverId: $receiverId, message: $message, messageType: $messageType, timeSent: $timeSent, messageId: $messageId, isSeen: $isSeen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.message == message &&
        other.messageType == messageType &&
        other.timeSent == timeSent &&
        other.messageId == messageId &&
        other.isSeen == isSeen;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        receiverId.hashCode ^
        message.hashCode ^
        messageType.hashCode ^
        timeSent.hashCode ^
        messageId.hashCode ^
        isSeen.hashCode;
  }
}
