import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/ride.dart';
import '../repositories/ride_repository.dart';

@injectable
class GetRideByIdUseCase {
  final RideRepository repository;

  GetRideByIdUseCase(this.repository);

  Future<Either<Failure, Ride>> call(String id) async {
    return repository.getRideById(id);
  }
}
