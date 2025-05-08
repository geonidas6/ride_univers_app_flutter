import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/challenge.dart';

abstract class ChallengeRemoteDataSource {
  Future<List<Challenge>> getChallenges();
  Future<Challenge> getChallengeById(String id);
  Future<Challenge> createChallenge(Challenge challenge);
}

@Injectable(as: ChallengeRemoteDataSource)
class ChallengeRemoteDataSourceImpl implements ChallengeRemoteDataSource {
  final Dio _dio;
  final String _baseUrl =
      'https://api.riderunivers.com/v1'; // À adapter selon votre API

  ChallengeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Challenge>> getChallenges() async {
    try {
      final response = await _dio.get('$_baseUrl/challenges');

      if (response.statusCode == 200) {
        final List<dynamic> challengesJson = response.data['data'];
        return challengesJson.map((json) => Challenge.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Challenge> getChallengeById(String id) async {
    try {
      final response = await _dio.get('$_baseUrl/challenges/$id');

      if (response.statusCode == 200) {
        return Challenge.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Challenge> createChallenge(Challenge challenge) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/challenges',
        data: challenge.toJson(),
      );

      if (response.statusCode == 201) {
        return Challenge.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
