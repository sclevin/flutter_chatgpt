import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/models/session.dart';
import 'package:flutter_chatgpt/states/session_state.dart';
import 'package:flutter_chatgpt/utils/file_utils.dart';
import 'package:flutter_chatgpt/utils/share_utils.dart';
import 'package:flutter_chatgpt/widgets/chat_gpt_model_widget.dart';
import 'package:flutter_chatgpt/widgets/chat_input_widget.dart';
import 'package:flutter_chatgpt/widgets/message_list_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import '../states/chat_ui_state.dart';
import '../utils/platform_utils.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
class ChatScreen extends HookConsumerWidget {
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession = ref.watch(activeSessionProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GptModelWidget(
                active: activeSession?.model,
                onModelChange: (model) {
                  ref.read(chatUiProvider.notifier).model = model;
                },
              ),
              activeSession != null
                  ? _buildExport(activeSession, ref)
                  : const SizedBox()
            ],
          ),
          const Expanded(
            child: MessageListWidget(),
          ),
          const ChatInputWidget()
        ],
      ),
    );
  }

  _buildExport(Session activeSession, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            if (isDesktop()) {
              final path = await saveAs(fileName: "${activeSession.title}.md");
              if (path == null) return;

              exportService.exportMarkdown(activeSession, path: path);
            } else {
              final path = await exportService.exportMarkdown(activeSession);
              if (path == null) return;
              shareFiles([path]);
            }
          },
          icon: const Icon(Icons.text_snippet_outlined),
        ),
        // IconButton(
        //   onPressed: ()  {
        //     exportService.exportImage(activeSession,ref.context,);
        //
        //   },
        //   icon: const Icon(Icons.image_outlined),
        // ),
      ],
    );
  }
}
