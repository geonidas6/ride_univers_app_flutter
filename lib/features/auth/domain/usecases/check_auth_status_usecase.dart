import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@injectable
class CheckAuthStatusUseCase {
  final AuthRepository _repository;

  CheckAuthStatusUseCase(this._repository);

  Future<Either<Failure, User>> call() async {
    return await _repository.checkAuthStatus();
  }
}
