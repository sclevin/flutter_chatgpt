import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/states/session_state.dart';
import 'package:flutter_chatgpt/widgets/chat_gpt_model_widget.dart';
import 'package:flutter_chatgpt/widgets/message_list_widget.dart';
import 'package:flutter_chatgpt/widgets/user_input_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/message.dart';
import '../states/chat_ui_state.dart';
import '../states/message_state.dart';
import 'message_item_widget.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
class ChatPage extends HookConsumerWidget {
  ChatPage({super.key});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession = ref.watch(activeSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push('/history');
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(
              onPressed: () {
                ref
                    .read(sessionStateNotifierProvider.notifier)
                    .setActiveSession(null);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
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
            UserInputWidget()
          ],
        ),
      ),
    );
  }
}
