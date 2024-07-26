import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../states/chat_ui_state.dart';
import 'chat_input_widget.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/26

class TextInputWidget extends HookConsumerWidget {
  const TextInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final uiState = ref.watch(chatUiProvider);
    return TextField(
      enabled: !uiState.onLoading,
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Type a message', // 显示在输入框内的提示文字
          suffixIcon: IconButton(
            onPressed: () {
              // 这里处理发送事件
              if (controller.text.isNotEmpty) {
                sendMessage(ref, controller);
              }
            },
            icon: const Icon(
              Icons.send,
            ),
          )),
    );
  }
}
