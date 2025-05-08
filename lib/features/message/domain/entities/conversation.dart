import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'message.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation extends Equatable {
  final String id;
  final String name;
  final String senderId;
  final String receiverId;
  final String lastMessage;
  final DateTime lastMessageTime;

  const Conversation({
    required this.id,
    required this.name,
    required this.senderId,
    required this.receiverId,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);

  @override
  List<Object?> get props =>
      [id, name, senderId, receiverId, lastMessage, lastMessageTime];
}
