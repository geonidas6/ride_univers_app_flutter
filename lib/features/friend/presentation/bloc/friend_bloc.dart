import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_repository.dart';
import '../../../../core/error/failures.dart';

part 'friend_event.dart';
part 'friend_state.dart';

@injectable
class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final FriendRepository _friendRepository;

  FriendBloc(this._friendRepository) : super(FriendInitial()) {
    on<LoadFriends>(_onLoadFriends);
    on<SendFriendRequest>(_onSendFriendRequest);
    on<AcceptFriendRequest>(_onAcceptFriendRequest);
    on<RejectFriendRequest>(_onRejectFriendRequest);
    on<BlockFriend>(_onBlockFriend);
    on<UnblockFriend>(_onUnblockFriend);
  }

  Future<void> _onLoadFriends(
      LoadFriends event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final result = await _friendRepository.getFriends();
      result.fold(
        (failure) => emit(FriendError(failure.message)),
        (friends) => emit(FriendsLoaded(friends)),
      );
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  Future<void> _onSendFriendRequest(
      SendFriendRequest event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final result = await _friendRepository.sendFriendRequest(event.friendId);
      result.fold(
        (failure) => emit(FriendError(failure.message)),
        (_) => emit(FriendRequestSent(Friend(
          id: 0,
          nom: '',
          prenoms: '',
          email: '',
          followersCount: 0,
          followingCount: 0,
          postsCount: 0,
          batteryLevel: 0,
          totalDistance: 0,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ))),
      );
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  Future<void> _onAcceptFriendRequest(
      AcceptFriendRequest event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final result =
          await _friendRepository.acceptFriendRequest(event.friendId);
      result.fold(
        (failure) => emit(FriendError(failure.message)),
        (_) => emit(FriendRequestAccepted(Friend(
          id: 0,
          nom: '',
          prenoms: '',
          email: '',
          followersCount: 0,
          followingCount: 0,
          postsCount: 0,
          totalDistance: 0,
          batteryLevel: 0,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ))),
      );
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  Future<void> _onRejectFriendRequest(
      RejectFriendRequest event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final result =
          await _friendRepository.rejectFriendRequest(event.friendId);
      result.fold(
        (failure) => emit(FriendError(failure.message)),
        (_) => emit(FriendRequestRejected(Friend(
          id: 0,
          nom: '',
          prenoms: '',
          email: '',
          followersCount: 0,
          followingCount: 0,
          postsCount: 0,
          totalDistance: 0,
          batteryLevel: 0,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ))),
      );
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  Future<void> _onBlockFriend(
      BlockFriend event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final result = await _friendRepository.blockUser(event.friendId);
      result.fold(
        (failure) => emit(FriendError(failure.message)),
        (_) => emit(FriendBlocked(Friend(
          id: 0,
          nom: '',
          prenoms: '',
          email: '',
          followersCount: 0,
          followingCount: 0,
          postsCount: 0,
          totalDistance: 0,
          batteryLevel: 0,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ))),
      );
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }

  Future<void> _onUnblockFriend(
      UnblockFriend event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final result = await _friendRepository.unblockUser(event.friendId);
      result.fold(
        (failure) => emit(FriendError(failure.message)),
        (_) => emit(FriendUnblocked(Friend(
          id: 0,
          nom: '',
          prenoms: '',
          email: '',
          followersCount: 0,
          followingCount: 0,
          postsCount: 0,
          totalDistance: 0,
          batteryLevel: 0,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ))),
      );
    } catch (e) {
      emit(FriendError(e.toString()));
    }
  }
}
