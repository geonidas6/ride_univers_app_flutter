import 'package:equatable/equatable.dart';
import '../../domain/entities/ride.dart';

abstract class RideState extends Equatable {
  const RideState();

  @override
  List<Object> get props => [];
}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

class RidesLoaded extends RideState {
  final List<Ride> rides;

  const RidesLoaded(this.rides);

  @override
  List<Object> get props => [rides];
}

class RideLoaded extends RideState {
  final Ride ride;

  const RideLoaded(this.ride);

  @override
  List<Object> get props => [ride];
}

class RideCreated extends RideState {
  final Ride ride;

  const RideCreated(this.ride);

  @override
  List<Object> get props => [ride];
}

class RideDeleted extends RideState {}

class RideJoined extends RideState {}

class RideLeft extends RideState {}

class RideLiked extends RideState {}

class RideUnliked extends RideState {}

class RideError extends RideState {
  final String message;

  const RideError(this.message);

  @override
  List<Object> get props => [message];
}
