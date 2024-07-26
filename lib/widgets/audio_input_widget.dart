import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/widgets/chat_input_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/26

class AudioInputWidget extends HookConsumerWidget {
  const AudioInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recording = useState(false);

    return GestureDetector(
      onLongPressStart: (details) {
        recording.value = true;
        recordService.start();
      },
      onLongPressEnd: (details) async {
        recording.value = false;
        final path = await recordService.stop();
        if (path != null) {
          try {
            final text = await chatService.speechToText(path);
            if (text.trim().isNotEmpty) {
              sendMessageText(ref,text);
            }
          } catch (e) {
            logger.e(e);
          }
        }
      },
      onLongPressCancel: () {
        recording.value = false;
        recordService.stop();
      },
      child: ElevatedButton(
        onPressed: () {},
        child: Text(recording.value ? "Recording..." : "Hold to speak"),
      ),
    );
  }
}
