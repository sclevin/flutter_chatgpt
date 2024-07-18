/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

enum MessageSenderType {
  user,
  chatgpt
}

class Message{
  final String content;
  final MessageSenderType sender;
  final DateTime timestamp;

  Message(this.content, this.sender, this.timestamp);
}