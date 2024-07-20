// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      sender: $enumDecode(_$MessageSenderTypeEnumMap, json['sender']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'sender': _$MessageSenderTypeEnumMap[instance.sender]!,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$MessageSenderTypeEnumMap = {
  MessageSenderType.user: 'user',
  MessageSenderType.chatgpt: 'chatgpt',
};
