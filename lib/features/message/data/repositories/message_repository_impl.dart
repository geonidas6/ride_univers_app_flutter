import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/message_remote_data_source.dart';

@LazySingleton(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      final result = await remoteDataSource.getConversations();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(int userId) async {
    try {
      final result = await remoteDataSource.getMessages(userId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage({
    required int receiverId,
    required String messageType,
    String? messageText,
    String? mediaPath,
  }) async {
    try {
      final result = await remoteDataSource.sendMessage(
        receiverId: receiverId,
        messageType: messageType,
        messageText: messageText,
        mediaPath: mediaPath,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(int messageId) async {
    try {
      await remoteDataSource.deleteMessage(messageId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead(int messageId) async {
    try {
      await remoteDataSource.markMessageAsRead(messageId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
