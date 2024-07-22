import 'package:openai_api/openai_api.dart';

import '../env/env.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
class ChatgptService{
  final client = OpenaiClient(
      config: OpenaiConfig(
        apiKey: Env.apiKey,
        baseUrl: Env.baseUrl,  // 如果有自建OpenAI服务请设置这里，如果你自己的代理服务器不太稳定，这里可以配置为 https://openai.mignsin.workers.dev/v1
        httpProxy: Env.httpProxy,  // 代理服务地址，比如 clashx，你可以使用 http://127.0.0.1:7890
      )
  );



  Future sendMessageWithStream(String content,{Function(String text)? onSuccess}) async {
    var request = ChatCompletionRequest(
        model: Models.gpt3_5Turbo,
        stream: true,
        messages: [
      ChatMessage(content: content,role: ChatMessageRole.user)
    ]);

    await client.sendChatCompletionStream(request,onSuccess: (p){
      var text = p.choices.first.delta?.content;
      if(text != null){
        onSuccess?.call(text);
      }
    });
  }
}