import 'package:flutter_chatgpt/injection.dart';
import 'package:openai_api/openai_api.dart';
import 'package:tiktoken/tiktoken.dart';

import '../env/env.dart';
import '../models/message.dart';
import '../states/settings_state.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
class ChatgptService {
  final client = OpenaiClient(
    config: OpenaiConfig(apiKey: ''),
  );

  loadConfig() async {
    final settings = Settings.load();
    client.updateConfig(client.config.copyWith(
      apiKey: settings.apiKey,
      httpProxy: settings.httpProxy,
      baseUrl: settings.baseUrl
    ));
  }

  Future sendMessageWithStream(List<Message> messages,
      {String model = Models.gpt3_5Turbo,
      Function(String text)? onSuccess}) async {
    var request = ChatCompletionRequest(
      model: model,
      stream: true,
      messages: messages
          .map((e) => ChatMessage(
                content: e.content,
                role: e.sender == MessageSenderType.user
                    ? ChatMessageRole.user
                    : ChatMessageRole.assistant,
              ))
          .toList(),
    );

    return await client.sendChatCompletionStream(request, onSuccess: (p) {
      var text = p.choices.first.delta?.content;
      if (text != null) {
        onSuccess?.call(text);
      }
    });
  }

  Future<String> speechToText(String path) async {
    final result =
        await client.createTranscription(TranscriptionRequest(file: path));
    logger.t(result);
    return result.text;
  }
}

final maxTokens = {Models.gpt3_5Turbo: 4096, Models.gpt4: 8192};

extension on List<ChatMessage> {
  // TODO: limit text length
  void limitMessages({String model = Models.gpt3_5Turbo}) {
    assert(maxTokens[model] != null, "Model not supported");
    // encodingForModel();
  }
}

extension on OpenaiConfig {
  OpenaiConfig copyWith({String? apiKey, String? httpProxy, String? baseUrl}) {
    return OpenaiConfig(
      apiKey: apiKey ?? this.apiKey,
      httpProxy: httpProxy ?? this.httpProxy,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }
}
