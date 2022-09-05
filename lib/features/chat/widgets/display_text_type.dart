import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/features/chat/widgets/video_player.item.dart';

class DisplayTextType extends StatelessWidget {
  final String message;
  final MessageEnum messageType;
  const DisplayTextType({
    Key? key,
    required this.message,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return messageType == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : messageType == MessageEnum.image
            ? CachedNetworkImage(imageUrl: message)
            : VideoPlayerItem(videoUrl: message);
  }
}
