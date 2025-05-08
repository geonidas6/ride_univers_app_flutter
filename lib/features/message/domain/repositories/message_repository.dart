import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<Conversation>>> getConversations();
  Future<Either<Failure, List<Message>>> getMessages(int userId);
  Future<Either<Failure, Message>> sendMessage({
    required int receiverId,
    required String messageType,
    String? messageText,
    String? mediaPath,
  });
  Future<Either<Failure, void>> deleteMessage(int messageId);
  Future<Either<Failure, void>> markMessageAsRead(int messageId);
}
