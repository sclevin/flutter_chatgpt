import 'package:floor/floor.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

enum MessageSenderType { user, chatgpt }

extension MessageExtension on Message {
  Message copyWith(
      {String? id,
      String? content,
      MessageSenderType? sender,
      DateTime? timestamp,
      int? sessionId}) {
    return Message(
        id: id ?? this.id,
        content: content ?? this.content,
        sender: sender ?? this.sender,
        timestamp: timestamp ?? this.timestamp,
        sessionId: sessionId ?? this.sessionId);
  }
}

@entity
class Message {
  @primaryKey
  final String id;
  final String content;
  final MessageSenderType sender;
  final DateTime timestamp;

  @ColumnInfo(name: "session_id")
  final int sessionId;

  @ForeignKey(
      childColumns: ["session_id"], parentColumns: ["id"], entity: Message)
  Message(
      {required this.id,
      required this.content,
      required this.sender,
      required this.timestamp,
      required this.sessionId});
}
