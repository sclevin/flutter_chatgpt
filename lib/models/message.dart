import 'package:floor/floor.dart';
import 'package:flutter_chatgpt/models/session.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

@entity
class Message {
  @primaryKey
  final String id;
  final String content;
  final MessageSenderType sender;
  final DateTime timestamp;

  // TODO: fix the bug that message cannot be deleted when session is deleted
  @ForeignKey(
    childColumns: ['session_id'],
    parentColumns: ['id'],
    entity: Session,
    onDelete: ForeignKeyAction.cascade
  )
  @ColumnInfo(name: 'session_id')
  final int? sessionId;

  Message(
      {required this.id,
      required this.content,
      required this.sender,
      required this.timestamp,
      this.sessionId});

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is Message && other.id == id;
  }

  @override
  int get hashCode =>
      id.hashCode ^ content.hashCode ^ sender.hashCode ^ timestamp.hashCode;
}

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
