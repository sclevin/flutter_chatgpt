import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/models/message.dart';
import 'package:flutter_chatgpt/states/session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
part 'message_state.g.dart';
class MessageList extends StateNotifier<List<Message>>{
  MessageList():super([]){
    init();
  }

  Future<void> init() async {
    // TODO: Select session and then query the database for messages, instead of querying all and filtering late
    state = await db.messageDao.findAllMessages();
  }

  void upsertMessage(Message partialMessage){
    final index = state.indexWhere((element) => element.id == partialMessage.id );
    var message = partialMessage;
    if(index >= 0){
      final msg = state[index];
      message = partialMessage.copyWith(content: msg.content + partialMessage.content);
    }

    db.messageDao.upsertMessage(message);

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

@riverpod
List<Message> activeSessionMessages(ActiveSessionMessagesRef ref) {
  final active = ref.watch(activeSessionProvider);
  final messages = ref.watch(messageProvider.select((value) =>
      value.where((element) => element.sessionId == active?.id).toList()));
  return messages;
}