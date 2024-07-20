import 'package:freezed_annotation/freezed_annotation.dart';


/// Description:
/// Author:LiaoWen
/// Date:2024/7/18
part 'message.freezed.dart';
part 'message.g.dart';

enum MessageSenderType {
  user,
  chatgpt
}

@freezed
class Message with _$Message{
  const factory Message({
    required String id,
    required String content,
    required MessageSenderType sender,
    required DateTime timestamp,
}) = _Message;

  factory Message.fromJson(Map<String,Object?> json) => _$MessageFromJson(json);
}