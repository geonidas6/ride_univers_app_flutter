import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/ride.dart';
import '../models/ride_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

abstract class RideRemoteDataSource {
  Future<List<Ride>> getRides();
  Future<Ride> getRideById(String id);
  Future<List<Ride>> getUserRides(String userId);
  Future<Ride> createRide(Ride ride);
  Future<Ride> updateRide(Ride ride);
  Future<void> deleteRide(String id);
  Future<void> joinRide(String id);
  Future<void> leaveRide(String id);
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
  final Dio dio;

  RideRemoteDataSourceImpl({required this.dio}) {
    dio.options.baseUrl = 'https://riderbackend.sefapanel.com/api';
  }

  @override
  Future<List<Ride>> getRides() async {
    try {
      final response = await dio.get('/rides');
      final data = response.data;
      final ridesList = (data is List)
          ? data.map((json) => RideModel.fromJson(json)).toList()
          : (data is Map && data['rides'] is List)
              ? (data['rides'] as List)
                  .map((json) => RideModel.fromJson(json))
                  .toList()
              : <Ride>[];
      return ridesList;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Ride> getRideById(String id) async {
    try {
      final response = await dio.get('/rides/$id');
      return RideModel.fromJson(response.data['ride']);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<Ride>> getUserRides(String userId) async {
    try {
      final response = await dio.get('/users/$userId/rides');
      return (response.data['rides'] as List)
          .map((json) => RideModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Ride> createRide(Ride ride) async {
    try {
      final rideModel = RideModel.fromEntity(ride);
      final response = await dio.post(
        '/rides',
        data: rideModel.toJson(),
      );
      return RideModel.fromJson(response.data['ride']);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Ride> updateRide(Ride ride) async {
    try {
      final rideModel = RideModel.fromEntity(ride);
      final response = await dio.put(
        '/rides/${ride.id}',
        data: rideModel.toJson(),
      );
      return RideModel.fromJson(response.data['ride']);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> deleteRide(String id) async {
    try {
      await dio.delete('/rides/$id');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> joinRide(String id) async {
    try {
      await dio.post('/rides/$id/join');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> leaveRide(String id) async {
    try {
      await dio.post('/rides/$id/leave');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> likeRide(String rideId) async {
    try {
      await dio.post('/rides/$rideId/like');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> unlikeRide(String rideId) async {
    try {
      await dio.post('/rides/$rideId/unlike');
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

      final response =
          await dio.get('/rides/search', queryParameters: queryParams);
      return (response.data['rides'] as List)
          .map((json) => RideModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Unknown error';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error: ${e.message}');
    }
  }
}
