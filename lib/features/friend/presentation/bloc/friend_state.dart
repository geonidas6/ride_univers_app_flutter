part of 'friend_bloc.dart';

abstract class FriendState extends Equatable {
  const FriendState();

  @override
  List<Object?> get props => [];
}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendsLoaded extends FriendState {
  final List<Friend> friends;

  const FriendsLoaded(this.friends);

  @override
  List<Object?> get props => [friends];
}

class FriendRequestSent extends FriendState {
  final Friend friend;

  const FriendRequestSent(this.friend);

  @override
  List<Object?> get props => [friend];
}

class FriendRequestAccepted extends FriendState {
  final Friend friend;

  const FriendRequestAccepted(this.friend);

  @override
  List<Object?> get props => [friend];
}

class FriendRequestRejected extends FriendState {
  final Friend friend;

  const FriendRequestRejected(this.friend);

  @override
  List<Object?> get props => [friend];
}

class FriendBlocked extends FriendState {
  final Friend friend;

  const FriendBlocked(this.friend);

  @override
  List<Object?> get props => [friend];
}

class FriendUnblocked extends FriendState {
  final Friend friend;

  const FriendUnblocked(this.friend);

  @override
  List<Object?> get props => [friend];
}

class FriendError extends FriendState {
  final String message;

  const FriendError(this.message);

  @override
  List<Object?> get props => [message];
}
