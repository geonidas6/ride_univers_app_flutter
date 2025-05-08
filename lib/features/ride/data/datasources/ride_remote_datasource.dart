import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/ride.dart';
import '../models/ride_model.dart';

abstract class RideRemoteDataSource {
  Future<List<Ride>> getRides();
  Future<Ride> getRideById(String id);
  Future<List<Ride>> getUserRides(String userId);
  Future<Ride> createRide(Ride ride);
  Future<Ride> updateRide(Ride ride);
  Future<void> deleteRide(String id);
  Future<void> joinRide(String rideId);
  Future<void> leaveRide(String rideId);
  Future<void> likeRide(String rideId);
  Future<void> unlikeRide(String rideId);
  Future<List<Ride>> searchRides({
    String? query,
    RideType? type,
    RideDifficulty? difficulty,
    double? minDistance,
    double? maxDistance,
    DateTime? startDate,
    DateTime? endDate,
  });
}

@Injectable(as: RideRemoteDataSource)
class RideRemoteDataSourceImpl implements RideRemoteDataSource {
  final Dio _dio;

  RideRemoteDataSourceImpl()
      : _dio = Dio()..options.baseUrl = 'https://api.riderunivers.com';

  @override
  Future<List<Ride>> getRides() async {
    try {
      final response = await _dio.get('/rides');
      return (response.data['rides'] as List)
          .map((json) => RideModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Ride> getRideById(String id) async {
    try {
      final response = await _dio.get('/rides/$id');
      return RideModel.fromJson(response.data['ride']).toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<Ride>> getUserRides(String userId) async {
    try {
      final response = await _dio.get('/users/$userId/rides');
      return (response.data['rides'] as List)
          .map((json) => RideModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Ride> createRide(Ride ride) async {
    try {
      final rideModel = ride as RideModel;
      final response = await _dio.post(
        '/rides',
        data: rideModel.toJson(),
      );
      return RideModel.fromJson(response.data['ride']).toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Ride> updateRide(Ride ride) async {
    try {
      final rideModel = ride as RideModel;
      final response = await _dio.put(
        '/rides/${ride.id}',
        data: rideModel.toJson(),
      );
      return RideModel.fromJson(response.data['ride']).toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> deleteRide(String id) async {
    try {
      await _dio.delete('/rides/$id');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> joinRide(String rideId) async {
    try {
      await _dio.post('/rides/$rideId/join');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> leaveRide(String rideId) async {
    try {
      await _dio.post('/rides/$rideId/leave');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> likeRide(String rideId) async {
    try {
      await _dio.post('/rides/$rideId/like');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> unlikeRide(String rideId) async {
    try {
      await _dio.post('/rides/$rideId/unlike');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<Ride>> searchRides({
    String? query,
    RideType? type,
    RideDifficulty? difficulty,
    double? minDistance,
    double? maxDistance,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        if (query != null) 'q': query,
        if (type != null) 'type': type.toString().split('.').last,
        if (difficulty != null)
          'difficulty': difficulty.toString().split('.').last,
        if (minDistance != null) 'minDistance': minDistance.toString(),
        if (maxDistance != null) 'maxDistance': maxDistance.toString(),
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final response = await _dio.get(
        '/rides/search',
        queryParameters: queryParams,
      );

      return (response.data['rides'] as List)
          .map((json) => RideModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Erreur de connexion au serveur';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data['message'] ?? 'Une erreur est survenue';
        return '$statusCode: $message';
      case DioExceptionType.cancel:
        return 'La requête a été annulée';
      default:
        return 'Une erreur est survenue';
    }
  }
}
