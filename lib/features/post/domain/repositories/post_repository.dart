import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, List<Post>>> getUserPosts(int userId);
  Future<Either<Failure, Post>> createPost({
    required String caption,
    String? imagePath,
  });
  Future<Either<Failure, Post>> updatePost({
    required int postId,
    required String caption,
  });
  Future<Either<Failure, void>> deletePost(int postId);
  Future<Either<Failure, void>> likePost(int postId);
  Future<Either<Failure, void>> unlikePost(int postId);
  Future<Either<Failure, List<Post>>> getPostsByRide(String rideId);
  Future<Either<Failure, List<Post>>> getPostsByChallenge(String challengeId);
  Future<Either<Failure, List<Post>>> getPostsByEvent(String eventId);
}
