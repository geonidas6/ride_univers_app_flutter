part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final String caption;
  final String? imagePath;

  const CreatePost({
    required this.caption,
    this.imagePath,
  });

  @override
  List<Object?> get props => [caption, imagePath];
}

class UpdatePost extends PostEvent {
  final int postId;
  final String caption;

  const UpdatePost({
    required this.postId,
    required this.caption,
  });

  @override
  List<Object?> get props => [postId, caption];
}

class DeletePost extends PostEvent {
  final int postId;

  const DeletePost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class LikePost extends PostEvent {
  final int postId;

  const LikePost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class UnlikePost extends PostEvent {
  final int postId;

  const UnlikePost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class LoadUserPosts extends PostEvent {
  final int userId;

  const LoadUserPosts(this.userId);

  @override
  List<Object?> get props => [userId];
}

class LoadPostsByRide extends PostEvent {
  final String rideId;

  const LoadPostsByRide(this.rideId);

  @override
  List<Object?> get props => [rideId];
}

class LoadPostsByChallenge extends PostEvent {
  final String challengeId;

  const LoadPostsByChallenge(this.challengeId);

  @override
  List<Object?> get props => [challengeId];
}

class LoadPostsByEvent extends PostEvent {
  final String eventId;

  const LoadPostsByEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}
