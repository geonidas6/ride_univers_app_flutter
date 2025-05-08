import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/ride.dart';
import '../../domain/repositories/ride_repository.dart';
import '../datasources/ride_remote_data_source.dart';
import '../../../../core/network_info/network_info.dart';

@LazySingleton(as: RideRepository)
class RideRepositoryImpl implements RideRepository {
  final RideRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RideRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Ride>>> getRides() async {
    if (await networkInfo.isConnected) {
      try {
        final rides = await remoteDataSource.getRides();
        return Right(rides);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Ride>> getRideById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final ride = await remoteDataSource.getRideById(id);
        return Right(ride);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ride>>> getUserRides(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final rides = await remoteDataSource.getUserRides(userId);
        return Right(rides);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Ride>> createRide(Ride ride) async {
    if (await networkInfo.isConnected) {
      try {
        final createdRide = await remoteDataSource.createRide(ride);
        return Right(createdRide);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Ride>> updateRide(Ride ride) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedRide = await remoteDataSource.updateRide(ride);
        return Right(updatedRide);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteRide(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteRide(id);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> joinRide(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.joinRide(id);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> leaveRide(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.leaveRide(id);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likeRide(String rideId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.likeRide(rideId);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unlikeRide(String rideId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.unlikeRide(rideId);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ride>>> searchRides({
    String? query,
    RideType? type,
    RideDifficulty? difficulty,
    double? minDistance,
    double? maxDistance,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final rides = await remoteDataSource.searchRides(
          query: query,
          type: type,
          difficulty: difficulty,
          minDistance: minDistance,
          maxDistance: maxDistance,
          startDate: startDate,
          endDate: endDate,
        );
        return Right(rides);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
