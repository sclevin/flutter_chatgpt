import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openai_api/openai_api.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/19

class ChatUiState{
  final bool onLoading;

  final String model;

  ChatUiState({
    this.onLoading = false,
    this.model = Models.gpt3_5Turbo
  });
}


class ChatUiStateProvider extends StateNotifier<ChatUiState> {
  ChatUiStateProvider(): super(ChatUiState(onLoading: false));

    void setLoading(bool loading) {
      state = ChatUiState(onLoading: loading);
    }

     set model(String model){
      state = ChatUiState(model: model);
    }
}

final chatUiProvider = StateNotifierProvider<ChatUiStateProvider, ChatUiState>(
    (ref) => ChatUiStateProvider());