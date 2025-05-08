import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
