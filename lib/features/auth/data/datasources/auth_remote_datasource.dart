import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nom,
    required String prenoms,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();

  Future<void> updateProfile({
    String? nom,
    String? prenoms,
    String? avatar,
    String? bio,
    String? discipline,
    String? niveau,
    String? ville,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String baseUrl =
      'https://riderbackend.sefapanel.com/api'; // URL de production

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Sauvegarder le token
      await sharedPreferences.setString('token', responseData['token']);
      // Sauvegarder l'utilisateur
      await sharedPreferences.setString(
          'user', json.encode(responseData['user']));
      return UserModel.fromJson(responseData['user']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nom,
    required String prenoms,
  }) async {
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
      // Sauvegarder le token
      await sharedPreferences.setString('token', responseData['token']);
      // Sauvegarder l'utilisateur
      await sharedPreferences.setString(
          'user', json.encode(responseData['user']));
      return UserModel.fromJson(responseData['user']);
    } else {
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

  @override
  Future<UserModel> getCurrentUser() async {
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
      return UserModel.fromJson(responseData);
    } else {
      throw ServerException();
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
}
