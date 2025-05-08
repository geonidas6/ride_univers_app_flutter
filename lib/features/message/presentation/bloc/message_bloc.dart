import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/repositories/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

@injectable
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;

  MessageBloc(this._messageRepository) : super(MessageInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<DeleteMessage>(_onDeleteMessage);
    on<MarkMessageAsRead>(_onMarkMessageAsRead);
  }

  Future<void> _onLoadConversations(
      LoadConversations event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final result = await _messageRepository.getConversations();
      result.fold(
        (failure) => emit(MessageError(failure.message)),
        (conversations) => emit(ConversationsLoaded(conversations)),
      );
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  Future<void> _onLoadMessages(
      LoadMessages event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final result =
          await _messageRepository.getMessages(int.parse(event.userId));
      result.fold(
        (failure) => emit(MessageError(failure.message)),
        (messages) => emit(MessagesLoaded(messages)),
      );
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final result = await _messageRepository.sendMessage(
        receiverId: int.parse(event.receiverId),
        messageType: event.messageType,
        messageText: event.messageText,
        mediaPath: event.mediaUrl,
      );
      result.fold(
        (failure) => emit(MessageError(failure.message)),
        (message) => emit(MessageSent(message)),
      );
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  Future<void> _onDeleteMessage(
      DeleteMessage event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final result =
          await _messageRepository.deleteMessage(int.parse(event.messageId));
      result.fold(
        (failure) => emit(MessageError(failure.message)),
        (_) => emit(MessageDeleted()),
      );
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  Future<void> _onMarkMessageAsRead(
      MarkMessageAsRead event, Emitter<MessageState> emit) async {
    try {
      final result = await _messageRepository
          .markMessageAsRead(int.parse(event.messageId));
      result.fold(
        (failure) => emit(MessageError(failure.message)),
        (_) => emit(MessageMarkedAsRead()),
      );
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}
