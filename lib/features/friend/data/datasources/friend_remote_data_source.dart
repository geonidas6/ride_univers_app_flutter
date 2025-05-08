import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/friend.dart';

abstract class FriendRemoteDataSource {
  Future<List<Friend>> getFriends();
  Future<List<Friend>> getPendingRequests();
  Future<void> sendFriendRequest(int friendId);
  Future<void> acceptFriendRequest(int requestId);
  Future<void> rejectFriendRequest(int requestId);
  Future<void> removeFriend(int friendId);
  Future<void> blockUser(int userId);
  Future<void> unblockUser(int userId);
  Future<List<Friend>> getBlockedUsers();
}

@Injectable(as: FriendRemoteDataSource)
class FriendRemoteDataSourceImpl implements FriendRemoteDataSource {
  final Dio dio;

  FriendRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Friend>> getFriends() async {
    final response = await dio.get('/friends');
    return (response.data['data'] as List)
        .map((json) => Friend.fromJson(json))
        .toList();
  }

  @override
  Future<List<Friend>> getPendingRequests() async {
    final response = await dio.get('/friends/requests');
    return (response.data['data'] as List)
        .map((json) => Friend.fromJson(json))
        .toList();
  }

  @override
  Future<void> sendFriendRequest(int friendId) async {
    await dio.post('/friends/requests', data: {'friend_id': friendId});
  }

  @override
  Future<void> acceptFriendRequest(int requestId) async {
    await dio.put('/friends/requests/$requestId/accept');
  }

  @override
  Future<void> rejectFriendRequest(int requestId) async {
    await dio.put('/friends/requests/$requestId/reject');
  }

  @override
  Future<void> removeFriend(int friendId) async {
    await dio.delete('/friends/$friendId');
  }

  @override
  Future<void> blockUser(int userId) async {
    await dio.post('/users/block', data: {'user_id': userId});
  }

  @override
  Future<void> unblockUser(int userId) async {
    await dio.delete('/users/block/$userId');
  }

  @override
  Future<List<Friend>> getBlockedUsers() async {
    final response = await dio.get('/users/blocked');
    return (response.data['data'] as List)
        .map((json) => Friend.fromJson(json))
        .toList();
  }
}
