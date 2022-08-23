import 'package:flutter/material.dart';

import 'package:whatsapp_ui/common/enums/message_enum.dart';

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
        : Container();
  }
}
