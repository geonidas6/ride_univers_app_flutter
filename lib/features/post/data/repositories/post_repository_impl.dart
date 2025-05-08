import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';

@Injectable(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final result = await remoteDataSource.getPosts();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getUserPosts(int userId) async {
    try {
      final result = await remoteDataSource.getUserPosts(userId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> createPost({
    required String caption,
    String? imagePath,
  }) async {
    try {
      final result = await remoteDataSource.createPost(
        caption: caption,
        imagePath: imagePath,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> updatePost({
    required int postId,
    required String caption,
  }) async {
    try {
      final result = await remoteDataSource.updatePost(
        postId: postId,
        caption: caption,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(int postId) async {
    try {
      await remoteDataSource.deletePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likePost(int postId) async {
    try {
      await remoteDataSource.likePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlikePost(int postId) async {
    try {
      await remoteDataSource.unlikePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPostsByRide(String rideId) async {
    try {
      final result = await remoteDataSource.getPostsByRide(rideId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPostsByChallenge(
      String challengeId) async {
    try {
      final result = await remoteDataSource.getPostsByChallenge(challengeId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPostsByEvent(String eventId) async {
    try {
      final result = await remoteDataSource.getPostsByEvent(eventId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
