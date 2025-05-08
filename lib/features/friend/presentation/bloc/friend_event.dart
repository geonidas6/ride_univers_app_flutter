part of 'friend_bloc.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object> get props => [];
}

class LoadFriends extends FriendEvent {}

class SendFriendRequest extends FriendEvent {
  final int friendId;

  const SendFriendRequest(this.friendId);

  @override
  List<Object> get props => [friendId];
}

class AcceptFriendRequest extends FriendEvent {
  final int friendId;

  const AcceptFriendRequest(this.friendId);

  @override
  List<Object> get props => [friendId];
}

class RejectFriendRequest extends FriendEvent {
  final int friendId;

  const RejectFriendRequest(this.friendId);

  @override
  List<Object> get props => [friendId];
}

class BlockFriend extends FriendEvent {
  final int friendId;

  const BlockFriend(this.friendId);

  @override
  List<Object> get props => [friendId];
}

class UnblockFriend extends FriendEvent {
  final int friendId;

  const UnblockFriend(this.friendId);

  @override
  List<Object> get props => [friendId];
}
