import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String type;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  List<Object?> get props =>
      [id, senderId, receiverId, content, type, createdAt];
}
