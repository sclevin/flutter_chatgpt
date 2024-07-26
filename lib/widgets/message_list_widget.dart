import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/models/message.dart';
import 'package:flutter_chatgpt/states/message_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'message_item_widget.dart';

class MessageListWidget extends HookConsumerWidget {
  const MessageListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var messages = ref.watch(activeSessionMessagesProvider);
    var listController = useScrollController();

    ref.listen(activeSessionMessagesProvider, (provider, next) {
      Future.delayed(const Duration(milliseconds: 50), () {
        listController.jumpTo(listController.position.maxScrollExtent);
      });
    });
    return ListView.separated(
        controller: listController,
        itemBuilder: (context, index) {
          final message = messages[index];
          return message.sender == MessageSenderType.chatgpt
              ? ReceivedMessageItemWidget(message: message,backgroundColor: const Color(0xFFF1F1F1),)
              : SendMessageItemWidget(message: message,backgroundColor: const Color(0xFF8FE869),);
        },
        separatorBuilder: (context, index) => const Divider(
              height: 16,
          color: Colors.transparent,
            ),
        itemCount: messages.length);
  }
}
