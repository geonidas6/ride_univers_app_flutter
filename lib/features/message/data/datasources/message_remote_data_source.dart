import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';

abstract class MessageRemoteDataSource {
  Future<List<Conversation>> getConversations();
  Future<List<Message>> getMessages(int userId);
  Future<Message> sendMessage({
    required int receiverId,
    required String messageType,
    String? messageText,
    String? mediaPath,
  });
  Future<void> deleteMessage(int messageId);
  Future<void> markMessageAsRead(int messageId);
}

@Injectable(as: MessageRemoteDataSource)
class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final Dio dio;

  MessageRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Conversation>> getConversations() async {
    final response = await dio.get('/conversations');
    return (response.data['data'] as List)
        .map((json) => Conversation.fromJson(json))
        .toList();
  }

  @override
  Future<List<Message>> getMessages(int userId) async {
    final response = await dio.get('/messages/$userId');
    return (response.data['data'] as List)
        .map((json) => Message.fromJson(json))
        .toList();
  }

  @override
  Future<Message> sendMessage({
    required int receiverId,
    required String messageType,
    String? messageText,
    String? mediaPath,
  }) async {
    final formData = FormData.fromMap({
      'receiver_id': receiverId,
      'message_type': messageType,
      if (messageText != null) 'message_text': messageText,
      if (mediaPath != null) 'media': await MultipartFile.fromFile(mediaPath),
    });

    final response = await dio.post('/messages', data: formData);
    return Message.fromJson(response.data['data']);
  }

  @override
  Future<void> deleteMessage(int messageId) async {
    await dio.delete('/messages/$messageId');
  }

  @override
  Future<void> markMessageAsRead(int messageId) async {
    await dio.put('/messages/$messageId/read');
  }
}
