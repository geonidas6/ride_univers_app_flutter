import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/friend.dart';

abstract class FriendRepository {
  Future<Either<Failure, List<Friend>>> getFriends();
  Future<Either<Failure, List<Friend>>> getPendingRequests();
  Future<Either<Failure, void>> sendFriendRequest(int friendId);
  Future<Either<Failure, void>> acceptFriendRequest(int requestId);
  Future<Either<Failure, void>> rejectFriendRequest(int requestId);
  Future<Either<Failure, void>> removeFriend(int friendId);
  Future<Either<Failure, void>> blockUser(int userId);
  Future<Either<Failure, void>> unblockUser(int userId);
  Future<Either<Failure, List<Friend>>> getBlockedUsers();
}
