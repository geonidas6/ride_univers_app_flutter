import 'package:equatable/equatable.dart';
import '../../domain/entities/ride.dart';

abstract class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object> get props => [];
}

class LoadRides extends RideEvent {}

class LoadRideById extends RideEvent {
  final String id;

  const LoadRideById(this.id);

  @override
  List<Object> get props => [id];
}

class CreateRide extends RideEvent {
  final Ride ride;

  const CreateRide(this.ride);

  @override
  List<Object> get props => [ride];
}

class UpdateRide extends RideEvent {
  final Ride ride;

  const UpdateRide(this.ride);

  @override
  List<Object> get props => [ride];
}

class DeleteRide extends RideEvent {
  final String rideId;

  const DeleteRide(this.rideId);

  @override
  List<Object> get props => [rideId];
}

class JoinRide extends RideEvent {
  final String rideId;

  const JoinRide(this.rideId);

  @override
  List<Object> get props => [rideId];
}

class LeaveRide extends RideEvent {
  final String rideId;

  const LeaveRide(this.rideId);

  @override
  List<Object> get props => [rideId];
}

class LikeRide extends RideEvent {
  final String rideId;

  const LikeRide(this.rideId);

  @override
  List<Object> get props => [rideId];
}

class UnlikeRide extends RideEvent {
  final String rideId;

  const UnlikeRide(this.rideId);

  @override
  List<Object> get props => [rideId];
}

class SearchRides extends RideEvent {
  final String? query;
  final RideType? type;
  final RideDifficulty? difficulty;
  final double? minDistance;
  final double? maxDistance;
  final DateTime? startDate;
  final DateTime? endDate;

  const SearchRides({
    this.query,
    this.type,
    this.difficulty,
    this.minDistance,
    this.maxDistance,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object> get props => [
        query ?? '',
        type ?? RideType.road,
        difficulty ?? RideDifficulty.beginner,
        minDistance ?? 0.0,
        maxDistance ?? double.infinity,
        startDate ?? DateTime.now(),
        endDate ?? DateTime.now(),
      ];
}
