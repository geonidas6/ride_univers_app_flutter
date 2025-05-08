import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl(this.remoteDataSource, this.sharedPreferences);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String nom,
    required String prenoms,
    required String passwordConfirmation,
  }) async {
    return await remoteDataSource.register(
      email: email,
      password: password,
      nom: nom,
      prenoms: prenoms,
      passwordConfirmation: passwordConfirmation,
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }

  @override
  Future<Either<Failure, void>> updateProfile({
    String? nom,
    String? prenoms,
    String? avatar,
    String? bio,
    String? discipline,
    String? niveau,
    String? ville,
  }) async {
    try {
      await remoteDataSource.updateProfile(
        nom: nom,
        prenoms: prenoms,
        avatar: avatar,
        bio: bio,
        discipline: discipline,
        niveau: niveau,
        ville: ville,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> checkAuthStatus() async {
    try {
      final token = sharedPreferences.getString('token');
      if (token == null) {
        return Left(const AuthenticationFailure('Non authentifié'));
      }

      // Récupérer l'utilisateur stocké
      final userJson = sharedPreferences.getString('user');
      if (userJson == null) {
        return Left(AuthenticationFailure('Utilisateur non trouvé'));
      }

      final user = UserModel.fromJson(jsonDecode(userJson));
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
