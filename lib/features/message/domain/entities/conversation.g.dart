// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      id: json['id'] as String,
      name: json['name'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime.toIso8601String(),
    };
