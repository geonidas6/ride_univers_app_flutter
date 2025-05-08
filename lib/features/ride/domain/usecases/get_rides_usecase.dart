import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/ride.dart';
import '../repositories/ride_repository.dart';

@injectable
class GetRidesUseCase {
  final RideRepository repository;

  GetRidesUseCase(this.repository);

  Future<Either<Failure, List<Ride>>> call() async {
    return repository.getRides();
  }
}
