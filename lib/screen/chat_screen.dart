import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/states/session_state.dart';
import 'package:flutter_chatgpt/widgets/chat_gpt_model_widget.dart';
import 'package:flutter_chatgpt/widgets/chat_input_widget.dart';
import 'package:flutter_chatgpt/widgets/message_list_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../states/chat_ui_state.dart';


/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
class ChatScreen extends HookConsumerWidget {
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession = ref.watch(activeSessionProvider);

    return  Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        children: [
          GptModelWidget(
            active: activeSession?.model,
            onModelChange: (model) {
              ref.read(chatUiProvider.notifier).model = model;
            },
          ),
          const Expanded(
            child: MessageListWidget(),
          ),
          const ChatInputWidget()
        ],
      ),
    );
  }
}
