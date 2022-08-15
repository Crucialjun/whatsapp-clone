import 'package:flutter/material.dart';

import '../../../colors.dart';

class BottomChatField extends StatelessWidget {
  const BottomChatField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: mobileChatBoxColor,
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                Icons.emoji_emotions,
                color: Colors.grey,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.attach_file,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.money,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            hintText: 'Type a message!',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
        const CircleAvatar(
          backgroundColor: Color(0xFF128C7E),
        )
      ],
    );
  }
}
