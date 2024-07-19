import 'package:flutter/material.dart';

import '../models/message.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/19
class MessageItem extends StatelessWidget {
  final Message message;
  const MessageItem({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          child: message.sender == MessageSenderType.user ? Text("A") : Text("GPT"),
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
            child: Container(
              padding: const EdgeInsets.only(top: 12),
              child: Text(message.content),
            )
        ),
      ],
    );
  }
}

