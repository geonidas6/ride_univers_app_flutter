import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_repository.dart';
import '../datasources/friend_remote_data_source.dart';

@Injectable(as: FriendRepository)
class FriendRepositoryImpl implements FriendRepository {
  final FriendRemoteDataSource remoteDataSource;

  FriendRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Friend>>> getFriends() async {
    try {
      final result = await remoteDataSource.getFriends();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Friend>>> getPendingRequests() async {
    try {
      final result = await remoteDataSource.getPendingRequests();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest(int friendId) async {
    try {
      await remoteDataSource.sendFriendRequest(friendId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptFriendRequest(int requestId) async {
    try {
      await remoteDataSource.acceptFriendRequest(requestId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectFriendRequest(int requestId) async {
    try {
      await remoteDataSource.rejectFriendRequest(requestId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFriend(int friendId) async {
    try {
      await remoteDataSource.removeFriend(friendId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> blockUser(int userId) async {
    try {
      await remoteDataSource.blockUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unblockUser(int userId) async {
    try {
      await remoteDataSource.unblockUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Friend>>> getBlockedUsers() async {
    try {
      final result = await remoteDataSource.getBlockedUsers();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
