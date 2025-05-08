import 'package:dartz/dartz.dart';
import '../entities/ride.dart';
import '../../../../core/error/failures.dart';

abstract class RideRepository {
  Future<Either<Failure, List<Ride>>> getRides();
  Future<Either<Failure, Ride>> getRideById(String id);
  Future<Either<Failure, List<Ride>>> getUserRides(String userId);
  Future<Either<Failure, Ride>> createRide(Ride ride);
  Future<Either<Failure, Ride>> updateRide(Ride ride);
  Future<Either<Failure, void>> deleteRide(String id);
  Future<Either<Failure, void>> joinRide(String id);
  Future<Either<Failure, void>> leaveRide(String id);
  Future<Either<Failure, void>> likeRide(String rideId);
  Future<Either<Failure, void>> unlikeRide(String rideId);
  Future<Either<Failure, List<Ride>>> searchRides({
    String? query,
    RideType? type,
    RideDifficulty? difficulty,
    double? minDistance,
    double? maxDistance,
    DateTime? startDate,
    DateTime? endDate,
  });
}


