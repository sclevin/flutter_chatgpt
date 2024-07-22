import 'package:flutter_chatgpt/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

class MessageList extends StateNotifier<List<Message>>{
  MessageList():super([]);


  void updateMessage(Message partialMessage){
    final index = state.indexWhere((element) => element.id == partialMessage.id );
    if(index == -1){
      state = [...state,partialMessage];
    }
    else{
      final msg = state[index];
      state = [...state..[index] = partialMessage.copyWith(content: msg.content + partialMessage.content)];
    }
  }
}

final messageProvider = StateNotifierProvider<MessageList,List<Message>>(
    (ref) => MessageList()
);