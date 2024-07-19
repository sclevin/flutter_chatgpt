import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/message.dart';
import '../states/chat_ui_state.dart';
import '../states/message_state.dart';
import 'message_item.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
class ChatPage extends HookConsumerWidget {
   ChatPage({super.key});

   final _textController = TextEditingController();


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final messages= ref.watch(messageProvider);
    final chatUiState = ref.watch(chatUiProvider);

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
              enabled: !chatUiState.onLoading,
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
    _requestChatGPT(ref, content);
  }


  void _requestChatGPT(WidgetRef ref, String content) async {
    ref.read(chatUiProvider.notifier).setLoading(true);

    try {
      final res =  await chatService.sendMessage(content);

      final msg = res.choices.first.message?.content ?? "";
      final message = Message(msg, MessageSenderType.chatgpt, DateTime.now());
      ref.read(messageProvider.notifier).addMessage(message);
    } catch (e) {
      // logger.e(e);
    } finally {
      ref.read(chatUiProvider.notifier).setLoading(false);

    }

  }
}


