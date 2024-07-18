import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/message.dart';
import '../states/message_state.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
class ChatPage extends HookConsumerWidget {
   ChatPage({super.key});

   final _textController = TextEditingController();


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final messages= ref.watch(messageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [

            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return MessageItem(message: messages[index],);
                  },
                  separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                  itemCount: messages.length),
            ),

            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  onPressed: (){
                    if(_textController.text.isNotEmpty){
                      _sendMessage(ref, _textController.text);

                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendMessage(WidgetRef ref, String content) {
    var message = Message(content, MessageSenderType.user, DateTime.now());
    ref.read(messageProvider.notifier).addMessage(message);
    _textController.clear();
  }
}


class MessageItem extends StatelessWidget {
  final Message message;
  const MessageItem({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: message.sender == MessageSenderType.user ? Text("A") : Text("GPT"),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(message.content),
      ],
    );
  }
}

