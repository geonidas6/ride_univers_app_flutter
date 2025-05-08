import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';

@injectable
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nom,
    required String prenoms,
  }) {
    return repository.register(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      nom: nom,
      prenoms: prenoms,
    );
  }
}
