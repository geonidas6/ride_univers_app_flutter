part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class ConversationsLoaded extends MessageState {
  final List<Conversation> conversations;

  const ConversationsLoaded(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

class MessagesLoaded extends MessageState {
  final List<Message> messages;

  const MessagesLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class MessageSent extends MessageState {
  final Message message;

  const MessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

class MessageDeleted extends MessageState {}

class MessageMarkedAsRead extends MessageState {}

class MessageError extends MessageState {
  final String message;

  const MessageError(this.message);

  @override
  List<Object?> get props => [message];
}
