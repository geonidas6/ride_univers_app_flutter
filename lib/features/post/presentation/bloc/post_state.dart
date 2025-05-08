part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostCreated extends PostState {
  final Post post;

  const PostCreated(this.post);

  @override
  List<Object?> get props => [post];
}

class PostUpdated extends PostState {
  final Post post;

  const PostUpdated(this.post);

  @override
  List<Object?> get props => [post];
}

class PostDeleted extends PostState {}

class PostLiked extends PostState {
  const PostLiked();

  @override
  List<Object?> get props => [];
}

class PostUnliked extends PostState {
  const PostUnliked();

  @override
  List<Object?> get props => [];
}

class UserPostsLoaded extends PostState {
  final List<Post> posts;

  const UserPostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class RidePostsLoaded extends PostState {
  final List<Post> posts;

  const RidePostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class ChallengePostsLoaded extends PostState {
  final List<Post> posts;

  const ChallengePostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class EventPostsLoaded extends PostState {
  final List<Post> posts;

  const EventPostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object?> get props => [message];
}
