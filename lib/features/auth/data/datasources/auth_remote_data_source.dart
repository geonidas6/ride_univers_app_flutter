import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/logger_service.dart';
import '../../domain/entities/user.dart';

import '../models/user_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nom,
    required String prenoms,
  });

  Future<Either<Failure, UserModel>> loginWithGoogle(String idToken);

  Future<Either<Failure, void>> forgotPassword(String email);

  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, UserModel>> getCurrentUser();

  Future<void> updateProfile({
    String? nom,
    String? prenoms,
    String? avatar,
    String? bio,
    String? discipline,
    String? niveau,
    String? ville,
  });

  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String baseUrl = 'https://riderbackend.sefapanel.com/api';

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      LoggerService.debug('Tentative de connexion avec email: $email');

      final response = await client.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      LoggerService.debug('Réponse du serveur (login): ${response.body}');
      LoggerService.debug('Status code (login): ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];

        if (token == null) {
          LoggerService.error('Token manquant dans la réponse');
          return Left(ServerFailure('Token manquant dans la réponse'));
        }

        await sharedPreferences.setString('token', token);
        LoggerService.debug('Token sauvegardé: $token');

        final userResponse = await client.get(
          Uri.parse('$baseUrl/user'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        LoggerService.debug('Réponse user (headers): ${userResponse.headers}');
        LoggerService.debug('Réponse user (body): ${userResponse.body}');
        LoggerService.debug('Status code (user): ${userResponse.statusCode}');

        if (userResponse.statusCode == 200) {
          try {
            final userData = json.decode(userResponse.body);
            LoggerService.debug('userData décodé: $userData');

            if (userData == null) {
              LoggerService.error('Données utilisateur nulles');
              return Left(ServerFailure('Données utilisateur invalides'));
            }

            final user = UserModel(
              id: (userData['id'] ?? '0').toString(),
              email: userData['email'] ?? email,
              nom: userData['nom'] ?? '',
              prenoms: userData['prenoms'] ?? '',
              avatar: userData['avatar'],
              bio: userData['bio'],
              friends: List<String>.from(userData['friends'] ?? []),
              friendRequests:
                  List<String>.from(userData['friend_requests'] ?? []),
              blockedUsers: List<String>.from(userData['blocked_users'] ?? []),
              createdAt: DateTime.parse(
                  userData['created_at'] ?? DateTime.now().toIso8601String()),
              updatedAt: DateTime.parse(
                  userData['updated_at'] ?? DateTime.now().toIso8601String()),
            );

            await sharedPreferences.setString('user', json.encode(userData));
            LoggerService.debug(
                'Utilisateur sauvegardé: ${json.encode(userData)}');

            return Right(user);
          } catch (e) {
            LoggerService.error(
                'Erreur lors du parsing des données utilisateur: ${e.toString()}');
            return Left(ServerFailure(
                'Erreur lors du parsing des données utilisateur: ${e.toString()}'));
          }
        } else {
          LoggerService.error(
              'Échec de récupération des informations utilisateur: ${userResponse.statusCode}');
          return Left(ServerFailure(
              'Échec de récupération des informations utilisateur'));
        }
      } else {
        LoggerService.error('Échec de connexion: ${response.statusCode}');
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Échec de la connexion';
        return Left(ServerFailure(errorMessage));
      }
    } catch (e) {
      LoggerService.error('Erreur lors de la connexion: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nom,
    required String prenoms,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'nom': nom,
          'prenoms': prenoms,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        await sharedPreferences.setString('token', responseData['token']);
        await sharedPreferences.setString(
            'user', json.encode(responseData['user']));
        return Right(UserModel.fromJson(responseData['user']));
      } else {
        return Left(ServerFailure('Échec de l\'inscription'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle(String idToken) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final token = sharedPreferences.getString('token');
      final response = await client.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return Right(UserModel.fromJson(responseData));
      } else {
        return Left(
            ServerFailure('Échec de la récupération de l\'utilisateur'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> updateProfile({
    String? nom,
    String? prenoms,
    String? avatar,
    String? bio,
    String? discipline,
    String? niveau,
    String? ville,
  }) async {
    final token = sharedPreferences.getString('token');
    final response = await client.put(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        if (nom != null) 'nom': nom,
        if (prenoms != null) 'prenoms': prenoms,
        if (avatar != null) 'avatar': avatar,
        if (bio != null) 'bio': bio,
        if (discipline != null) 'discipline': discipline,
        if (niveau != null) 'niveau': niveau,
        if (ville != null) 'ville': ville,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    final token = sharedPreferences.getString('token');
    final response = await client.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await sharedPreferences.remove('token');
      await sharedPreferences.remove('user');
    } else {
      throw ServerException();
    }
  }
}
