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
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintText: 'Type a message...', // 显示在输入框内的提示文字
          suffixIcon: SizedBox(
            width: 40,
            child: uiState.onLoading ?
            const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ) : IconButton(
                onPressed: (){
                  if(controller.text.isNotEmpty){
                    sendMessage(ref, controller);
                  }
                },
                icon: const Icon(Icons.send_outlined))
            ,
          ),)
    );
  }
}
