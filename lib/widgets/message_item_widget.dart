import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/widgets/message_content_widget.dart';

import '../models/message.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/19
class MessageItemWidget extends StatelessWidget {
  final Message message;
  const MessageItemWidget({super.key,required this.message});

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
              margin: const EdgeInsets.only(right: 48),
              child: MessageContentWidget(message:message),
            )
        ),
      ],
    );
  }
}

