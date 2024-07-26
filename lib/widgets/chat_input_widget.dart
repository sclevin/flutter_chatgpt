import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/widgets/text_input_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../injection.dart';
import '../models/message.dart';
import '../models/session.dart';
import '../states/chat_ui_state.dart';
import '../states/message_state.dart';
import '../states/session_state.dart';
import 'audio_input_widget.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/26

class ChatInputWidget extends HookConsumerWidget {
  const ChatInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceMode = useState(false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: [
        IconButton(
            onPressed: () {
              voiceMode.value = !voiceMode.value;
            },
            icon: Icon(voiceMode.value
                ? Icons.keyboard_alt_outlined
                : Icons.keyboard_voice_outlined)),
        Expanded(
            child: voiceMode.value
                ? const AudioInputWidget()
                : const TextInputWidget()),
      ]),
    );
  }
}



sendMessage(WidgetRef ref, TextEditingController controller){
  final content = controller.text;
  controller.clear();
  sendMessageText(ref, content);
}

sendMessageText(WidgetRef ref, String content) async {
  final uiState = ref.watch(chatUiProvider);
  var active = ref.watch(activeSessionProvider);

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
