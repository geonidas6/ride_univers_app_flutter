import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(PostInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
    on<LikePost>(_onLikePost);
    on<UnlikePost>(_onUnlikePost);
    on<LoadUserPosts>(_onLoadUserPosts);
    on<LoadPostsByRide>(_onLoadPostsByRide);
    on<LoadPostsByChallenge>(_onLoadPostsByChallenge);
    on<LoadPostsByEvent>(_onLoadPostsByEvent);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result = await _postRepository.getPosts();
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (posts) => emit(PostsLoaded(posts)),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result = await _postRepository.createPost(
        caption: event.caption,
        imagePath: event.imagePath,
      );
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (post) => emit(PostCreated(post)),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result = await _postRepository.updatePost(
        postId: event.postId,
        caption: event.caption,
      );
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (post) => emit(PostUpdated(post)),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result = await _postRepository.deletePost(event.postId);
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (_) => emit(PostDeleted()),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onLikePost(LikePost event, Emitter<PostState> emit) async {
    try {
      final result = await _postRepository.likePost(event.postId);
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (_) => emit(const PostLiked()),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUnlikePost(UnlikePost event, Emitter<PostState> emit) async {
    try {
      final result = await _postRepository.unlikePost(event.postId);
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (_) => emit(const PostUnliked()),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onLoadUserPosts(
      LoadUserPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result = await _postRepository.getUserPosts(event.userId);
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (posts) => emit(UserPostsLoaded(posts)),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onLoadPostsByRide(
      LoadPostsByRide event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result =
          await _postRepository.getPostsByRide(event.rideId.toString());
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (posts) => emit(RidePostsLoaded(posts)),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onLoadPostsByChallenge(
      LoadPostsByChallenge event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result = await _postRepository
          .getPostsByChallenge(event.challengeId.toString());
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (posts) => emit(ChallengePostsLoaded(posts)),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onLoadPostsByEvent(
      LoadPostsByEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result =
          await _postRepository.getPostsByEvent(event.eventId.toString());
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (posts) => emit(EventPostsLoaded(posts)),
      );
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
