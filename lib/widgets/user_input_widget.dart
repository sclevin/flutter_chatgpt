import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/states/chat_ui_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../injection.dart';
import '../models/message.dart';
import '../states/message_state.dart';

class UserInputWidget extends HookConsumerWidget {
  const UserInputWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final chatUiState = ref.watch(chatUiProvider);
    final textController = useTextEditingController();

    return TextField(
      enabled: !chatUiState.onLoading,
      controller: textController,
      decoration: InputDecoration(
        hintText: 'Type a message',
        suffixIcon: IconButton(
          onPressed: (){
            if(textController.text.isNotEmpty){
              _sendMessage(ref, textController);
            }
          },
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }



  void _sendMessage(WidgetRef ref,TextEditingController textController) {
    var content = textController.text;
    var message = Message(uuid.v4(),content, MessageSenderType.user, DateTime.now());
    ref.read(messageProvider.notifier).updateMessage(message);
    textController.clear();
    _requestChatGPT(ref, content);
  }


  void _requestChatGPT(WidgetRef ref, String content) async {
    ref.read(chatUiProvider.notifier).setLoading(true);

    try {
      final messageId = uuid.v4();
      final res =  await chatService.sendMessage(content);

      final msg = res.choices.first.message?.content ?? "";
      final message = Message(messageId,msg, MessageSenderType.chatgpt, DateTime.now());
      ref.read(messageProvider.notifier).updateMessage(message);
    } catch (e) {
      // logger.e(e);
    } finally {
      ref.read(chatUiProvider.notifier).setLoading(false);
    }
  }

}
