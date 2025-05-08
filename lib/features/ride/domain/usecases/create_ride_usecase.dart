import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/ride.dart';
import '../repositories/ride_repository.dart';

@injectable
class CreateRideUseCase {
  final RideRepository repository;

  CreateRideUseCase(this.repository);

  Future<Either<Failure, Ride>> call(Ride ride) async {
    return repository.createRide(ride);
  }
}
