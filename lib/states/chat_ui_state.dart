import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/19

class ChatUiState{
  final bool onLoading;

  ChatUiState({this.onLoading = false});
}


class ChatUiStateProvider extends StateNotifier<ChatUiState> {
  ChatUiStateProvider(): super(ChatUiState(onLoading: false));

    void setLoading(bool loading) {
      state = ChatUiState(onLoading: loading);
    }
}

final chatUiProvider = StateNotifierProvider<ChatUiStateProvider, ChatUiState>(
    (ref) => ChatUiStateProvider());