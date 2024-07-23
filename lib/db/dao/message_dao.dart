import 'package:floor/floor.dart';
import 'package:flutter_chatgpt/models/message.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23
@dao
abstract class MessageDao{
  @Query('SELECT * FROM Message')
  Future<List<Message>> findAllMessages();

  @Query('SELECT * FROM Message WHERE id = :id')
  Future<Message?> findMessageById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertMessage(Message message);

  @delete
  Future<void> deleteMessage(Message message);

  @Query('SELECT * FROM Message WHERE session_id = :sessionId')
  Future<List<Message>> findMessagesBySessionId(int sessionId);
}