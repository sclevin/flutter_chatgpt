import 'package:flutter_chatgpt/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

class MessageList extends StateNotifier<List<Message>>{
  MessageList():super([]);

  void addMessage(Message msg){
    state = [...state, msg];
  }
}

final messageProvider = StateNotifierProvider<MessageList,List<Message>>(
    (ref) => MessageList()
);