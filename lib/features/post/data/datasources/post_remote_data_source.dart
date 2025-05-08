import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/post.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getPosts();
  Future<List<Post>> getUserPosts(int userId);
  Future<Post> createPost({
    required String caption,
    String? imagePath,
  });
  Future<Post> updatePost({
    required int postId,
    required String caption,
  });
  Future<void> deletePost(int postId);
  Future<void> likePost(int postId);
  Future<void> unlikePost(int postId);
  Future<List<Post>> getPostsByRide(String rideId);
  Future<List<Post>> getPostsByChallenge(String challengeId);
  Future<List<Post>> getPostsByEvent(String eventId);
}

@Injectable(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Post>> getPosts() async {
    final response = await dio.get('/posts');
    return (response.data['data'] as List)
        .map((json) => Post.fromJson(json))
        .toList();
  }

  @override
  Future<List<Post>> getUserPosts(int userId) async {
    final response = await dio.get('/users/$userId/posts');
    return (response.data['data'] as List)
        .map((json) => Post.fromJson(json))
        .toList();
  }

  @override
  Future<Post> createPost({
    required String caption,
    String? imagePath,
  }) async {
    final formData = FormData.fromMap({
      'caption': caption,
      if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
    });

    final response = await dio.post('/posts', data: formData);
    return Post.fromJson(response.data['data']);
  }

  @override
  Future<Post> updatePost({
    required int postId,
    required String caption,
  }) async {
    final response = await dio.put(
      '/posts/$postId',
      data: {'caption': caption},
    );
    return Post.fromJson(response.data['data']);
  }

  @override
  Future<void> deletePost(int postId) async {
    await dio.delete('/posts/$postId');
  }

  @override
  Future<void> likePost(int postId) async {
    await dio.post('/posts/$postId/like');
  }

  @override
  Future<void> unlikePost(int postId) async {
    await dio.delete('/posts/$postId/like');
  }

  @override
  Future<List<Post>> getPostsByRide(String rideId) async {
    final response = await dio.get('/rides/$rideId/posts');
    return (response.data['data'] as List)
        .map((json) => Post.fromJson(json))
        .toList();
  }

  @override
  Future<List<Post>> getPostsByChallenge(String challengeId) async {
    final response = await dio.get('/challenges/$challengeId/posts');
    return (response.data['data'] as List)
        .map((json) => Post.fromJson(json))
        .toList();
  }

  @override
  Future<List<Post>> getPostsByEvent(String eventId) async {
    final response = await dio.get('/events/$eventId/posts');
    return (response.data['data'] as List)
        .map((json) => Post.fromJson(json))
        .toList();
  }
}
