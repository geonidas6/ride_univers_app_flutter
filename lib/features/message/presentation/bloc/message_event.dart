part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

class LoadConversations extends MessageEvent {}

class LoadMessages extends MessageEvent {
  final String userId;

  const LoadMessages(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SendMessage extends MessageEvent {
  final String receiverId;
  final String messageText;
  final String messageType;
  final String? mediaUrl;

  const SendMessage({
    required this.receiverId,
    required this.messageText,
    required this.messageType,
    this.mediaUrl,
  });

  @override
  List<Object?> get props => [receiverId, messageText, messageType, mediaUrl];
}

class DeleteMessage extends MessageEvent {
  final String messageId;

  const DeleteMessage(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class MarkMessageAsRead extends MessageEvent {
  final String messageId;

  const MarkMessageAsRead(this.messageId);

  @override
  List<Object?> get props => [messageId];
}
