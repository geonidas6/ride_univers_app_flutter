import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nom,
    required String prenoms,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> updateProfile({
    String? nom,
    String? prenoms,
    String? avatar,
    String? bio,
    String? discipline,
    String? niveau,
    String? ville,
  });

  Future<Either<Failure, User>> checkAuthStatus();
}
