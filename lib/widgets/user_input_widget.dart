import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/states/chat_ui_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../injection.dart';
import '../models/message.dart';
import '../models/session.dart';
import '../states/message_state.dart';
import '../states/session_state.dart';

class UserInputWidget extends HookConsumerWidget {
  const UserInputWidget({super.key});

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
                _sendMessage(ref, controller);
              }
            },
            icon: const Icon(
              Icons.send,
            ),
          )),
    );
  }

  // 增加WidgetRef
  _sendMessage(WidgetRef ref, TextEditingController controller) async {
    final uiState = ref.watch(chatUiProvider);
    var active = ref.watch(activeSessionProvider);

    final content = controller.text;
    Message message = _createMessage(content);


    var sessionId = active?.id ?? 0;
    if (sessionId <= 0) {
      active = Session(title: content, model: uiState.model);
      // final id = await db.sessionDao.upsertSession(active);
      active = await ref
          .read(sessionStateNotifierProvider.notifier)
          .upsertSession(active);
      logger.e("active = ${active.model}  ${active.title}  ${active.id}");
      sessionId = active.id!;
      ref
          .read(sessionStateNotifierProvider.notifier)
          .setActiveSession(active.copyWith(id: sessionId));
    }

    ref.read(messageProvider.notifier).upsertMessage(
      message.copyWith(sessionId: sessionId),
    ); // 添加消息
    controller.clear();
    _requestChatGPT(ref, content, sessionId: sessionId);
  }

  Message _createMessage(
      String content, {
        String? id,
        MessageSenderType sender = MessageSenderType.user,
        int? sessionId,
      }) {
    final message = Message(
      id: id ?? uuid.v4(),
      content: content,
      sender: sender,
      timestamp: DateTime.now(),
      sessionId: sessionId ?? 0,
    );
    return message;
  }

  _requestChatGPT(
      WidgetRef ref,
      String content, {
        int? sessionId,
      }) async {
    final uiState = ref.watch(chatUiProvider);
    ref.read(chatUiProvider.notifier).setLoading(true);
    final messages = ref.watch(activeSessionMessagesProvider);
    final activeSession = ref.watch(activeSessionProvider);
    try {
      final id = uuid.v4();
      await chatService.sendMessageWithStream(
        messages,
        model: activeSession?.model ?? uiState.model,
        onSuccess: (text) {
          final message =
          _createMessage(text, id: id, sender: MessageSenderType.chatgpt, sessionId: sessionId);
          ref.read(messageProvider.notifier).upsertMessage(message);
        },
      );
    } catch (err) {
      logger.e("requestChatGPT error: $err");
    } finally {
      ref.read(chatUiProvider.notifier).setLoading(false);
    }
  }
}