import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
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
  Widget build(BuildContext context,WidgetRef ref) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push('/history');
            },
            icon: const Icon(Icons.history),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [

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


